//
//  HotTravelViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotTravelViewController.h"

@interface HotTravelViewController ()

@end

@implementation HotTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appeared = NO;
    NSLog(@"HotTravel View did load ");
    self.view.backgroundColor=[UIColor whiteColor];
    self.detaTable = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStylePlain];
    self.detaTable.backgroundColor=[UIColor clearColor];
    self.detaTable.dataSource =self;
    self.detaTable.delegate   =self;
    [self.view addSubview:self.detaTable];
    
    [_detaTable release];
    [self initMONA];
    
    self.Y_N = 0;
    //去掉cell的分隔线
    self.detaTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //获取网络信息
    [self RequestData];
    
    [self.detaTable release];
    self.ButtonView=[[UIView alloc] init];
    self.ButtonView.backgroundColor = [UIColor grayColor];
    self.ButtonView.frame = CGRectMake(MYWIDTH,
                                       64,
                                       60*WIDTHR,
                                       80*HEIGHTR);
    self.ButtonView.alpha=0.6;
    CALayer *lay = self.ButtonView.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:4.50];
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10 * WIDTHR,
                                  (64 / 2 * HEIGHTR - 10 * HEIGHTR),
                                  50 * WIDTHR ,
                                  30 * HEIGHTR);
    [leftButton setImage:[UIImage imageNamed:BACK_IMAGE] forState:UIControlStateNormal];
    
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(365 * WIDTHR,
                                   (64 / 2 * HEIGHTR - 10 * HEIGHTR),
                                   50 * WIDTHR ,
                                   30 * HEIGHTR);
    [rightButton setImage:[UIImage imageNamed:MORE_IMAGE] forState:UIControlStateNormal];
    //[rightButton setTitle:@" . . . ." forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor redColor];
    
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBUttonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    [self.navigationController.view addSubview:self.ButtonView];
    [self creatButtons];
    [[SQLDataHandle shareDataHandle] creatHotDollectList];
    
}

-(void)leftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBUttonAction
{
    if (self.appeared == NO) {
        [self buttonAppear];
        self.appeared = YES;
    }
    else{
        self.appeared = NO;
        [self buttonDisappear];
    }
    
}

-(void)buttonAppear{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = self.ButtonView.frame;
        tempFrame.origin.x = MYWIDTH - 60*WIDTHR;
        self.ButtonView.frame = tempFrame;
    }];
}

-(void)buttonDisappear{
    [UIView animateWithDuration:0.01 animations:^{
        CGRect tempFrame = self.ButtonView.frame;
        tempFrame.origin.x = MYWIDTH;
        self.ButtonView.frame = tempFrame;
    }];
}

