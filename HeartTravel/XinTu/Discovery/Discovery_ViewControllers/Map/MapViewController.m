//
//  MapViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MapViewController.h"

#define MAP_NORMAL_POINT @"Map_Normal_Point@3x.png"
#define MAP_SMALL_POINT  @"Map_Small_Point@3x.png"

@interface MapViewController ()<MAMapViewDelegate,BottomViewDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation MapViewController

-(void)dealloc{

    [self.mapView release];
    [self.itemArray release];
    [self.topNavView release];
    [self.bottomView release];
    [self.MONAView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItems];
    [self initProperties];
    [self getAnnotationDataByAF];
    [self initMONA];
}

-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    [self.MONAView release];
}

-(void)setNavigationItems{
    [PublicFunction setupNavigationBarforViewController:self];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)initProperties{
    self.isFirstLoad = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.itemArray = [NSMutableArray array];
}

-(void)setupMapView{
    [MAMapServices sharedServices].apiKey = API_KEY_MAP;
    self.mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetHeight([[UIScreen mainScreen]bounds]))];
    self.mapView.delegate = self;
    self.mapView.showsScale = YES;
    self.mapView.scaleOrigin = CGPointMake(20, 0);
    [self.view addSubview:self.mapView];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView release];
}

-(void)setupBottomView{
    self.bottomView = [[MapBottomView alloc] bottomView];
    self.bottomView.myDelegate = self;
    [self.view addSubview:self.bottomView];
    [self.bottomView release];
}

-(void)bottomAppear{
    CGRect tempFrame = self.bottomView.frame;
    tempFrame.origin.y = CGRectGetHeight([[UIScreen mainScreen]bounds]) - self.bottomView.frame.size.height;

    [UIView animateWithDuration:0.6 animations:^{
        self.bottomView.frame = tempFrame;
    }];
}

-(void)bottomDisappear{
    CGRect tempFrame = self.bottomView.frame;
    tempFrame.origin.y = CGRectGetHeight([[UIScreen mainScreen]bounds]);
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.frame = tempFrame;
    }];
    
}

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    static NSString * annotationID = @"annotationID";
    
    MAAnnotationView * annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationID];
    
    if (annotationView == nil) {
        annotationView = [[MAAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationID];
    }
    CustomPointAnnotation * cusAnnotation = (CustomPointAnnotation *)annotation;
    
    if (self.fromWhichVC == CountryDetailVC|| self.fromWhichVC == CityDetailVC) {
        if (cusAnnotation.baseList.is_recommend == YES) {
            annotationView.image = [UIImage imageNamed:MAP_NORMAL_POINT];
        }
        else{
            annotationView.image = [UIImage imageNamed:MAP_SMALL_POINT];
        }
    }
    return annotationView;
}

-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
    CustomPointAnnotation * anno = (CustomPointAnnotation*)view.annotation;
    if (view.selected == YES) {
        self.bottomView.baseList = anno.baseList;
        [self bottomAppear];
    }
    else{
        [self bottomDisappear];
    }
}

//
//-(void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
//    NSLog(@"did deselect");
//    [self bottomDisappear];
//}

-(void)addAnnotations{
    NSMutableArray * annotations = [NSMutableArray array];
    for (BaseMapList * bl in self.itemArray) {
        CustomPointAnnotation * pAnnotation = [[CustomPointAnnotation alloc]init];
        pAnnotation.baseList = bl;
        pAnnotation.coordinate = CLLocationCoordinate2DMake(bl.lat, bl.lng);
        [annotations addObject:pAnnotation];
        [pAnnotation release];
        
    }
    [self.mapView addAnnotations:annotations];
    BaseMapList * list = [self.itemArray firstObject];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(list.lat, list.lng);
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

-(void)getAnnotationDataByAF{
    NSString * urlStr = [NSString stringWithFormat:self.urlStr,self.itemID];

    [PublicFunction getDataByAFNetWorkingWithURL:urlStr Success:^(id data) {
        NSMutableArray * dataArray = [(NSMutableDictionary*) data objectForKey:@"data"];
        [self setupMapView];
        for (NSDictionary * dic in dataArray) {
            BaseMapList * baseMList = [[BaseMapList alloc]init];
            [baseMList setValuesForKeysWithDictionary:dic];
            [self.itemArray addObject:baseMList];
            [baseMList release];
        }
        [self addAnnotations];
        [self setupBottomView];
        
    } failure:^{
        [self.MONAView stopAnimating];
        [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"网络连接失败" forViewController:self cancelButtonTitle:nil];
    }];
}

-(void)gotoPointDetailPage{
    if (self.fromWhichVC == CountryDetailVC) {
        CityDetailViewController * cityDetailVC = [[CityDetailViewController alloc]init];
        cityDetailVC.cityID = self.bottomView.baseList.itemID;
        [self.navigationController pushViewController:cityDetailVC animated:YES];
        [cityDetailVC release];
    }
    else if (self.fromWhichVC == CityDetailVC){
        WayPointDetailViewController * wpDetailVC = [[WayPointDetailViewController alloc]init];
        wpDetailVC.poi_id = self.bottomView.baseList.itemID;
        [self.navigationController pushViewController:wpDetailVC animated:YES];
        [wpDetailVC release];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
