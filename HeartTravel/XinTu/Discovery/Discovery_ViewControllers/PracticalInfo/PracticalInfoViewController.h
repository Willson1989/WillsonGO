//
//  PracticalInfoViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PracticalInfoViewController : UIViewController

@property (retain,nonatomic) UIWebView * myWebView;
@property (copy,nonatomic) NSString * overview_url;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;

@end