-(void)creatButtons{
    
    
    
    
    
    UIButton *collectButton= [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame = CGRectMake(15,
                                     5,
                                     30,
                                     30);
    collectButton.backgroundColor = [UIColor clearColor];
    [collectButton setImage:[UIImage imageNamed:COLLECT_IMAGE] forState:UIControlStateNormal];
    [collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *cButton = [[UIBarButtonItem alloc] initWithCustomView:collectButton];
    [self.ButtonView addSubview: collectButton];
    
    UIButton *shareButton= [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(15,
                                   40,
                                   30,
                                   30);
    shareButton.backgroundColor = [UIColor clearColor];
    [shareButton setImage:[UIImage imageNamed:SHARE_IMAGE] forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.ButtonView addSubview: shareButton];
    
    
    
    //UIBarButtonItem *sButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    //    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects: cButton,sButton,nil]];
    
    
}

-(void)shareButtonAction:(UIButton *)button {
    
    NSData *imageData = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.DetaHottravel.cover]] autorelease];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"557fc76c67e58e929b004b07"
                                      shareText:[NSString stringWithFormat:@"在#心途APP#上发现了一个有趣的热门游记【%@】", self.DetaHottravel.title]
                                     shareImage:[UIImage imageWithData:imageData]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];
    
}
-(void)collectButtonAction:(UIButton *) button{
    
    NSMutableDictionary *dic = [[SQLDataHandle shareDataHandle] selectHotDollectList:self.DetaHottravel.title];
    
    if ([dic.allKeys containsObject:self.DetaHottravel.title]) {
        
        UIAlertView *errorAler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:NULL, nil];
        [errorAler show];
    }else{
        
        [[SQLDataHandle shareDataHandle] insertHotDollectList: self.DetaHottravel.title andId:self.DetaHottravel.NextId];
        
        
        UIAlertView *successAler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:NULL, nil];
        [successAler show];
        
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//设定区
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *SectionV=[[[UIView alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               [UIScreen mainScreen].bounds.size.width-20, 20)] autorelease];
    SectionV.backgroundColor=[UIColor orangeColor];
    NSLog(@"走起来");
    
    return SectionV;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.myArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *HotDetaCell = @"HotDetaCell";
    HotTravels_DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:HotDetaCell];
    if (cell==nil) {
        cell = [[HotTravels_DetailCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:HotDetaCell];
    }
    //消除点击cell 效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    cell.myHotTravel = [self.myArray objectAtIndex:indexPath.row];
    
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)RequestData
{
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    NSString *URLid = [NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/waypoints/?gallery_mode=1&sign=201d8d1f4f0cb5f3ec04952314a7d3ef" ,self.urlId];
    NSLog(@"%@",URLid);
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:URLid parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        self.myArray = [NSMutableArray array];
        self.cellHeightArray = [NSMutableArray array];
        
        self.RouteId =  [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"id"]];
        
        //接收 头部视图信息
        self.headerDic = [responseObject objectForKey:@"poi_infos_count"];
        NSNull * null = [[NSNull alloc]init];
        if ([responseObject objectForKey:@"trackpoints_thumbnail_image"]!= null) {
            
            self.headerPic   =[responseObject objectForKey:@"trackpoints_thumbnail_image"];
            
        }else
        {
            self.headerPic   =[responseObject objectForKey:@"cover_image"];
        }
        
        //头部 的title 内容
        self.titleText  =[responseObject objectForKey:@"name"];
        
        self.titlePic   =[[responseObject objectForKey:@"user"] objectForKey:@"avatar_s"];
        
        NSMutableArray      *daysArray = [ responseObject objectForKey:@"days"];
        self.SectionsArray =daysArray;
        for (NSMutableDictionary *daysDic in daysArray) {
            NSMutableArray *waypointsArray= [daysDic objectForKey:@"waypoints"];
            for (NSMutableDictionary *waypointsDic in waypointsArray) {
                
                HotTravel *DetaHotTravel = [HotTravel alloc];
                DetaHotTravel.NextText = [waypointsDic objectForKey:@"text"];
                DetaHotTravel.Nextcover= [waypointsDic objectForKey:@"photo"];
                DetaHotTravel.NextTime = [waypointsDic objectForKey:@"local_time"];
                
                NSNull * null = [[NSNull alloc]init];
                if ([waypointsDic objectForKey:@"photo_info"]!=null)
                {
                    //用NSInteger 接受 id 类型的转换方法
                    DetaHotTravel.Width    = [(NSNumber*)[[waypointsDic objectForKey:@"photo_info"]objectForKey:@"w"] integerValue];
                    DetaHotTravel.Hight   = [(NSNumber*)[[waypointsDic objectForKey:@"photo_info"]objectForKey:@"h"] integerValue];
                    CGFloat height = [PublicFunction heightForSubView:DetaHotTravel.NextText andWidth:335 andFontOfSize:15];
                    
                    DetaHotTravel.MyHeight =(DetaHotTravel.Hight*355)/DetaHotTravel.Width+67+height;
                    //强转
                    NSString *hight = [NSString stringWithFormat:@"%f",DetaHotTravel.MyHeight];
                    
                    [self.cellHeightArray addObject:hight];
                }
                else
                {   DetaHotTravel.Width =0;
                    DetaHotTravel.Hight =0;
                    CGFloat height = [PublicFunction heightForSubView:DetaHotTravel.NextText andWidth:335 andFontOfSize:15];
                    NSString *hight = [NSString stringWithFormat:@"%f",height];
                    [self.cellHeightArray addObject:hight];
                }
                
                if ([waypointsDic objectForKey:@"poi"]!= null) {
                    DetaHotTravel.NextPlace= [[waypointsDic objectForKey:@"poi"]objectForKey:@"name"];
                    //NSLog(@"%@!!!!",DetaHotTravel.NextPlace);
                }
                
                [self.myArray addObject:DetaHotTravel];
            }
            
        }
        
        
        
        
        
        [self.detaTable reloadData];//刷新显示数据 //调加头部方法
        
        [self getTableHeaderView];
        //结束菊花
        [self.MONAView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         NSLog(@"失败==== %@",error);
         
     }];
    
}

