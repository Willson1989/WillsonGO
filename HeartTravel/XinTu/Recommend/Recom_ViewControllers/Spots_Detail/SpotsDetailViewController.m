//
//  SpotsDetailViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SpotsDetailViewController.h"


@interface SpotsDetailViewController ()


@property (nonatomic, copy) void(^picBlock)(NSString *picUrl);
@property(nonatomic,retain)NSMutableArray *countryArray;


@end



@implementation SpotsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *downView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    downView.image=[UIImage imageNamed:@"downPIc.jpg"];
   
   
    [self RequestData];
    
    [self creatTableView];
    
    [self creatImageView];
    //去掉cell的分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

     [self initMONA];

    
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{    NSLog(@"%d个数",self.myArray.count);
    
    return self.myArray.count-1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"mycell";
    
    Spots_DetaTVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[Spots_DetaTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    cell.myRoute = [self.myArray objectAtIndex:indexPath.row+1 ];
   // NSLog(@"array : %@",self.myArray);
   // NSLog(@"cell.myRoute : %@",cell.myRoute);
    return cell;
}




-(void)creatTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                  MYWIDTH,
                                                                   [UIScreen mainScreen].bounds.size.height - 64 - 49) style:UITableViewStylePlain];
    
    //    第一步 设定tableView的显示内容的界面与屏幕四周的空隙（上，左，下，右）
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT, // 从而tableView的cell起始于 (240,0)
                                                   0,
                                                   0,
                                                   0);
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [_tableView release];
}

// 第三步 让imageView的frame随tableView偏移量的改变而改变（由于imageView是添加到tableView,故frame以tableView的起始位置为基准）
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 在tableView滚动（tableView偏移量变化，即scrollView.contentOffset）的时候，让imageView随着偏移量改变而改变frame
    if (scrollView.contentOffset.y < -IMAGE_HEIGHT) { // tableView向下滚动时候，偏移量是负数；反之，偏移量是正数
        
        CGRect tempFrame = self.topImageView.frame; //通过中间量来改变imageView的frame
        
        tempFrame.origin.y = scrollView.contentOffset.y; // 坐标y值随tablView的Y轴偏移量改变，结果为负数，故上移
        
        tempFrame.origin.x =(IMAGE_HEIGHT +scrollView.contentOffset.y) / 2; // 坐标x轴随tablView的Y轴偏移量与imageView的高度的差值改变，左移
        // 除以2是保证图片横向拉伸时是以中点为基准
        
        tempFrame.size.width = MYWIDTH - (IMAGE_HEIGHT +scrollView.contentOffset.y);//宽度随tablView的Y轴偏移量与imageView的高度的差值改变，结果为正数，变宽
        
        tempFrame.size.height = -(scrollView.contentOffset.y); // 高度随偏移量改变，结果为正数，故变长
        
        self.topImageView.frame = tempFrame;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //   第二步 设定imageView的起始位置,写在该方法中保证每次显示该页面时，imageView都是以初始frame显示
    self.topImageView.frame = CGRectMake(0, // 由于imageView是添加到tableView,故坐标原点以tableView的起始位置为基准
                                         -IMAGE_HEIGHT,
                                         MYWIDTH,
                                         240);
}

-(void)creatImageView{
    
    self.topImageView = [[UIImageView alloc] init];
    //图片
    
    self.picBlock = ^(NSString *urlStr){
        
        NSURL *url =[NSURL URLWithString:urlStr];
        [self.topImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
        //刷新自己 界面
        [self viewWillAppear:YES];
        
        
    };
    [self.topImageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    self.palceName = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                               -90,
                                                               200, 80)];
    
    self.palceName.textColor=[UIColor whiteColor];
    self.palceName.font = [UIFont boldSystemFontOfSize:30];
    
    [self.tableView addSubview:self.topImageView];
    
    [self.tableView addSubview:self.palceName];
    [_topImageView release];
}
//网络请求信息
-(void)RequestData
{
    
    self.countryArray = [NSMutableArray array];
    
       NSString *URLid = [NSString stringWithFormat:@"http://api.breadtrip.com//destination/place/%@/%@/photos/?gallery_mode=1&count=18&sign=cf6dd28d1dce8852e61d974cb5e610a1",self.myRout.PlaceType,self.myRout.PlaceID];
    NSLog(@"URL : %@",URLid);
        self.cellHeightArray = [NSMutableArray array];
    [PublicFunction getDataByAFNetWorkingWithURL:URLid Success:^(id data)
     {
         self.photoUrl = [[[data objectForKey:@"items"] firstObject] objectForKey:@"photo"];
         self.picBlock(self.photoUrl);
            for (NSMutableDictionary *Dic in [data objectForKey:@"items"]) {
             Route *route = [[Route alloc] init];
             route.spotsName = [Dic objectForKey:@"trip_name"];
            
             route.spotsPic  = [Dic objectForKey:@"photo_w640"];
             route.spotText  = [Dic objectForKey:@"text"];
             route.country   = [Dic objectForKey:@"country"];
            CGFloat height = [PublicFunction heightForSubView:route.spotText andWidth:340 andFontOfSize:15];
            NSString *hight = [NSString stringWithFormat:@"%f",height];
                NSLog(@"我要的高度%f",height);
            [self.cellHeightArray addObject:hight];
            [self.myArray addObject:route];
                //结束动画
                [self.MONAView stopAnimating];

         }
         [self.tableView reloadData];
     }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //强转各种类型R
    CGFloat cellHeight = [[self.cellHeightArray objectAtIndex:indexPath.row+1]floatValue];
    
    NSLog(@"%f........",cellHeight);
    
    
    return cellHeight+205+10;
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

@end
