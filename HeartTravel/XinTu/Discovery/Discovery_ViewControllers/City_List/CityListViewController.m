//
//  CityListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CityListViewController.h"

@interface CityListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MONActivityIndicatorViewDelegate>

@end

@implementation CityListViewController

-(void)dealloc{
    
    [self.allCityCollectionView release];
    [self.layout release];
    [self.cityArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.footerRemoved = NO;
    self.isUpLoad = NO;
    self.isDownLoad = NO;
    self.page = 1;
    self.cityArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupNavigationItems];
    [self setupCityCollectionView];
    
}

-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y );
    [self.view addSubview:self.MONAView];
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)setupNavigationItems{
    [PublicFunction setupNavigationBarforViewController:self];
    self.navigationItem.title = @"全部城市";
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置UICollectionView
-(void)setupCityCollectionView{
    self.allCityCollectionView = [CityListCollectionView CListCollectionView];
    self.allCityCollectionView.dataSource = self;
    self.allCityCollectionView.delegate = self;
    [self.view addSubview:self.allCityCollectionView];
    [self addHeaderRefresher];
    [self addFooterRefresher];
    [self initMONA];
    [self getCityDataByAFN];
}

-(void)addHeaderRefresher{
    [self.allCityCollectionView addHeaderWithCallback:^{
        if (self.footerRemoved == YES) {
            [self addFooterRefresher];
        }
        self.isUpLoad = NO;
        self.isDownLoad = YES;
        self.page = 1;
        [self getCityDataByAFN];
    }];
}

-(void)addFooterRefresher{
    [self.allCityCollectionView addFooterWithCallback:^{
        self.isUpLoad = YES;
        self.isDownLoad = NO;
        self.page++;
        if (self.cityArray.count == self.cityCount) {
            [self.allCityCollectionView footerEndRefreshing];
            [self.allCityCollectionView removeFooter];
            self.footerRemoved = YES;
        }
        else{
            [self getCityDataByAFN];
        }
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cityArray.count;
}

#pragma mark - CELL FOR ITEM
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CityListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CITY_LIST_CELLID forIndexPath:indexPath];
    cell.clist = [self.cityArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark - ITEM DID SELECTED
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CityDetailViewController * cityDetailVC = [[CityDetailViewController alloc]init];
    cityDetailVC.cityID = [(CityList*)[self.cityArray objectAtIndex:indexPath.row] cityID];
    cityDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cityDetailVC animated:YES];
    [cityDetailVC release];
}

#pragma mark - AFN
-(void)getCityDataByAFN{
    NSString * urlStr = [NSString stringWithFormat:CITY_LIST_URL,self.myCountryID,self.page];
    if (!self.isUpLoad && !self.isDownLoad) {
        [self.MONAView startAnimating];
    }
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSMutableArray * dataArray = [(NSMutableDictionary * )data objectForKey:@"data"];
        if (self.isUpLoad == NO) {
            if (self.cityArray.count != 0) {
                [self.cityArray removeAllObjects];
            }
        }
        for (NSMutableDictionary * dic  in dataArray) {
            CityList * citylist = [[CityList alloc]init];
            [citylist setValuesForKeysWithDictionary:dic];
            [self.cityArray addObject:citylist];
        }
        [self.allCityCollectionView reloadData];
        if (!self.isUpLoad && !self.isDownLoad) {
            [self.MONAView stopAnimating];
        }
        [self.allCityCollectionView footerEndRefreshing];
        [self.allCityCollectionView headerEndRefreshing];
        
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
