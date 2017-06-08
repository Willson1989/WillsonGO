//
//  HotTravelListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotTravelListViewController.h"


@interface HotTravelListViewController ()

@end

@implementation HotTravelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"推荐";
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    self.titleArray = [NSMutableArray array];
    self.myArray = [NSMutableArray array];
    [self creatTableView];
    //获取缓存数据
    [self getCacheData];
    
     [self  initMONA];
    //去掉cell的分隔线
    self.Mytable.separatorStyle = UITableViewCellSeparatorStyleNone;

    //从网络获取信息
    [self GetInFormation];
     self.page =0;
    [self addFooter];
    
}


-(void)creatTableView{
    
    self.Mytable = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                 0,
                                                                 self.view.frame.size.width,
                                                                 self.view.frame.size.height - 64 - 49)
                                                style:UITableViewStylePlain];
    
    
    self.Mytable.dataSource =self;
    self.Mytable.delegate   =self;
    [self.view addSubview:self.Mytable];
    [_Mytable release];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.myArray.count != 0) {
        
        return self.myArray.count;
    }else
        return 0;
    
}
//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 224;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{

    static NSString *HotCell = @"HotCell";
    HotTravelCell *cell = [tableView dequeueReusableCellWithIdentifier:HotCell];
    if (cell==nil) {
        cell = [[HotTravelCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:HotCell];
    }
    
    if (self.myArray.count != 0) {
        
        cell.myHotTravel =  [self.myArray objectAtIndex:indexPath.row];
    }
    //消除点击cell 效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    //渐变效果
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.alpha = 0;
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1];
    cell.alpha = 1;
    [UIView commitAnimations];
    
    return cell;
    
}
-(void)GetInFormation
{

    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    NSString *url_string = [NSString stringWithFormat:Recomone_URLNo_1];
    
    //[NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];  代表支持所有的接口类型
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:url_string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        NSMutableDictionary *dic=responseObject;

        NSMutableArray *array = [dic objectForKey:@"elements"];
        //删除从缓存获取的数据
        [self.myArray removeAllObjects];
        [self.titleArray removeAllObjects];
        for (NSMutableDictionary *movieDic in array) {
            NSString *Desc = [movieDic objectForKey:@"desc"];
            
            //判断 是否 是需要的数据
            if ([Desc isEqualToString:@"热门游记"])
            {
                NSMutableArray *hotDataArray = [movieDic objectForKey:@"data"];
                NSMutableDictionary *hotDataDic = [hotDataArray firstObject];
                HotTravel *hotTravel = [[HotTravel alloc] init];
                hotTravel.title =[hotDataDic objectForKey:@"name"];
                hotTravel.date  =[hotDataDic objectForKey:@"first_day"];
                //接收类型为 基本类型 需要转换为字符串类型
                hotTravel.days  = [NSString stringWithFormat:@"%@",[hotDataDic objectForKey:@"day_count"]] ;
                
                hotTravel.place =[hotDataDic objectForKey:@"popular_place_str"];
                
                hotTravel.browse=[NSString stringWithFormat:@"%@",[hotDataDic objectForKey:@"view_count"] ];
                hotTravel.cover =[hotDataDic objectForKey:@"cover_image_w640"];
                
                hotTravel.UserName=[[hotDataDic objectForKey:@"user"]objectForKey:@"name"];
                hotTravel.Userpic =[[hotDataDic objectForKey:@"user"]objectForKey:@"avatar_l"];
                
                hotTravel.NextId  =[NSString stringWithFormat:@"%@",[hotDataDic objectForKey:@"id"] ];
               
                [self.myArray addObject:hotTravel];
                [hotTravel release];
            }
            if ([Desc isEqualToString:@"一个专题"])
            {
                NSMutableArray *hotDataArray = [movieDic objectForKey:@"data"];
                NSMutableDictionary *hotDataDic = [hotDataArray firstObject];
                //HotTravel *hotTravel = [[HotTravel alloc] init];
                NSString *titlePic = [hotDataDic objectForKey:@"cover"];
           
//                NSString *cover_title=[hotDataDic objectForKey:@"cover_title"];
//                [self.titleArray addObject:cover_title];
                [self.titleArray addObject:titlePic];
                [self titlescto];
            }
        }
        [self.Mytable reloadData];//刷新显示数据
        [self.Mytable footerEndRefreshing];
        
        //获取缓存数据
        if (self.myArray.count != 0) {
            
            //获取缓存文件夹路径
            NSString *cachePath = [[CacheDataHandle shareDataHandle] getCachePath];
            
            //删除缓存文件
            NSString *oldFilePath = [NSString stringWithFormat:@"%@/HotTravelListDataArray.av",cachePath];
            [[CacheDataHandle shareDataHandle] removeCacheData:oldFilePath];
            NSString *oldFilePath2 = [NSString stringWithFormat:@"%@/HotTravelTitleDataArray.av",cachePath];
            [[CacheDataHandle shareDataHandle] removeCacheData:oldFilePath2];
            //获取缓存文件路径
            NSString *filePath = [[CacheDataHandle shareDataHandle] getKey:@"HotTravelListDataArray" andObject:self.myArray andPath:cachePath];
            NSString *filePath2 = [[CacheDataHandle shareDataHandle] getKey:@"HotTravelTitleDataArray" andObject:self.titleArray andPath:cachePath];
            
        }
        
        //结束动画
        [self.MONAView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        [self.MONAView stopAnimating];
        NSLog(@"失败==== %@",error);
        
    }];
    
    
}
#pragma mark 获取缓存数据
-(void)getCacheData{

    //获取缓存数据
    NSString *cachePath = [NSString stringWithFormat:@"%@/HotTravelListDataArray.av",[[CacheDataHandle shareDataHandle] getCachePath]];
    NSString *cachePath2 = [NSString stringWithFormat:@"%@/HotTravelTitleDataArray.av",[[CacheDataHandle shareDataHandle] getCachePath]];
    //创建一个文件管理器对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
    if ([fileManager fileExistsAtPath:cachePath]) {
    
        self.myArray = [[CacheDataHandle shareDataHandle] setData:cachePath];
        [self.Mytable reloadData];

    }
    //判断文件是否存在
    if ([fileManager fileExistsAtPath:cachePath2]) {
        
        self.titleArray = [[CacheDataHandle shareDataHandle] setData:cachePath2];
        [self titlescto];
    }

}


