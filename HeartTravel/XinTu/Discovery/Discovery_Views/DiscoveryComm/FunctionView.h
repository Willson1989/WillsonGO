//
//  FunctionView.h
//  XinTu
//
//  Created by WillHelen on 15/7/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunctionViewDelegate <NSObject>

-(void)doCollect;
-(void)doShare;

@end

@interface FunctionView : UIView

@property (retain,nonatomic) UIButton * collectButton;
@property (retain,nonatomic) UIButton * shareButton;
@property (assign,nonatomic) id <FunctionViewDelegate> myDelegate;

@end
