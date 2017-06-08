//
//  PhotoViewController.m
//  XinTu
//
//  Created by 菊次郎 on 15-7-3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.photoView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.photoView.contentSize=CGSizeMake(self.ArrayOfframe.count*MYWIDTH,[UIScreen mainScreen].bounds.size.height);
    NSLog(@"%ld",self.ArrayOfframe.count);
    //边框回弹取消
    self.photoView.bounces = NO;
    self.photoView.pagingEnabled=YES;
    //photoView.delegate = self;
    self.photoView.showsHorizontalScrollIndicator = NO;
    self.photoView.showsVerticalScrollIndicator = NO;
    self.photoView.backgroundColor = [UIColor blackColor];
    //初始位置
    self.photoView.contentOffset=CGPointMake(self.rowOfnumber*MYWIDTH, 0);
    
//    self.frame = photoView.contentOffset.x;
    
    
    
    
    
    self.photo=[[UIImageView alloc] initWithFrame:CGRectMake(self.rowOfnumber*MYWIDTH, 0,MYWIDTH-20, (self.myHotTravel.Hight*MYWIDTH)/self.myHotTravel.Width) ];
  
    //photo.center =self.view.center;
    NSString *urStr =self.myHotTravel.Nextcover;
    
    NSURL *url =[NSURL URLWithString:urStr];
    [self.photo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.photo.center = CGPointMake(MYWIDTH/2 + self.rowOfnumber*MYWIDTH, [UIScreen mainScreen].bounds.size.height/2);
    [self.photoView addSubview:self.photo];
    [self.view addSubview:self.photoView];
 
   
    
    
    
    
    
    
    
    //创建个view 作为导航栏
    UIView *nacigationView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      MYWIDTH, 60)];
    nacigationView.backgroundColor=[UIColor blackColor];
    nacigationView.alpha=0.7;
    [self.view addSubview:nacigationView];
    
    //创建按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,
                                                                      20,
                                                                      70, 40)];
    backButton.backgroundColor=[UIColor blackColor];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:BACK_IMAGE] forState:UIControlStateNormal];
    

    
    //文字
    self.photoText = [[UILabel alloc] init];
    self.photoText.text =self.myHotTravel.NextText ;
    self.photoText.textColor = [UIColor whiteColor];
    CGFloat height = [PublicFunction heightForSubView:self.photoText.text andWidth:355 andFontOfSize:15];

    self.photoText.frame = CGRectMake(10,
                                 10,
                                 MYWIDTH-20, height);
    self.photoText.lineBreakMode=NSLineBreakByClipping;
    self.photoText.numberOfLines=0;
    self.photoText.font= [UIFont boldSystemFontOfSize:15];
    //文字下面的背景图
   self.blackView = [[UIView alloc] initWithFrame:CGRectMake(self.rowOfnumber*MYWIDTH,
                                                                 490,
                                                                 MYWIDTH, 150)];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha=0.7;
    
    [self.photoView addSubview:self.blackView];
    //文字的滚动视图
    self.textScroll = [[UIScrollView alloc] init];
  
    self.textScroll.frame=CGRectMake(0,
                                0,
                                MYWIDTH, 100);
   //滚动范围
    self.textScroll.contentSize= CGSizeMake(self.view.frame.origin.x, height);
    
    self.blackView.userInteractionEnabled=YES;
    [self.textScroll addSubview:self.photoText];
    [self.blackView addSubview:self.textScroll];
    //日期 .地点
    //时间
    self.local_time = [[UILabel alloc] init];
    self.local_time.textColor=[UIColor whiteColor];
    self.local_time.font=[UIFont italicSystemFontOfSize:13];
    self.local_time.text =[self.myHotTravel.NextTime substringToIndex:16];
    self.local_time.frame = CGRectMake(10,
                                  110,
                                  150, 30);
    [self.blackView addSubview:self.local_time];
//    _province.text  =myHotTravel.NextPlace;

    //地点
     self.province  = [[UILabel alloc] init];
    self.province.font=[UIFont boldSystemFontOfSize:13];
   self.province.textColor=[UIColor grayColor];
    self.province.text=self.myHotTravel.NextPlace;
    self.province.frame=CGRectMake(200*WIDTHR,
                              110,
                              150, 30);
    //让文字靠右
    self.province.textAlignment=NSTextAlignmentRight;
    [self.blackView addSubview:self.province];
    [self.view addSubview:nacigationView];
    [nacigationView addSubview:backButton];
    self.photoView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)goBack
{
    
    [self dismissViewControllerAnimated:NO completion:^{
        
    
        [self.myDelegate goBackgoBack:self.wichOne];
        
    }];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    self.frame =scrollView.contentOffset.x;
    //当前所在位置

    self.wichOne =scrollView.contentOffset.x/(MYWIDTH);
    self.myHotTravel=[self.ArrayOfframe objectAtIndex:scrollView.contentOffset.x/(MYWIDTH)];

    if (self.myHotTravel.Nextcover.length!=0) {
        
    self.photo.frame = CGRectMake(scrollView.contentOffset.x, 0,MYWIDTH-20, (self.myHotTravel.Hight*MYWIDTH-20)/self.myHotTravel.Width) ;
       }
    NSString *urStr =self.myHotTravel.Nextcover;
    
    NSURL *url =[NSURL URLWithString:urStr];
    [self.photo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    


    self.photo.center = CGPointMake(MYWIDTH/2 + scrollView.contentOffset.x, [UIScreen mainScreen].bounds.size.height/2);
    [self.photoView addSubview:self.photo];
    
    
    
    
    
    
    
    
    
    
    
    
    //文字

    
    self.photoText.text =self.myHotTravel.NextText ;
    self.photoText.lineBreakMode=NSLineBreakByClipping;
    self.photoText.numberOfLines=0;
    self.photoText.font= [UIFont boldSystemFontOfSize:15];
    CGFloat height = [PublicFunction heightForSubView:self.photoText.text andWidth:355 andFontOfSize:15];
    
    self.photoText.frame = CGRectMake(10,
                                      10,
                                      [UIScreen mainScreen].bounds.size.width-20, height);

    
    
    self.blackView.frame = CGRectMake((scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width))*[UIScreen mainScreen].bounds.size.width,
                                                              490*HEIGHTR,
                                                              [UIScreen mainScreen].bounds.size.width, 150*HEIGHTR);
    [self.photoView addSubview:self.blackView];
    //文字的滚动视图
   
    self.textScroll.frame=CGRectMake(0,
                                     0,
                                     [UIScreen mainScreen].bounds.size.width, 100);
    //滚动范围
    self.textScroll.contentSize= CGSizeMake(self.view.frame.origin.x, height);

    
 
    [self.textScroll addSubview:self.photoText];
    [self.blackView addSubview:self.textScroll];
  
    //日期 .地点
    //时间
    self.local_time.text=[self.myHotTravel.NextTime substringToIndex:16];

    self.local_time.font=[UIFont italicSystemFontOfSize:13];
        [self.blackView addSubview:self.local_time];
   
  
    
    //地点
    self.province.text=self.myHotTravel.NextPlace;
    self.province.font=[UIFont boldSystemFontOfSize:13];
    self.province.textColor=[UIColor grayColor];
    
//    province.frame=CGRectMake(200,
//                                   110,
//                                   150, 30);
    //让文字靠右
    self.province.textAlignment=NSTextAlignmentRight;
    [self.blackView addSubview:self.province];
    
        //*******************
}
@end