//滚动视图
-(void)titlescto
{

    mySctollview *scroll = [[mySctollview alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    scroll.backgroundColor = [UIColor yellowColor];
    
    self.Mytable.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 180)];
    [self.Mytable.tableHeaderView addSubview:scroll];
    
    [scroll setImages:self.titleArray];
    [scroll release];
    
}
//点击Cell方法 进去二级界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTravelViewController *HotTravelVC = [[HotTravelViewController alloc] init];
    [self.navigationController pushViewController:HotTravelVC animated:YES];
    
    HotTravelVC.DetaHottravel =[self.myArray objectAtIndex:indexPath.row];
    
    HotTravelVC.urlId = HotTravelVC.DetaHottravel.NextId;
   
    [HotTravelVC.DetaHottravel release];
    [HotTravelVC release];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
//上拉刷新
-(void)addFooter{
    
    //调用第三方 -- 在尾部添加上拉刷新
    NSMutableArray *UrlArray = [NSMutableArray arrayWithObjects:Recomone_URLNo_2, Recomone_URLNo_3,Recomone_URLNo_4,Recomone_URLNo_5,Recomone_URLNo_6,Recomone_URLNo_7,Recomone_URLNo_8,Recomone_URLNo_9,Recomone_URLNo_10,Recomone_URLNo_11,Recomone_URLNo_12,Recomone_URLNo_13,Recomone_URLNo_14,Recomone_URLNo_15,Recomone_URLNo_16,Recomone_URLNo_17,Recomone_URLNo_18,Recomone_URLNo_19,Recomone_URLNo_20, nil];
    
    
    [self.Mytable addFooterWithCallback:^{
        
        [PublicFunction getDataByAFNetWorkingWithURL:[UrlArray objectAtIndex:self.page] Success:^(id data) {
            self.page++;
            if (self.page==19) {
                self.page=5;
            }
  
            NSMutableDictionary *dic=data;
            NSMutableArray *array = [dic objectForKey:@"elements"];
            for (NSMutableDictionary *movieDic in array) {
                NSString *Desc = [movieDic objectForKey:@"desc"];
                
                //判断 是否 是需要的数据
                if ([Desc isEqualToString:@"热门游记"])
                {
                    NSMutableArray *hotDataArray = [movieDic objectForKey:@"data"];
                    NSMutableDictionary *hotDataDic = [hotDataArray firstObject];
                    HotTravel *hotTravel = [[HotTravel alloc] init];
                    hotTravel.title =[hotDataDic objectForKey:@"name"];
                    hotTravel.date  =[hotDataDic objectForKey:@"first_day"];
                    //接收类型为 基本类型 需要转换为字符串类型
                    hotTravel.days  = [NSString stringWithFormat:@"%@",[hotDataDic objectForKey:@"day_count"]] ;
                    
                    hotTravel.place =[hotDataDic objectForKey:@"popular_place_str"];
                    
                    hotTravel.browse=[NSString stringWithFormat:@"%@",[hotDataDic objectForKey:@"view_count"] ];
                    hotTravel.cover =[hotDataDic objectForKey:@"cover_image_w640"];
                    
                    hotTravel.UserName=[[hotDataDic objectForKey:@"user"]objectForKey:@"name"];
                    hotTravel.Userpic =[[hotDataDic objectForKey:@"user"]objectForKey:@"avatar_l"];
                    
                    hotTravel.NextId  =[NSString stringWithFormat:@"%@",[hotDataDic objectForKey:@"id"] ];
                    
                    [self.myArray addObject:hotTravel];
                    [hotTravel release];
                }
                
            [self.Mytable reloadData];//刷新显示数据
            [self.Mytable footerEndRefreshing];//结束
            [self.MONAView stopAnimating];
            }
        }];
    }];

}
-(void)initMONA{
    NSLog(@"开始动画1");
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = self.view.center;
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    [self.MONAView release];
}

//代理方法
-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    NSLog(@"开始动画2");
    return SELECT_COLOR;
}

-(void)dealloc
{
    [_MONAView release];
    [_Mytable release];
    [_myHotTravel release];

[super dealloc];

}







@end
