//
//  MainSearchViewController.m
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MainSearchViewController.h"
#import "HotSearchViewController.h"
#import "SearchTempListViewController.h"
#import "SearchListViewController.h"

@interface MainSearchViewController ()<UISearchBarDelegate,SearchTopDeleget,HotSearchDelegate,SearchTempDelegate,SearchListDelegate>

@property(retain,nonatomic) UISearchBar * searchBar;
@property(retain,nonatomic) HotSearchViewController * hotSearchVC;
@property(retain,nonatomic) SearchTempListViewController * tempSearchVC;
@property(retain,nonatomic) SearchListViewController * listSearchVC;
@property(retain,nonatomic) SearchTopView  * topView;

@property(retain,nonatomic) NSMutableArray * historyArray;

@property(retain,nonatomic) NSUserDefaults * userD;

@property(retain,nonatomic) NSTimer * timer;

@property (copy,nonatomic) NSString * tempKey;

@end

static NSInteger second = 0;

@implementation MainSearchViewController

-(void)dealloc{
    
    [self.searchBar release];
    [self.hotSearchVC release];
    [self.tempSearchVC release];
    [self.listSearchVC release];
    [self.topView release];
    [self.timer release];
    [self.historyArray release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self initTopView];
    [self initProperties];
    [self initSubViewControllers];
    self.view.backgroundColor = [UIColor purpleColor];
}

-(void)initProperties{
    self.userD = [NSUserDefaults standardUserDefaults];
    self.historyArray = [self.userD objectForKey:HISTORY_ARR];
    self.tempKey = [NSString string];
    second = 0;
}

-(void)initTopView{
    self.topView = [[SearchTopView alloc]init];
    self.topView.backgroundColor = SELECT_COLOR;
    [self.view addSubview:self.topView];
    self.topView.myDelegate = self;
    [self initSearchBar];
}

-(void)initSearchBar{
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,
                                                                  20,
                                                                  self.topView.frame.size.width - 44,
                                                                  self.topView.frame.size.height - 20)];
    [self.view addSubview:self.searchBar];
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.barTintColor = SELECT_COLOR;
    
    self.searchBar.backgroundImage = [UIImage imageNamed:@"SeachBarBK.png"];
    
    self.searchBar.delegate = self;
    [self initKeyBoardToolBar];
    [self.topView addSubview:self.searchBar];
    [self.searchBar release];
}

-(void)initKeyBoardToolBar{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), 30)];
    view.backgroundColor = SELECT_COLOR;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.frame = CGRectMake(view.frame.size.width * 6.8/8 - 5, 0, view.frame.size.width/8 + 5, 30);
    [view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    view.alpha = 0.9;
    view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    view.layer.borderWidth = 0.3f;
    view.layer.cornerRadius = 3;
    self.searchBar.inputAccessoryView = view;
    [view release];
}

-(void)buttonAction{
    [self.searchBar resignFirstResponder];
}

-(void)initSubViewControllers{
    self.hotSearchVC  = [[HotSearchViewController alloc]init];
    self.tempSearchVC = [[SearchTempListViewController alloc]init];
    self.listSearchVC = [[SearchListViewController alloc]init];
    self.hotSearchVC.myDelegate  = self;
    self.tempSearchVC.myDelegate = self;
    self.listSearchVC.myDelegate = self;
    CGRect tempFrame = CGRectMake(0,
                                  self.topView.frame.size.height,
                                  self.topView.frame.size.width,
                                  CGRectGetHeight([[UIScreen mainScreen]bounds]) - self.topView.frame.size.height);
    
    self.hotSearchVC.view.frame  = tempFrame;
    self.tempSearchVC.view.frame = tempFrame;
    self.listSearchVC.view.frame = tempFrame;
    
    [self.view addSubview:self.listSearchVC.view];
    [self.view addSubview:self.tempSearchVC.view];
    [self.view addSubview:self.hotSearchVC.view];
    
    [self.listSearchVC release];
    [self.tempSearchVC release];
    [self.hotSearchVC  release];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self stopTimer];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self stopTimer];
    [self.searchBar resignFirstResponder];
    if (searchBar.text.length != 0) {
        NSArray * temparr = [self.userD objectForKey:HISTORY_ARR];
        [self.historyArray removeAllObjects];
        [self.historyArray addObjectsFromArray:temparr];
        if (self.historyArray == nil) {
            self.historyArray = [NSMutableArray array];
        }
        
        if (![self.historyArray containsObject:searchBar.text]){
            if (self.historyArray.count > 9) {
                [self.historyArray removeObjectAtIndex:0];
            }
            [self.historyArray addObject:searchBar.text];
            [self.userD setObject:self.historyArray forKey:HISTORY_ARR];
            [self.userD synchronize];
        }
        [self.view bringSubviewToFront:self.listSearchVC.view];
        self.listSearchVC.searchKeyWord = searchBar.text;
        [self.hotSearchVC reloadHotTableView];
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        [self.searchBar resignFirstResponder];
        [self.view bringSubviewToFront:self.hotSearchVC.view];
    }
    else{
        self.tempKey = searchText;
        if (second<1) {
            [self stopTimer];
            [self startTimer];
        }
        [self.view bringSubviewToFront:self.tempSearchVC.view];
    }
}


-(void)clickedToSearchListpageFromHotSearchWithKeyWord:(NSString *)keyword{
    [self.view bringSubviewToFront:self.listSearchVC.view];
    self.listSearchVC.searchKeyWord = keyword;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}

-(void)dismissCurrentPage{
    
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{}];
    [self stopTimer];
}

-(void)changeContentOfSearchBar:(NSString *)content{
    self.searchBar.text = content;
}

-(void)switchToSearchListToSearchByKeyword:(NSString *)keyword{
    self.listSearchVC.searchKeyWord = keyword;
    [self.view bringSubviewToFront:self.listSearchVC.view];
}


-(void)gotoDetailPageWithType:(NSInteger)type andResultID:(NSInteger)rID{
    if (type == 1) {
        WayPointDetailViewController * wpDetailVC = [[WayPointDetailViewController alloc]init];
        wpDetailVC.poi_id = [NSString stringWithFormat:@"%li",rID];
        [self.navigationController pushViewController:wpDetailVC animated:YES];
    }
    if (type == 2) {
        CityDetailViewController * cityDetailVC = [[CityDetailViewController alloc]init];
        cityDetailVC.cityID = [NSString stringWithFormat:@"%li",rID];
        [self.navigationController pushViewController:cityDetailVC animated:YES];
    }
    if (type == 3){
        CountryDetailViewController * countryDetailVC = [[CountryDetailViewController alloc]init];
        countryDetailVC.countryID = [NSString stringWithFormat:@"%li",rID];
        [self.navigationController pushViewController:countryDetailVC animated:YES];
    }
}

-(void)startTimer{
    second = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(searchTask) userInfo:nil repeats:YES];
}

-(void)searchTask{
    second++;
    if (second == 1) {
        [self.tempSearchVC requsetData:self.tempKey];
        [self stopTimer];
    }
}

-(void)stopTimer{
    if (self.timer) {
        if (self.timer.isValid) {
            NSLog(@"计时器停止");
            [self.timer invalidate];
            self.timer = nil;
            second = 0;
        }
    }
}

-(void)resignSearchBarFirstResponder{
    [self.searchBar resignFirstResponder];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
