//
//  CountryListMainViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CountryListMainViewController.h"

@interface CountryListMainViewController ()<SUNSlideSwitchViewDelegate,CountryListDelegate,UISearchBarDelegate>

@property (retain,nonatomic) NSMutableArray * viewControllerArray;
@property (retain,nonatomic) SUNSlideSwitchView * sliderSwitchView;
@end

@implementation CountryListMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupNavigationItem];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.sliderSwitchView = [[SUNSlideSwitchView alloc]initWithFrame:self.view.bounds];
    self.sliderSwitchView.backgroundColor = [UIColor whiteColor];
    self.sliderSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.sliderSwitchView.tabItemSelectedColor = [PublicFunction getColorWithRed:82.0 Green:82.0 Blue:82.0];

    self.sliderSwitchView.shadowImage = [[UIImage imageNamed:@"green_line_and_shadow@2x.png"]
                                         stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    self.sliderSwitchView.slideSwitchViewDelegate = self;
    [self.view addSubview:self.sliderSwitchView];
    self.viewControllerArray = [NSMutableArray array];
    NSDictionary * cDic = [PublicFunction ContinentDictionary];
    for (NSString * key in cDic) {
        CountryListViewController * clVC = [[CountryListViewController alloc]init];
        clVC.myDelegate = self;
        clVC.continentName = key;
        clVC.title = [cDic objectForKey:key];
        [self.viewControllerArray addObject:clVC];
        [clVC release];
    }
    [self.sliderSwitchView buildUI];
    [self.view addSubview:self.sliderSwitchView];
    [self.sliderSwitchView release];
}

-(void)setupNavigationItem{
    UIColor * tintColor = SELECT_COLOR;
    [self.navigationController.navigationBar setBarTintColor:tintColor];
    self.navigationItem.title = @"发现";
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 44, 44);
    [searchButton addTarget:self action:@selector(gotoSearchPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    [searchButton setImage:[UIImage imageNamed:@"icon_search_mag_glass@2x.png"] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightItem;
}


-(void)gotoSearchPage{
    MainSearchViewController * msVC = [[MainSearchViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:msVC];
    [self presentViewController:nav animated:YES completion:^{ }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSUInteger)numberOfTab:(SUNSlideSwitchView *)view{
    
    return  [PublicFunction ContinentDictionary].count;
}

-(UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number{

    if (number == 0) {
        return [self.viewControllerArray objectAtIndex:0];
    }
    else if (number == 1){
        return [self.viewControllerArray objectAtIndex:1];
    }
    else if (number == 2){
        return [self.viewControllerArray objectAtIndex:2];
    }
    else if (number == 3){
        return [self.viewControllerArray objectAtIndex:3];
    }
    else if (number == 4){
        return [self.viewControllerArray objectAtIndex:4];
    }
    else if (number == 5){
        return [self.viewControllerArray objectAtIndex:5];
    }
    else if (number == 6){
        return [self.viewControllerArray objectAtIndex:6];
    }
    else
        return  nil;
}
-(void)gotoCountryDetailPageWithCountryID:(NSString *)countryID andCityCount:(NSInteger)cityCount{
    CountryDetailViewController * cDetailVC = [[CountryDetailViewController alloc]init];
    cDetailVC.countryID = countryID;
    cDetailVC.cityCount = cityCount;
    cDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cDetailVC animated:YES];
}

-(void)gotoCityDetailPageWithcityID:(NSString *)cityID{
    CityDetailViewController * cityDetailVC = [[CityDetailViewController alloc]init];
    cityDetailVC.cityID = cityID;
    
    [self.navigationController pushViewController:cityDetailVC animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

@end