//点击cell 方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    PhotoViewController *PhotoVC= [[PhotoViewController alloc] init];
    PhotoVC.ArrayOfframe = self.myArray;
    PhotoVC.myHotTravel = [self.myArray objectAtIndex:indexPath.row];
    PhotoVC.myDelegate = self;
    PhotoVC.rowOfnumber = indexPath.row;
    
    if (PhotoVC.myHotTravel.Nextcover.length!=0)
    {
        [self presentViewController:PhotoVC animated:NO completion:^{
            
            
        }];
    }
    
    
}
//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //强转各种类型R
    CGFloat cellHeight = [[self.cellHeightArray objectAtIndex:indexPath.row]floatValue];
    
    return cellHeight+20;
    
}
//布局头部View
-(void)getTableHeaderView
{
    
    self.detaTable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 25, self.view.frame.size.width, 435)];
    
    //标题
    
    //标题图片
    UIImageView *UserPic = [[UIImageView alloc] init];
    UserPic.frame=CGRectMake(10,
                             10,
                             35, 35);
    CALayer *Userlay = UserPic.layer;
    [Userlay setMasksToBounds:YES];
    [Userlay setCornerRadius:17.5];
    UserPic.backgroundColor= [UIColor orangeColor];
    //获取头像图片
    NSString *UserurStr =self.titlePic;
    
    NSURL *Titleurl =[NSURL URLWithString:UserurStr];
    [UserPic sd_setImageWithURL:Titleurl placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    
    [self.detaTable.tableHeaderView addSubview:UserPic];
    [UserPic release];
    //标题TEXT
    UILabel     *titleText=[[UILabel alloc] init];
    titleText.text=self.titleText;
    titleText.frame=CGRectMake(53,
                               7,
                               327, 30);
    titleText.font = [UIFont boldSystemFontOfSize:17];
    titleText.textColor=[UIColor cyanColor];
    [self.detaTable.tableHeaderView addSubview:titleText];
    [titleText release];
    //地图
    UIImageView *HeaderViewUp = [[UIImageView alloc] init];
    HeaderViewUp.frame=CGRectMake(10,
                                  50,
                                  MYWIDTH-20, 185);
    //    HeaderViewUp.backgroundColor=[UIColor orangeColor];
    //给封面图片加圆角
    CALayer *lay = HeaderViewUp.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:4.50];
    //获取地图图片
    NSString *urStr =self.headerPic;
    
    
    NSURL *url =[NSURL URLWithString:urStr];
    [HeaderViewUp sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    
    
    [self.detaTable.tableHeaderView addSubview:HeaderViewUp];
    [HeaderViewUp release];
    //航程路线图片
    UIImageView *HeaderViewDown=[[UIImageView alloc] init];
    //imageView  默认交互为NO 所有控件的功能都失效 必须要打开来触发 用户交互功能
    HeaderViewDown.userInteractionEnabled = YES;
    HeaderViewDown.backgroundColor=[UIColor whiteColor];
    HeaderViewDown.frame=CGRectMake(10,
                                    240,
                                    MYWIDTH-20, 190);
    HeaderViewDown.image=[UIImage imageNamed:@"poi_bg_placeholder@2x"];
    [self.detaTable.tableHeaderView addSubview:HeaderViewDown];
    UIImageView *HeaderViewfirst=[[UIImageView alloc] init];
    HeaderViewfirst.backgroundColor=[UIColor lightGrayColor];
    HeaderViewfirst.frame=CGRectMake(0,
                                     -7,
                                     MYWIDTH-20, 7);
    [HeaderViewDown addSubview:HeaderViewfirst];
    [HeaderViewfirst release];
    
    UIImageView *HeaderViewlast = [[UIImageView alloc] init];
    HeaderViewlast.backgroundColor=[UIColor lightGrayColor];
    HeaderViewlast.frame=CGRectMake(0,
                                    170,
                                    MYWIDTH-20, 20);
    
    [HeaderViewDown addSubview:HeaderViewlast];
    [HeaderViewlast release];
    
    UILabel *HeaderViewlastText = [[UILabel alloc] init];
    HeaderViewlastText.frame = CGRectMake(0,
                                          0,
                                          MYWIDTH-30, 20);
    HeaderViewlastText.text = @"查看线路日程";
    HeaderViewlastText.textAlignment=NSTextAlignmentCenter;
    HeaderViewlastText.textColor = [UIColor grayColor];
    [HeaderViewlast addSubview:HeaderViewlastText];
    [HeaderViewlastText release];
    //设置一个BUtton给线路图
    UIButton *NextView= [UIButton buttonWithType:UIButtonTypeCustom];
    NextView.frame = CGRectMake(0,
                                0,
                                MYWIDTH-20, 190);
    NextView.backgroundColor = [UIColor clearColor];
    
    [NextView addTarget:self action:@selector(GoNextView:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //航班
    UIImageView *flightView = [[UIImageView alloc] init];
    flightView.frame = CGRectMake(15,
                                  30,
                                  35, 35);
    flightView.image = [UIImage imageNamed:@"flight_count_icon@2x"];
    [HeaderViewDown addSubview:flightView];
    [flightView release];
    
    UILabel *flightText = [[UILabel alloc] init];
    flightText.frame=CGRectMake(60,
                                30,
                                60, 35);
    [HeaderViewDown addSubview:flightText];
    [flightText release];
    //酒店
    UIImageView *hotel = [[UIImageView alloc] init];
    hotel.image = [UIImage imageNamed:@"sleep_icon@2x"];
    hotel.frame=CGRectMake(MYWIDTH-175,
                           30,
                           35, 35);
    [HeaderViewDown addSubview:hotel];
    [hotel release];
    
    UILabel *hotelText = [[UILabel alloc] init];
    hotelText.frame=CGRectMake(MYWIDTH-130,
                               30,
                               60, 35);
    [HeaderViewDown addSubview:hotelText];
    [hotelText release];
    
    //景点
    UIImageView *sights = [[UIImageView alloc] init];
    sights.image = [UIImage imageNamed:@"lalala"];
    sights.frame=CGRectMake(15,
                            90,
                            35, 35);
    [HeaderViewDown addSubview:sights];
    [sights release];
    
    UILabel *sightText = [[UILabel alloc] init];
    sightText.frame=CGRectMake(60,
                               90,
                               90, 35);
    sightText.text =@"0航班";
    [HeaderViewDown addSubview:sightText];
    [sightText release];
    
    //餐饮
    UIImageView *restaurant = [[UIImageView alloc] init];
    restaurant.frame=CGRectMake(MYWIDTH-175,
                                90,
                                35, 35);
    
    restaurant.image = [UIImage imageNamed:@"food_count_icon@2x"];
    [HeaderViewDown addSubview:restaurant];
    [restaurant release];
    
    UILabel *restaurantText = [[UILabel alloc] init];
    restaurantText.frame=CGRectMake(MYWIDTH-130,
                                    90,
                                    60, 35);
    restaurantText.text =@"0航班";
    [HeaderViewDown addSubview:restaurantText];
    [restaurantText release];
    
    //获取 航线信息
    flightText.text=[[NSString stringWithFormat:@"%@",[self.headerDic objectForKey:@"flight"]]stringByAppendingString:@" 航班"];
    ;
    hotelText.text=[[NSString stringWithFormat:@"%@",[self.headerDic objectForKey:@"hotel"]]stringByAppendingString:@" 住宿"];
    ;
    sightText.text=[[NSString stringWithFormat:@"%@",[self.headerDic objectForKey:@"sights"]]stringByAppendingString:@" 景点"];
    ;
    
    restaurantText.text=[[NSString stringWithFormat:@"%@",[self.headerDic objectForKey:@"restaurant"]]stringByAppendingString:@" 餐饮"];
    ;
    //把 BUtton 加上
    [HeaderViewDown addSubview:NextView];
    //取消引用次数
    [HeaderViewDown release];
    [_detaTable.tableFooterView release];
    
    //小国旗
    
}
-(void)GoNextView:(UIButton *)button
{
    NSLog(@"go  go  go !!");
    RouteListViewController *RouteListCV = [[RouteListViewController alloc] init];
    
    RouteListCV.RouteId =self.RouteId;
    [self.navigationController pushViewController:RouteListCV animated:YES];
    [RouteListCV release];
}
-(void)initMONA{
    NSLog(@"开始动画");
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y - 64);
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    
}

//代理方法
-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}
-(void)goBackgoBack:(NSInteger)number
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:number  inSection:0];
    [self.detaTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}
-(void)dealloc
{
    [_MONAView release];
    [_detaTable release];
    [_headerDic release];
    [_topNavView release];
    [super dealloc];
}

//换之前 走的 方法
-(void)viewWillDisappear:(BOOL)animated
{
    [self buttonDisappear];
    self.appeared = NO;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    //    [UIView animateWithDuration:0.1 animations:^{
    //        
    //        //继承View的 都有这个隐藏的功能
    //        self.ButtonView.hidden =YES;
    //        
    //        
    //    }];
    //    [self buttonDisappear];
    //    self.appeared = NO;
    //    self.ButtonView.hidden = YES;
    
}
@end
