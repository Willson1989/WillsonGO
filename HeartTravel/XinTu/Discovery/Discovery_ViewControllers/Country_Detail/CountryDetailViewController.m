//
//  CountryDetailViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CountryDetailViewController.h"


#define CITY_BUTTON_TAG  1111
#define GUIDE_BUTTON_TAG 2222

static NSString * recommCellID = @"recom";
static NSString * cityCellID   = @"city";
static NSString * funcCellID   = @"func";
static NSString * coll_cityCellID = @"coll_hotCity";

@interface CountryDetailViewController ()<TopPhotoScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,
TopNavigationViewDelegate,functionCellDelegate,UICollectionViewDataSource,
UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DetailCellDelegate,MONActivityIndicatorViewDelegate>


@end

@implementation CountryDetailViewController

-(void)dealloc{
    
    [self.myCountry release];
    [self.myTableView release];
    [self.topScrollView release];
    [self.topNavView release];
    [self.photoArray release];
    [self.CountryDetailDic release];
    [self.hotCityCollectionView release];
    [self.hotGuideCollectionView release];

    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupTableView];
    [self setNavigationView];
    self.topNavView.rightButton.hidden = YES;
    self.topNavView.rightButton.userInteractionEnabled = NO;
    [self initMONA];
}

-(void)setCountryID:(NSString *)countryID{
    if (_countryID != countryID) {
        [_countryID release];
        _countryID = [countryID retain];
    }
    [self getCountryDetailData];
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
//    [self.topNavView setAlphaforSubViews:0.0];
    [self.topNavView setAlphaforSubViews:1.0];

    [self.view addSubview:self.topNavView];
}


#pragma mark - UITableVie的创建及其代理方法
-(void)setupTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, CGRectGetHeight([[UIScreen mainScreen]bounds])) style:UITableViewStylePlain];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.topScrollView = [[TopPhotoScrollView alloc]initWithFrame:CGRectMake(0, -IMAGE_HEIGHT-20, TOP_IMAGE_WIDTH, SCROLL_HEIGHT)];
    
    
    
    self.myTableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT + 20, 0, 0, 0);
    [self.myTableView addSubview:self.topScrollView];
    [self.view addSubview:self.myTableView];
    
    [self.topScrollView release];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger  numberOfRow = 1;
    if (self.myCountry.hot_city.count != 0) {
        numberOfRow++;
    }
    if (self.myCountry.hot_mguide.count != 0) {
        numberOfRow++;
    }
    return numberOfRow;
}

#pragma mark - CELL FOR ROW
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //功能栏(实用信息 + 推荐行程)
    if (indexPath.row == 0) {
        FunctionCell * funcCell = [tableView dequeueReusableCellWithIdentifier:funcCellID];
        if (funcCell == nil) {
            funcCell = [[FunctionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:funcCellID];
            funcCell.myDelegate = self;
        }
        return  funcCell;
    }
    //热门城市
    else if(indexPath.row == 1){
        DetailPageCell * city_detailCell = [tableView dequeueReusableCellWithIdentifier:cityCellID];
        if (city_detailCell == nil) {
            city_detailCell = [[DetailPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cityCellID];
        }
        if (self.myCountry.hot_city.count != 0) {
            city_detailCell.myDelegate = self;
            city_detailCell.hotTitleLabel.text = [NSString stringWithFormat:@"%@热门城市",self.myCountry.cnname];
            city_detailCell.allListButton.tag = CITY_BUTTON_TAG;
            [self setupHotCityCollectionViewforCell:city_detailCell];
        }
        return city_detailCell;
    }
    //热门游记
    else if (indexPath.row == 2){
        DetailPageCell * guide_detailCell = [tableView dequeueReusableCellWithIdentifier:recommCellID];
        if (guide_detailCell == nil) {
            guide_detailCell = [[DetailPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recommCellID];
        }
        if (self.myCountry.hot_mguide.count != 0) {
            guide_detailCell.myDelegate = self;
            guide_detailCell.hotTitleLabel.text = @"当地特色";
            guide_detailCell.allListButton.tag = GUIDE_BUTTON_TAG;
            [self setupHotGuideCollectionViewForCell:guide_detailCell];
        }
        return guide_detailCell;
    }
    else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = @"aaaaa";
        return cell;
    }
}

#pragma mark - HEIGHT FOR ROW
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return FUNC_CELL_HEIGHT;
    }
    else if (indexPath.row == 1){
        if (self.myCountry.hot_city.count == 0) {
            return 0;
        }
        else{
            //这里计算高度的时候,一定要使用float类型,否则下面的除以2的操作结果会为0
            return GET_CITY_CELL_HEIGHT(self.myCountry.hot_city.count/2.0f);
        }
    }
    else{
        if (self.myCountry.hot_mguide.count == 0) {
            return 0;
        }
        else
            return GET_GUIDE_CELL_HEIGHT(self.myCountry.hot_mguide.count/2.0f);
    }
}

