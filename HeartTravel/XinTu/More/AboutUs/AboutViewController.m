//
//  AboutViewController.m
//  XinTu
//
//  Created by Bunny on 15/7/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatBackgruandView];
    
    [self creatLabel];
    
    [self setNavigationItem];
}

-(void)setNavigationItem{
    
    self.title = @"关于";
    
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
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

-(void)creatBackgruandView{
    
    UIImageView *iamgeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_rightVC.png"]];
    iamgeView.frame = CGRectMake(0,
                                 64,
                                 MYWIDTH,
                                 MYHEIGHT);
    [self.view addSubview:iamgeView];
    [iamgeView release];
}

-(void)creatLabel{
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                          MYHEIGHT / 6,
                                                          MYWIDTH - 20,
                                                          300)];
    self.label.center = self.view.center;
    self.label.backgroundColor = [UIColor clearColor];
    self.label.text = @"AwesomeTeam倾情奉献!\n如有疑问或建议请联系我们\n联系方式: QQ1 1065908274\nQQ2 361824009\nQQ3 200816932";
    self.label.numberOfLines = 0;
    self.label.font = [UIFont boldSystemFontOfSize:17];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.label];
    [_label release];
    
}

-(void)dealloc{
    
    [_label release];
    [super dealloc];
}

@end
