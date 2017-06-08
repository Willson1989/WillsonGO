//
//  SearchTempListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SearchTempListViewController.h"

@interface SearchTempListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain,nonatomic) NSMutableArray * tempListArray;

@end

@implementation SearchTempListViewController

-(void)dealloc{
    
    [self.tempTableView release];
    self.myDelegate = nil;
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self initProperties];
    [self initTableView];
}

-(void)initProperties{
    self.tempListArray = [NSMutableArray array];
}

-(void)initTableView{
    self.tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    self.tempTableView.dataSource = self;
    self.tempTableView.delegate = self;
    [self.view addSubview:self.tempTableView];
    [self.tempTableView release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"tempListCell";
    UITableViewCell * tempListCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!tempListCell) {
        tempListCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    tempListCell.textLabel.text = [[self.tempListArray objectAtIndex:indexPath.row] objectForKey:@"cnname"];
    tempListCell.textLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
    return  tempListCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), 1)];
    return [view autorelease];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * keyString = [[self.tempListArray objectAtIndex:indexPath.row] objectForKey:@"cnname"];
    [self.myDelegate switchToSearchListToSearchByKeyword:keyString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requsetData:(NSString*)keyword{
    //由于URL中有百分号出现,UTF8转码之后 百分号会被转换掉,所以这里单独对搜索关键字进行UTF8转码
    NSString * keyUTF8 = [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * urlString = [NSString stringWithFormat:TEMP_SEARCH_URL,keyUTF8];
    [PublicFunction getDataByAFNetWorkingWithURL:urlString Success:^(id data) {
        NSDictionary * dataDic = [data objectForKey:@"data"];
        self.tempListArray = [dataDic objectForKey:@"entry"];
        [self.tempTableView reloadData];
        
    }];
}

@end
