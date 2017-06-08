//
//  HotGuideListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotGuideListViewController.h"

@interface HotGuideListViewController ()<UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation HotGuideListViewController

-(void)dealloc{
    
    [self.guideListArray release];
    [self.myTableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.isUpLoad = NO;
    self.isDownLoad = NO;
    self.guideListArray = [NSMutableArray array];
    [self setupTableView];
    [self setNavigationItems];
}

-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:self.MONAView];
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)setupTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, CGRectGetHeight([[UIScreen mainScreen]bounds])) style:UITableViewStylePlain];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.myTableView addHeaderWithCallback:^{
        self.isUpLoad = NO;
        self.isDownLoad = YES;
        self.page = 1;
        if (self.guideListArray.count != 0) {
            [self.guideListArray removeAllObjects];
        }
        [self getGuideListDataByAFN];
    }];
    [self.myTableView addFooterWithCallback:^{
        self.page++;
        [self getGuideListDataByAFN];
        self.isUpLoad = YES;
        self.isDownLoad = NO;
    }];
    [self.view addSubview:self.myTableView];
    [self initMONA];
    [self getGuideListDataByAFN];
    [self.myTableView release];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.guideListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cell";
    HotGuideListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HotGuideListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.guideList = [self.guideListArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return GUIDE_LIST_CELL_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotGuideDetailViewController * hgDetailVC = [[HotGuideDetailViewController alloc]init];
    hgDetailVC.guideID = [[self.guideListArray objectAtIndex:indexPath.row] guideID];
    hgDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hgDetailVC animated:YES];
}

-(void)getGuideListDataByAFN{

    NSString * urlString = [NSString stringWithFormat:GUIDE_LIST_URL,self.itemID,self.page,self.itemType];
    if (!self.isUpLoad && !self.isDownLoad) {
        [self.MONAView startAnimating];
    }
    [PublicFunction getDataByAFNetWorkingWithURL:urlString Success:^(id data) {
        NSMutableArray * dataArray = [(NSMutableDictionary *)data objectForKey:@"data"];
        for (NSDictionary * dic in dataArray) {
            HotGuideList * glist = [[HotGuideList alloc]init];
            [glist setValuesForKeysWithDictionary:dic];
            [self.guideListArray addObject:glist];
            [glist release];
        }
        [self.myTableView reloadData];
        if (!self.isUpLoad && !self.isDownLoad) {
            [self.MONAView stopAnimating];
        }
        [self.myTableView footerEndRefreshing];
        [self.myTableView headerEndRefreshing];
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
}

-(void)setNavigationItems{
    [PublicFunction setupNavigationBarforViewController:self];
    self.navigationItem.title = @"全部城市";
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)headerRereshing{
    self.isUpLoad = NO;
    self.isDownLoad = YES;
    self.page = 1;
    if (self.guideListArray.count != 0) {
        [self.guideListArray removeAllObjects];
    }
    [self getGuideListDataByAFN];
}

-(void)footerRereshing{
    self.page++;
    [self getGuideListDataByAFN];
    self.isUpLoad = YES;
    self.isDownLoad = NO;
}

@end
