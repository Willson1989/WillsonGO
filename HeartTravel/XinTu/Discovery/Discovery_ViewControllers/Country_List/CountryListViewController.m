//
//  CountryListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CountryListViewController.h"


@interface CountryListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,MBProgressHUDDelegate,MONActivityIndicatorViewDelegate>
@end

@implementation CountryListViewController


-(void)dealloc{
    
    [self.hotCountry release];
    [self.otherCountry release];
    [self.myCollectionView release];
    [self.otherCollView release];
    [self.layout release];
    [super dealloc];
}

-(instancetype)initWithContinentName:(NSString*)continentName{
    if (self = [super init]) {
        self.continentName = continentName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProperties];
    [self getCacheData];
    [self getCountryListData];
    [self setupCollectionView];
    [self initMONA];

}

-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [self.view addSubview:self.MONAView];

}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}


-(void)initProperties{
    self.view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];
    self.hotCountry = [NSMutableArray array];
    self.otherCountry = [NSMutableArray array];
}

#pragma mark - 初始化UICollectionView 和 CollectionView的代理方法
-(void)setupCollectionView{
    CGFloat totalHeight = self.hotCountry.count * self.hotCountry.count * (IMAGE_HEIGHT_1 + 20) +
                          self.otherCountry.count * OTHER_COUNTRY_CELL_HEIGHT +
                          HEADER_HEIGHT;
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    self.layout.minimumLineSpacing = 1;
    
    self.myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-OTHER_HEIGHT) collectionViewLayout:self.layout];
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
    self.myCollectionView.bounces = NO;
    
    [self.myCollectionView registerClass:[MJCollectionViewCell class] forCellWithReuseIdentifier:HOT_COUNTRY_CELL_ID];
    [self.myCollectionView registerClass:[OtherCountryCell class] forCellWithReuseIdentifier:OTHER_COUNTRY_CELL_ID];
    [self.myCollectionView registerClass:[CountryListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_VIEW_ID];
    [self.view addSubview:self.myCollectionView];
    self.myCollectionView.backgroundColor = [UIColor whiteColor];
    self.myCollectionView.contentSize = CGSizeMake(MYWIDTH, totalHeight);
    [self.layout release];
    [self.myCollectionView release];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        return self.hotCountry.count;
    }
    else
        return self.otherCountry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //热门国家图片列表
    if (indexPath.section == 0) {
        MJCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:HOT_COUNTRY_CELL_ID forIndexPath:indexPath];
        NSString * urlStr = [[self.hotCountry objectAtIndex:indexPath.row] objectForKey:@"photo"];

        [cell.MJImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        }];
        
        CGFloat yOffset = ((self.myCollectionView.contentOffset.y - cell.frame.origin.y) / IMAGE_HEIGHT_1) * IMAGE_OFFSET_SPEED;
        cell.imageOffset = CGPointMake(0.0f, yOffset);
        cell.cnnameLabel.text = [[self.hotCountry objectAtIndex:indexPath.row] objectForKey:@"cnname"];
        cell.ennameLabel.text = [[self.hotCountry objectAtIndex:indexPath.row] objectForKey:@"enname"];
        return cell;
    }
    //其他国家非图片列表
    else{
        
        OtherCountryCell * otherCell = [collectionView dequeueReusableCellWithReuseIdentifier:OTHER_COUNTRY_CELL_ID forIndexPath:indexPath];
        NSString * enname = [[self.otherCountry objectAtIndex:indexPath.row] objectForKey:@"enname"];
        NSString * cnname = [[self.otherCountry objectAtIndex:indexPath.row] objectForKey:@"cnname"];
        otherCell.contentLabel.text = [NSString stringWithFormat:@"%@ %@",cnname,enname];
        return otherCell;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    CountryListHeaderView * hView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        hView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_VIEW_ID forIndexPath:indexPath];
    }
    return hView;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        if (self.otherCountry.count != 0) {
            return CGSizeMake(MYWIDTH, HEADER_HEIGHT);
        }
        else
            return CGSizeMake(MYWIDTH, 0);
    }
    else
        return CGSizeMake(MYWIDTH, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString * destinationID = [NSString string];
    NSInteger cityCount = 0;
    if (indexPath.section == 0) {
        NSInteger  hotflag = [(NSString *)[[self.hotCountry objectAtIndex:indexPath.row] objectForKey:@"flag"] integerValue];
        //当前这个cell跳转到国家详情
        destinationID = [[self.hotCountry objectAtIndex:indexPath.row] objectForKey:@"id"];
        cityCount = [(NSString *)[[self.hotCountry objectAtIndex:indexPath.row] objectForKey:@"count"] integerValue];
        if (hotflag == 1) {
            [self.myDelegate gotoCountryDetailPageWithCountryID:destinationID andCityCount:cityCount];
        }
        //当前这个cell跳转到城市详情
        else if (hotflag == 2){
            [self.myDelegate gotoCityDetailPageWithcityID:destinationID];
        }
        else{
            
        }
    }
    else{
        NSInteger  otherflag = 99;
        if (self.otherCountry.count != 0 ) {
            otherflag = [(NSString *)[[self.otherCountry objectAtIndex:indexPath.row] objectForKey:@"flag"] integerValue];
        }
        destinationID = [[self.otherCountry objectAtIndex:indexPath.row] objectForKey:@"id"];
        cityCount = [(NSString *)[[self.otherCountry objectAtIndex:indexPath.row] objectForKey:@"count"] integerValue];
        if (otherflag == 1) {
            [self.myDelegate gotoCountryDetailPageWithCountryID:destinationID andCityCount:0];
        }
        else if (otherflag == 2){
            [self.myDelegate gotoCityDetailPageWithcityID:destinationID];
        }
    }
}

