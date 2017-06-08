//
//  RecomTravelDetailViewController.h
//  XinTu
//
//  Created by WillHelen on 15/7/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecomTravelDetailViewController : UIViewController

@property (retain,nonatomic) UIWebView * myWebView;
@property (copy,nonatomic) NSString * view_url;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;


@end
