//
//  HotSearchViewController.m
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotSearchViewController.h"

@interface HotSearchViewController ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation HotSearchViewController

-(void)dealloc{
    [self.hotTableView release];
    [self.hotArray release];
    [self.historyArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self initProperties];
    [self initTableView];
    [self requestHotSearchData];
}

-(void)initProperties{
    self.hotArray = [NSMutableArray array];
    self.historyArray = [NSMutableArray arrayWithArray:(NSArray*)[[NSUserDefaults standardUserDefaults] objectForKey:HISTORY_ARR]];
    if (self.historyArray == nil) {
        self.historyArray = [NSMutableArray array];
    }
}

-(void)initTableView{
    self.hotTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    self.hotTableView.delegate = self;
    self.hotTableView.dataSource = self;
    [self.view addSubview:self.hotTableView];
    [self.hotTableView release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.historyArray.count != 0) {
        return 2;
    }
    else
        return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.historyArray.count != 0) {
        if (section == 0) {
            return self.historyArray.count;
        }
        else{
            return self.hotArray.count;
        }
    }
    else{
        return self.hotArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * IDhot = @"hotCell";
    static NSString * IDHis = @"historyCell";
    if (self.historyArray.count != 0) {
        if (indexPath.section == 0) {
            UITableViewCell * hisCell = [tableView dequeueReusableCellWithIdentifier:IDHis];
            if (hisCell == nil) {
                hisCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDHis];
            }
            hisCell.textLabel.text = [self.historyArray objectAtIndex:indexPath.row];
            hisCell.textLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
            return hisCell;
        }
        else{
            
            UITableViewCell * hotCell = [tableView dequeueReusableCellWithIdentifier:IDhot];
            if (hotCell == nil) {
                hotCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDhot];
            }
            hotCell.textLabel.text = [self.hotArray objectAtIndex:indexPath.row];
            hotCell.textLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
            return hotCell;
        }
    }
    else{
        UITableViewCell * hotCell = [tableView dequeueReusableCellWithIdentifier:IDhot];
        if (hotCell == nil) {
            hotCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDhot];
        }
        hotCell.textLabel.text = [self.hotArray objectAtIndex:indexPath.row];
        hotCell.textLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
        return hotCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.historyArray.count != 0) {
        if (section == 0) {
            return @"历史记录";
        }
        else{
            return @"热门搜索";
        }
    }
    else{
        return @"热门搜索";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * keyWord = [NSString string];
    [self.myDelegate resignSearchBarFirstResponder];
    if (self.historyArray.count != 0) {
        if (indexPath.section == 0) {
            keyWord = [self.historyArray objectAtIndex:indexPath.row];
        }
        else{
            keyWord = [self.hotArray objectAtIndex:indexPath.row];
        }
        
        [self.myDelegate changeContentOfSearchBar:keyWord];
        [self saveKeyWordToHisArray:keyWord];
        [self.myDelegate clickedToSearchListpageFromHotSearchWithKeyWord:keyWord];
    }
    else{
        keyWord = [self.hotArray objectAtIndex:indexPath.row];
        [self.myDelegate changeContentOfSearchBar:keyWord];
        [self saveKeyWordToHisArray:keyWord];
        [self.myDelegate clickedToSearchListpageFromHotSearchWithKeyWord:keyWord];
    }
    [self.hotTableView reloadData];
}


-(void)saveKeyWordToHisArray:(NSString*)keyWord{
    
    NSArray * tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:HISTORY_ARR];
    [self.historyArray removeAllObjects];
    [self.historyArray addObjectsFromArray:tempArray];
    if (self.historyArray == nil) {
        self.historyArray = [NSMutableArray array];
    }
    if (![self.historyArray containsObject:keyWord]) {
        if (self.historyArray.count > 9) {
            [self.historyArray removeObjectAtIndex:0];
        }
        [self.historyArray addObject:keyWord];
        [[NSUserDefaults standardUserDefaults] setObject:self.historyArray forKey:HISTORY_ARR];
    }
}

-(void)requestHotSearchData{
    [PublicFunction getDataByAFNetWorkingWithURL:HOT_SEARCH_URL Success:^(id data) {
        self.hotArray = (NSMutableArray *)[data objectForKey:@"data"];
        [self.hotTableView reloadData];
    }];
}

-(void)reloadTableViewAtSection:(NSInteger)section{
    NSIndexSet * indexSet = [[NSIndexSet alloc]initWithIndex:section];
    [self.hotTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    [self.hotTableView beginUpdates];
    [self.hotTableView endUpdates];
    [indexSet autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadHotTableView{
    NSArray * tempArr = [[NSUserDefaults standardUserDefaults] objectForKey:HISTORY_ARR];
    [self.historyArray removeAllObjects];
    self.historyArray = [NSMutableArray arrayWithArray:tempArr];
    [self.hotTableView reloadData];
}

@end