#pragma mark - UIScrollViewdelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for(UICollectionViewCell *view in self.myCollectionView.visibleCells) {
        if ([view isKindOfClass:[MJCollectionViewCell class]]) {
            CGFloat yOffset = ((self.myCollectionView.contentOffset.y - view.frame.origin.y) / IMAGE_HEIGHT_1) * IMAGE_OFFSET_SPEED;
            MJCollectionViewCell * tempCell = (MJCollectionViewCell *)view;
            tempCell.imageOffset = CGPointMake(0.0f, yOffset);
        }
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(MYWIDTH, IMAGE_HEIGHT_1);
    }
    else{
        return CGSizeMake(MYWIDTH, OTHER_COUNTRY_CELL_HEIGHT);
    }
}

#pragma mark - 初始化导航栏相关内容
-(void)setupNavigationItems{
    self.navigationItem.title = @"国家";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"我的" style:UIBarButtonItemStyleDone target:self action:@selector(gotoMinePage)];
}

-(void)gotoMinePage{
    
}

#pragma mark - AFN获取国家列表数据
-(void)getCountryListData{
    [self.MONAView startAnimating];
    NSString * urlStr = COUNTRY_LIST_URL;
    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSArray * array = [data objectForKey:@"data"];
        
        for (NSDictionary * dic in array) {
            if ([[dic objectForKey:@"enname"] isEqualToString:self.continentName]) {
                self.hotCountry = [dic objectForKey:@"hot_country"];
                self.otherCountry = [dic objectForKey:@"country"];
            }
        }
        [self.MONAView stopAnimating];
        [self.myCollectionView reloadData];
        self.myCollectionView.contentSize = CGSizeMake(MYWIDTH, self.hotCountry.count * (IMAGE_HEIGHT_1 + 20));
        
        //获取缓存数据
        if (self.hotCountry.count != 0) {
            
            //获取缓存文件夹路径
            NSString *cachePath = [[CacheDataHandle shareDataHandle] getCachePath];
            
            //删除缓存文件
            NSString *oldFilePath = [NSString stringWithFormat:@"%@/%@hotCountry.av",cachePath,self.title];
            [[CacheDataHandle shareDataHandle] removeCacheData:oldFilePath];
            NSString *oldFilePath2 = [NSString stringWithFormat:@"%@/%@otherCountry.av",cachePath,self.title];
            [[CacheDataHandle shareDataHandle] removeCacheData:oldFilePath2];
            //获取缓存文件路径
            NSString *titleId1 = [NSString stringWithFormat:@"%@hotCountry", self.title];
            NSString *filePath = [[CacheDataHandle shareDataHandle] getKey:titleId1 andObject:self.hotCountry andPath:cachePath];
            NSString *titleId2 = [NSString stringWithFormat:@"%@otherCountry", self.title];
            NSString *filePath2 = [[CacheDataHandle shareDataHandle] getKey:titleId2 andObject:self.otherCountry andPath:cachePath];
        }
        
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
}
#pragma mark 获取缓存数据
-(void)getCacheData{
    
    //获取缓存数据
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@hotCountry.av",[[CacheDataHandle shareDataHandle] getCachePath], self.title];
    NSString *cachePath2 = [NSString stringWithFormat:@"%@/%@otherCountry.av",[[CacheDataHandle shareDataHandle] getCachePath], self.title];
    //创建一个文件管理器对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
    if ([fileManager fileExistsAtPath:cachePath]) {
        
        self.hotCountry = [[CacheDataHandle shareDataHandle] setData:cachePath];
        [self.MONAView stopAnimating];
        [self.myCollectionView reloadData];
    }
    //判断文件是否存在
    if ([fileManager fileExistsAtPath:cachePath2]) {
        [self.MONAView stopAnimating];
        self.otherCountry = [[CacheDataHandle shareDataHandle] setData:cachePath2];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