#pragma mark - AFN
-(void)getCountryDetailData{
    NSString * urlStr = [NSString stringWithFormat:COUNTRY_DETAIL_URL,self.countryID];
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
    }];
    
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSMutableDictionary * mainDataDic = [NSMutableDictionary dictionary];
        mainDataDic = [(NSMutableDictionary *)data objectForKey:@"data"];
        self.photoArray = [NSMutableArray arrayWithArray:[mainDataDic objectForKey:@"photos"]];
        self.myCountry = [[Country alloc]init];
        [self.myCountry setValuesForKeysWithDictionary:mainDataDic];
        [self setupTableView];
        [self.view bringSubviewToFront:self.topNavView];
        self.topNavView.ennameLabel.text = self.myCountry.enname;
        self.topNavView.cnnameLabel.text = self.myCountry.cnname;
        self.topScrollView.photoArray = self.photoArray;
        //刷新TableView
        //[self.myTableView reloadData];
        //热门城市和热门特色的CollectionView刷新
        [self.hotCityCollectionView reloadData];
        [self.hotGuideCollectionView reloadData];
        [self.topNavView setAlphaforSubViews:0.0];
        self.topNavView.rightButton.hidden = NO;
        self.topNavView.rightButton.userInteractionEnabled = YES;
        [self.MONAView stopAnimating];
        
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
}

#pragma mark - 改变顶部导航视图透明度
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //self.myTableView.contentOffset.y总是从-20开始,有待调查
    if (scrollView == self.myTableView) {
        CGFloat y = (self.myTableView.contentOffset.y - self.myTableView.frame.origin.y + IMAGE_HEIGHT)/(SCROLL_HEIGHT / 2);
        CGFloat alpha = 0.9 * y;
        [self.topNavView setAlphaforSubViews:alpha];
    }
}


#pragma mark - 创建热门城市CollectionView
-(void)setupHotCityCollectionViewforCell:(DetailPageCell * )cell{
    NSInteger count = self.myCountry.hot_city.count;
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(COLL_TOP_HEIGHT, LINE_SPACE/2, LINE_SPACE, LINE_SPACE/2);
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - LINE_SPACE * 2) / 2 , COLL_CELL_HEIGHT);
    layout.minimumInteritemSpacing = COLL_CELL_LINE_SPACE;
    layout.minimumLineSpacing = COLL_CELL_LINE_SPACE;
    CGFloat coll_height = 0.0f;
    coll_height = ceil(count/2.0f) * (layout.itemSize.height + layout.minimumLineSpacing) + COLL_CELL_LINE_SPACE;
    self.hotCityCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake
                                  (0, DETAIL_CELL_TOP_HEIGHT, self.view.bounds.size.width, coll_height)
                                                   collectionViewLayout:layout ];

    self.hotCityCollectionView.backgroundColor = [UIColor whiteColor];
    [self.hotCityCollectionView registerClass:[HotCityCell class] forCellWithReuseIdentifier:coll_cityCellID];
    self.hotCityCollectionView.dataSource = self;
    self.hotCityCollectionView.delegate = self;
    self.hotCityCollectionView.tag = 1000;
    [cell.contentView addSubview:self.hotCityCollectionView];
    
    [self.hotCityCollectionView release];
    [layout release];
}

