//
//  CityDetailViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CityDetailViewController.h"

@interface CityDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,TopNavigationViewDelegate,DetailCellDelegate,functionCellDelegate,CityFuncCellDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation CityDetailViewController

-(void)dealloc{
    [self.myCity release];
    [self.myTableView release];
    [self.topScrollView release];
    [self.topNavView release];
    [self.photoArray release];
    [self.CityDetailDic release];
    [self.hotGuideCollectionView release];
    [self.layout release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getCityDetailDataByAFN];
    [self setNavigationView];
    self.topNavView.rightButton.hidden = YES;
    self.topNavView.rightButton.userInteractionEnabled = NO;
    [self initMONA];
}

-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = self.view.center;
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)setNavigationView{
    self.topNavView = [[TopNavigationView alloc]initWithFrame:CGRectMake(0, 0, TOP_IMAGE_WIDTH, 64)];
    self.topNavView.myDelegate = self;
    [self.topNavView setAlphaforSubViews:1.0];
    [self.view addSubview:self.topNavView];
    [self.topNavView release];
}

#pragma mark - UITableVie的创建及其代理方法
-(void)setupTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MYWIDTH, CGRectGetHeight([[UIScreen mainScreen]bounds])) style:UITableViewStyleGrouped];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    //创建顶部轮播图片
    self.topScrollView = [[TopPhotoScrollView alloc]initWithFrame:CGRectMake(0, 0, TOP_IMAGE_WIDTH, SCROLL_HEIGHT)];
    [self.myTableView setTableHeaderView:self.topScrollView];
    self.topNavView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.myTableView];
    [self setNavigationView];
    [self.myTableView release];
    [self.topScrollView release];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.myCity.hot_mguide.count == 0) {
        return 2;
    }
    else
        return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return CITY_FUNC_CELL_HEIGHT;
    }
    else if (indexPath.row == 1){
        return FUNC_CELL_HEIGHT;
    }
    else
        return GET_GUIDE_CELL_HEIGHT(self.myCity.hot_mguide.count/2.0f);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSString * cityCellID = @"cityCell";
        CityFuncCell * cityFuncCell = [tableView dequeueReusableCellWithIdentifier:cityCellID];
        if (cityFuncCell == nil) {
            cityFuncCell = [[CityFuncCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCellID];
        }
        cityFuncCell.myDelegate = self;
        return cityFuncCell;
    }
    else if (indexPath.row == 1){
        NSString * funcCellID = @"funcCell";
        FunctionCell * funcCell = [tableView dequeueReusableCellWithIdentifier:funcCellID];
        if (funcCell == nil) {
            funcCell = [[FunctionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:funcCellID];
        }
        funcCell.myDelegate = self;
        return funcCell;
    }
    else{
        NSString * detailCellID = @"detailCell";
        DetailPageCell * detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellID];
        if (detailCell == nil) {
            detailCell = [[DetailPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellID];
            [self setupHotGuideCollectionViewForCell:detailCell];
            detailCell.myDelegate = self;
            detailCell.backgroundColor = [UIColor whiteColor];
            detailCell.hotTitleLabel.text = @"热门当地特色";
        }
        return detailCell;
    }
}

#pragma mark - 热门特色UICollectionView创建 和 代理方法
-(void)setupHotGuideCollectionViewForCell:(UITableViewCell *)cell{
    self.hotGuideCollectionView = [HotGuideCollectionView hotGuideCollectionViewWithGuideCount:self.myCity.hot_mguide.count];
    self.hotGuideCollectionView.delegate = self;
    self.hotGuideCollectionView.dataSource = self;
    [cell.contentView addSubview:self.hotGuideCollectionView];
}

-(void)getCityDetailDataByAFN{
    NSString * urlStr = [NSString stringWithFormat:CITY_DETAIL_URL,self.cityID];
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSMutableDictionary * dataDic = [(NSMutableDictionary*)data objectForKey:@"data"];
        self.myCity = [[City alloc]init];
        [self.myCity setValuesForKeysWithDictionary:dataDic];
        [self setupTableView];
        [self.view bringSubviewToFront:self.topNavView];
        self.topNavView.ennameLabel.text = self.myCity.enname;
        self.topNavView.cnnameLabel.text = self.myCity.cnname;
        self.topScrollView.photoArray = self.myCity.photos;
        
        [self.myTableView reloadData];
        [self.hotGuideCollectionView reloadData];
        [self.topNavView setAlphaforSubViews:0.0];
        [self.MONAView stopAnimating];
        self.topNavView.rightButton.hidden = NO;
        
        self.topNavView.rightButton.userInteractionEnabled = YES;
        [self.myCity release];
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.myCity.hot_mguide.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotGuideCell * hotGCell = [collectionView dequeueReusableCellWithReuseIdentifier:HOT_GUIDE_CELLID forIndexPath:indexPath];
    NSMutableDictionary * guideDic = [self.myCity.hot_mguide objectAtIndex:indexPath.row];
    hotGCell.guideDic = guideDic;
    return hotGCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HotGuideDetailViewController * hotGDetailVC = [[HotGuideDetailViewController alloc]init];
    hotGDetailVC.guideID = [[self.myCity.hot_mguide objectAtIndex:indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:hotGDetailVC animated:YES];
    [hotGDetailVC release];
}

#pragma mark - 改变顶部导航视图透明度
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //self.myTableView.contentOffset.y总是从-20开始,有待调查
    CGFloat y = (self.myTableView.contentOffset.y - self.myTableView.frame.origin.y)/(SCROLL_HEIGHT / 2);
    
    CGFloat alpha = 0.9 * y;
    [self.topNavView setAlphaforSubViews:alpha];
}

-(void)gotoPracticalInfoPage{
    PracticalInfoViewController * pInfoVC = [[PracticalInfoViewController alloc]init];
    pInfoVC.overview_url = self.myCity.overview_url;
    //页面跳转的时候隐藏TabBar
    pInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pInfoVC animated:YES];
    //    [pInfoVC release];
}

-(void)gotoRecomRoutePage{
    RecomTravelMainViewController * tMainVC = [[RecomTravelMainViewController alloc]init];
    tMainVC.itemType = @"city";
    tMainVC.idType = @"cityid";
    tMainVC.itemID = [NSString stringWithFormat:@"%li",self.myCity.cityID];
    tMainVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tMainVC animated:YES];
}

-(void)gotoAllListPageByClickedButton:(UIButton *)button{
    HotGuideListViewController * hGuideVC = [[HotGuideListViewController alloc]init];
    hGuideVC.itemID = [NSString stringWithFormat:@"%li",self.myCity.cityID];
    hGuideVC.itemType = @"city";
    hGuideVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:hGuideVC animated:YES];
    [hGuideVC release];
}

-(void)gotoWayPointListPageWithCategoryID:(NSInteger)ID{
    WayPointListViewController * wayPointListVC = [[WayPointListViewController alloc]init];
    wayPointListVC.city_id = [NSString stringWithFormat:@"%li",self.myCity.cityID];
    wayPointListVC.cat_ID  = ID;
    wayPointListVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:wayPointListVC animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

-(void)navigationViewReturnButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 跳转到地图页面
-(void)navigationViewRightButtonClicked{
    MapViewController * mapVC = [[MapViewController alloc]init];
    mapVC.fromWhichVC = CityDetailVC;
    mapVC.itemID = [NSString stringWithFormat:@"%li",self.myCity.cityID];
    mapVC.hidesBottomBarWhenPushed = YES;
    mapVC.urlStr = POILIST_MAP_URL;
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
