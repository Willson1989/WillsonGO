//
//  RouteListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RouteListViewController.h"

@interface RouteListViewController ()

@end

@implementation RouteListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =@"线路日程";
    UIImage * image = [UIImage imageNamed:BACK_IMAGE];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.MyTable =[[UITableView alloc] initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStyleGrouped];
    
    self.MyTable.delegate =self;
    self.MyTable.dataSource=self;
    
    [self.view addSubview:self.MyTable];
    [_MyTable release];
        //去掉cell的分隔线
    self.MyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initMONA];

    [self Reques];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,MYWIDTH, 120)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.MyTable.tableFooterView=footerView;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10 * WIDTHR,
                                  (64 / 2 * HEIGHTR - 10 * HEIGHTR),
                                  50 * WIDTHR ,
                                  30 * HEIGHTR);
    [leftButton setImage:[UIImage imageNamed:BACK_IMAGE] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

-(void)leftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return self.Sectionarray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    Route *cellRoute = [[[Route alloc] init] autorelease];
    cellRoute=[self.Cellarray objectAtIndex:section];
    
    return cellRoute.Cellnumber;
   
}
//定义区头
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{   Route *cellRoute = [[Route alloc] init];
    cellRoute=[self.Cellarray objectAtIndex:section];
    
   
    NSString *a =@"第";
    NSString *b = [a stringByAppendingString:cellRoute.days];
    NSString *c =[b stringByAppendingString:@"天  "];
    NSString *d =[cellRoute.date substringFromIndex:5 ];
    NSString *e =[[d substringToIndex:2]stringByAppendingString:@"月"] ;
    NSString *f=[[d substringFromIndex:3] stringByAppendingString:@"日"];
    NSString *g=[e stringByAppendingString:f];
    NSString *fa=[c stringByAppendingString:g];
    return fa;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RouteCell = @"RouteCell";
   RouteListCell *cell = [tableView dequeueReusableCellWithIdentifier:RouteCell];
    if (cell==nil) {
        cell = [[RouteListCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:RouteCell];
    }
   
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSMutableArray  *array =[self.bigdateArray objectAtIndex:indexPath.section];
  
    cell.cellRoute = [array objectAtIndex:indexPath.row];
    
    
    
    
    
    return cell;

}
-(void)Reques
{
  
    AFNetworkReachabilityManager *netWorkManager = [AFNetworkReachabilityManager sharedManager];
    //http://api.breadtrip.com/trips/2386608332/schedule/
     NSString *URLid = [NSString stringWithFormat:@"http://api.breadtrip.com/trips/%@/schedule/" ,self.RouteId
                       
];
    NSLog(@"%@~~~~~~",URLid);
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [manager GET:URLid parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [netWorkManager stopMonitoring];
        
        self.Cellarray   =[NSMutableArray array];
        self.Sectionarray=[NSMutableArray array];
        self.bigdateArray=[NSMutableArray array];
        self.Sectionarray=responseObject;
        for (NSMutableDictionary *Dic in responseObject)
        {NSLog(@"~~~~~~~~~~~~~~~~~~~");
        Route *route = [[Route alloc] init];
        NSMutableArray *Array = [Dic objectForKey:@"places"];
       
        self.dateArray   =[NSMutableArray array];
        route.days= [NSString stringWithFormat:@"%@",[Dic objectForKey:@"days"]];
        route.date=route.date=[Dic objectForKey:@"date"];
        
        
        
        
        for (NSMutableDictionary *dic in Array)
    {
        NSLog(@"dic   遍历 array  走 一次");
                Route *routeTxet= [[Route alloc] init];
        routeTxet.PlaceText =[[dic objectForKey:@"place"] objectForKey:@"name"];
        routeTxet.PlaceID   =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"place"] objectForKey:@"id"]];
        routeTxet.PlaceType =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"place"] objectForKey:@"type"]];
        
        [self.dateArray addObject:routeTxet];
    
        //白色cell
        for (NSMutableDictionary *poisDic in [dic objectForKey:@"pois"])
        {   NSLog(@"走一遍~~~~");
            Route *routeTxet= [[Route alloc] init];
            routeTxet.PlaceText = [poisDic objectForKey:@"name"];
            routeTxet.PlaceType =[NSString stringWithFormat:@"%@",[poisDic objectForKey:@"type"]];
            routeTxet.PlaceID   =[NSString stringWithFormat:@"%@",[poisDic objectForKey:@"id"]];
            NSMutableArray *cellarray=[self.dic objectForKey:@"pois"];
            NSLog(@"~~~cell===%ld,%@",cellarray.count,routeTxet.PlaceText);
        [self.dateArray addObject:routeTxet];
        }
        NSLog(@"%ld cell的个数",self.dateArray.count);
        route.Cellnumber=self.dateArray.count;
    }
        
        
        
        
        
         [self.Cellarray addObject:route];

        [self.bigdateArray addObject:self.dateArray];
          
    
    }
    

        [self.MyTable reloadData];//刷新显示数据
        //结束动画
        [self.MONAView stopAnimating];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
         
         NSLog(@"失败==== %@",error);
         
     }];






    
}
//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        NSMutableArray  *array =[self.bigdateArray objectAtIndex:indexPath.section];
        SpotsDetailViewController *spotsVC = [[SpotsDetailViewController alloc] init];
        spotsVC.myRout  = [array objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:spotsVC animated:YES];
    

    
    
    
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)initMONA{
    NSLog(@"开始动画");
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = self.view.center;
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    
}
//代理方法
-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}
//设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}
-(void)dealloc
{

    [super dealloc];
}
@end
