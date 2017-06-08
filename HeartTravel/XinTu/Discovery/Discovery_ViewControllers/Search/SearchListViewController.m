//
//  SearchListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/7/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SearchListViewController.h"

@interface SearchListViewController ()<UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation SearchListViewController

-(void)dealloc{

    [self.listTableView release];
    [self.resultArray release];
    [self.MONAView release];
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initProperties];
    [self initTableView];
    [self initMONA];
}

-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y - 64);
    [self.view addSubview:self.MONAView];
    [self.MONAView release];
    
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)initProperties{
    self.isUpLoading = NO;
    self.resultArray = [NSMutableArray array];
    self.page = 1;
}

-(void)initTableView{
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.listTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tableFooterView.backgroundColor = [UIColor purpleColor];
    [self.listTableView addFooterWithCallback:^{
        self.isUpLoading = YES;
        self.page++;
        [self beginSearch];
    }];
    [self.view addSubview:self.listTableView];
    [self.listTableView release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"searchCell";
    SearchListCell * sCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (sCell == nil) {
        sCell = [[SearchListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    sCell.searchResult = [self.resultArray objectAtIndex:indexPath.row];
    return sCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (CGRectGetWidth([[UIScreen mainScreen]bounds]) - RESULT_CELL_INSET*2)/4 + RESULT_CELL_INSET * 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchResult * sr = [self.resultArray objectAtIndex:indexPath.row];
    [self.myDelegate gotoDetailPageWithType:sr.type andResultID:sr.resultID];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSearchKeyWord:(NSString *)searchKeyWord{
    if (_searchKeyWord != searchKeyWord) {
        [_searchKeyWord release];
        _searchKeyWord = [searchKeyWord retain];
    }
    if (self.resultArray.count != 0){
        [self.resultArray removeAllObjects];
    }
    [self beginSearch];
}

-(void)beginSearch{
    
    //由于URL中有百分号出现,UTF8转码之后 百分号会被转换掉,所以这里单独对搜索关键字进行UTF8转码
    if (self.isUpLoading == NO) {
        [self.MONAView startAnimating];
    }
    NSString * keyUTF8 = [self.searchKeyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * urlStr = [NSString stringWithFormat:SEARCH_LIST_URL,keyUTF8,self.page];

    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSDictionary * dataDic = [data objectForKey:@"data"];
        NSArray * dataArray = [dataDic objectForKey:@"entry"];
        for (NSDictionary * dic  in dataArray) {
            SearchResult * sr = [[SearchResult alloc]init];
            [sr setValuesForKeysWithDictionary:dic];
            [self.resultArray addObject:sr];
            [sr release];
        }
        if (self.isUpLoading == NO) {
            [self.MONAView stopAnimating];
        }
        [self.listTableView reloadData];
        [self.listTableView footerEndRefreshing];
        
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
}


@end
