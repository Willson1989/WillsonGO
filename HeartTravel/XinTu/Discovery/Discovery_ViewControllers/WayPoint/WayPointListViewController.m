//
//  WayPointListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WayPointListViewController.h"

@interface WayPointListViewController ()<UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation WayPointListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self setupNavigationItem];
    [self initMONA];
    [self getWayPoiListDataByAFN];
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

-(void)initProperties{
    self.page = 0;
    self.typeArray = [NSMutableArray array];
    self.wPointListArray = [NSMutableArray array];
    self.isFirstLoad = YES;
    self.isUpLoad = NO;
    self.isDownLoad = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setupNavigationItem{
    [PublicFunction setupNavigationBarforViewController:self];
    self.navigationItem.title = self.wayPoiTitle;
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                                    64,
                                                                    CGRectGetWidth([[UIScreen mainScreen]bounds]),
                                                                    CGRectGetHeight([[UIScreen mainScreen]bounds]))style:
                                                                    UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self addHeaderRefresher];
    [self addFooterRefresher];
    [self.view addSubview:self.myTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.wPointListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetWidth([[UIScreen mainScreen]bounds])/4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID = @"cell";
    WayPointListCell * wpCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (wpCell == nil) {
        wpCell = [[WayPointListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    wpCell.wayPointList = [self.wPointListArray objectAtIndex:indexPath.row];
    wpCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return wpCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WayPointDetailViewController * wpDetail = [[WayPointDetailViewController alloc]init];
    WayPointList * wpl = (WayPointList*)[self.wPointListArray objectAtIndex:indexPath.row];
    NSInteger pid = [wpl wayPointID];
    NSString * poi_id = [NSString stringWithFormat:@"%li",pid];
    wpDetail.poi_id = poi_id;
    wpDetail.cname = wpl.chinesename;
    wpDetail.ename = wpl.englishname;
    [self.navigationController pushViewController:wpDetail animated:YES];
}

-(void)getWayPoiListDataByAFN{
    
    if (!self.isDownLoad && !self.isUpLoad) {
        [self.MONAView startAnimating];
    }
    NSString * urlStr = [NSString stringWithFormat:WAYPOINT_LIST_URL,self.cat_ID,self.city_id,self.page];
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSDictionary * dataDic = [(NSMutableDictionary *)data objectForKey:@"data"];
        NSMutableArray * entry = [dataDic objectForKey:@"entry"];
        NSMutableArray * types = [dataDic objectForKey:@"types"];
        if (self.isDownLoad && !self.isUpLoad) {
            [self.wPointListArray removeAllObjects];
        }
        for (NSMutableDictionary * dic  in entry) {
            WayPointList * wpList = [[WayPointList alloc]init];
            [wpList setValuesForKeysWithDictionary:dic];
            [self.wPointListArray addObject:wpList];
        }
        for (NSMutableDictionary * dic  in types) {
            pointType * ptype = [[pointType alloc]init];
            [ptype setValuesForKeysWithDictionary:dic];
            [self.typeArray addObject:ptype];
        }
        if (!self.isUpLoad && !self.isDownLoad) {
            [self.MONAView stopAnimating];
        }
        
        if (self.isFirstLoad == YES) {
            [self setupTableView];
            self.isFirstLoad = NO;
        }
        else{
            [self.myTableView reloadData];
            
            [self.myTableView footerEndRefreshing];
            [self.myTableView headerEndRefreshing];
        }
        
    } failure:^{
        [self.MONAView stopAnimating];
        [self.myTableView footerEndRefreshing];
        [self.myTableView headerEndRefreshing];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

-(void)addHeaderRefresher{
    [self.myTableView addHeaderWithCallback:^{
        self.page = 1;
        self.isUpLoad = NO;
        self.isDownLoad = YES;
//        [self.wPointListArray removeAllObjects];
        [self getWayPoiListDataByAFN];
    }];
}

-(void)addFooterRefresher{
    [self.myTableView addFooterWithCallback:^{
        self.page++;
        self.isUpLoad = YES;
        self.isDownLoad = NO;
        [self getWayPoiListDataByAFN];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