#pragma mark - 创建热门当地特色CollectionView
-(void)setupHotGuideCollectionViewForCell:(DetailPageCell * )cell{
    NSInteger count = self.myCountry.hot_mguide.count;
    self.hotGuideCollectionView = [HotGuideCollectionView hotGuideCollectionViewWithGuideCount:count];
    self.hotGuideCollectionView.backgroundColor = [UIColor clearColor];
    self.hotGuideCollectionView.delegate = self;
    self.hotGuideCollectionView.dataSource = self;
    [cell.contentView addSubview:self.hotGuideCollectionView];
}

#pragma mark - UICOLLECTION-VIEW代理方法
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.hotCityCollectionView) {
        return self.myCountry.hot_city.count;
    }
    if (collectionView == self.hotGuideCollectionView) {
        return self.myCountry.hot_mguide.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.hotCityCollectionView) {
        NSMutableDictionary * cityDic =[self.myCountry.hot_city objectAtIndex:indexPath.row];
        HotCityCell * cityCell = [collectionView dequeueReusableCellWithReuseIdentifier:coll_cityCellID forIndexPath:indexPath];
        cityCell.cityDic = cityDic;
        cityCell.backgroundColor = [UIColor whiteColor];
        return cityCell;
    }
    if (collectionView == self.hotGuideCollectionView) {
        NSMutableDictionary * guideDic =[self.myCountry.hot_mguide objectAtIndex:indexPath.row];
        HotGuideCell * guideCell  = [collectionView dequeueReusableCellWithReuseIdentifier:HOT_GUIDE_CELLID forIndexPath:indexPath];
        guideCell.guideDic = guideDic;
        return guideCell;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.hotCityCollectionView) {
        NSMutableDictionary * hotCityDic = [self.myCountry.hot_city objectAtIndex:indexPath.row];
        CityDetailViewController * cityDetailVC = [[CityDetailViewController alloc]init];
        cityDetailVC.cityID = [hotCityDic objectForKey:@"id"];
        cityDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cityDetailVC animated:YES];
    }
    if (collectionView == self.hotGuideCollectionView) {
        NSMutableDictionary * hotGuideDic = [self.myCountry.hot_mguide objectAtIndex:indexPath.row];
        HotGuideDetailViewController * hotGuideDetailVC = [[HotGuideDetailViewController alloc]init];
        hotGuideDetailVC.guideID = [hotGuideDic objectForKey:@"id"];
        hotGuideDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hotGuideDetailVC animated:YES];
    }
}

-(void)navigationViewReturnButtonClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navigationViewRightButtonClicked{
    MapViewController * mapVC = [[MapViewController alloc]init];
    mapVC.fromWhichVC = CountryDetailVC;
    mapVC.itemID = self.myCountry.countryID;
    mapVC.urlStr = CITYLIST_MAP_URL;
//    mapVC.title = [NSString stringWithFormat:@"%@地图",self.myCountry.cnname];
    [self.navigationController pushViewController:mapVC animated:YES];
}


-(void)gotoPracticalInfoPage{
    PracticalInfoViewController * pInfoVC = [[PracticalInfoViewController alloc]init];
    pInfoVC.overview_url = self.myCountry.overview_url;
    //页面跳转的时候隐藏TabBar
    pInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pInfoVC animated:YES];
}

-(void)gotoRecomRoutePage{
    RecomTravelMainViewController * tMainVC = [[RecomTravelMainViewController alloc]init];
    tMainVC.itemType = @"country";
    tMainVC.idType = @"countryid";
    tMainVC.itemID = self.myCountry.countryID;
    tMainVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tMainVC animated:YES];
    
}

#pragma mark - DetailCell的代理方法
-(void)gotoAllListPageByClickedButton:(UIButton *)button{
    if (button.tag == CITY_BUTTON_TAG) {
        CityListViewController * cityListVC = [[CityListViewController alloc]init];
        cityListVC.myCountryID = self.myCountry.countryID;
        cityListVC.cityCount = self.cityCount;
        cityListVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:cityListVC animated:YES];
    }
    else if (button.tag == GUIDE_BUTTON_TAG){
        HotGuideListViewController * hGuideVC = [[HotGuideListViewController alloc]init];
        hGuideVC.itemID = self.myCountry.countryID;
        hGuideVC.itemType = @"country";
        hGuideVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hGuideVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.topScrollView startTimer];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.topScrollView stopTimer];
    self.navigationController.navigationBarHidden = NO;
}


@end
