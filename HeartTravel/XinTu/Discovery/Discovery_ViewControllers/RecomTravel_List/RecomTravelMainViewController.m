//
//  RecomTravelMainViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RecomTravelMainViewController.h"

@interface RecomTravelMainViewController ()<TopTabBarDelegate,RecomTravelListDelegate>

@end

@implementation RecomTravelMainViewController

-(void)dealloc{

    [self.leftVC release];
    [self.rightVC release];
    [self.myBar release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setupNavigationItems];
    [self setupSubViewController];
    [self setupTopBar];
}

-(void)setupTopBar{
    self.myBar = [[TopTabBar alloc]initTopTabBarWithLeftName:@"编辑推荐" andRightName:@"用户推荐"];
    CGRect tempTemp = self.myBar.frame;
    tempTemp.origin.y += 64;
    self.myBar.frame = tempTemp;
    self.myBar.myDelegate = self;
    [self.view addSubview:self.myBar];
    [self.myBar release];
}

- (void)setupNavigationItems{
    [PublicFunction setupNavigationBarforViewController:self];
    self.navigationItem.title = @"推荐行程";
    UIImage * image = [[UIImage imageNamed:BACK_IMAGE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];
}

-(void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setupSubViewController{
    
    self.leftVC = [[RecommTravelViewController alloc] init];
    self.rightVC = [[RecommTravelViewController alloc] init];
    self.leftVC.recommandType = @"editor";
    self.rightVC.recommandType = @"user";
    self.leftVC.myDelegate = self;
    self.rightVC.myDelegate = self;
    
    [self setURLPropertiesForViewController:self.leftVC];
    [self setURLPropertiesForViewController:self.rightVC];

    [self.view addSubview:self.rightVC.view];
    [self.view addSubview:self.leftVC.view];
    [self.view bringSubviewToFront:self.leftVC.view];
    [self.view bringSubviewToFront:self.myBar];
    
    [self.leftVC release];
    [self.rightVC release];
    
}

-(void)setURLPropertiesForViewController:(RecommTravelViewController *)VC{
    VC.idType = self.idType;
    VC.itemID = self.itemID;
    VC.itemType = self.itemType;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

-(void)switchLeftPage{
    [self.view bringSubviewToFront:self.leftVC.view];
    [self.view bringSubviewToFront:self.myBar];
}

-(void)switchRightPage{
    [self.view bringSubviewToFront:self.rightVC.view];
    [self.view bringSubviewToFront:self.myBar];
}

-(void)gotoTravelDetailPageWithURL:(NSString *)url{
    RecomTravelDetailViewController * rTDetailVC = [[RecomTravelDetailViewController alloc]init];
    rTDetailVC.view_url = url;
    rTDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rTDetailVC animated:YES];
    [rTDetailVC release];
}


@end
