//
//  FunctionView.m
//  XinTu
//
//  Created by WillHelen on 15/7/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FunctionView.h"

@implementation FunctionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        self.alpha=0.6;
        CALayer *lay = self.layer;
        [lay setMasksToBounds:YES];
        [lay setCornerRadius:4.50];
        [self createSubView];
    }
    return  self;
}

-(void)createSubView{
    self.collectButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectButton.frame = CGRectMake(15,
                                     5,
                                     30,
                                     30);
    self.collectButton.backgroundColor = [UIColor clearColor];
    [self.collectButton setImage:[UIImage imageNamed:COLLECT_IMAGE] forState:UIControlStateNormal];
    [self.collectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.collectButton addTarget:self action:@selector(collectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.collectButton];
    
    self.shareButton= [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.frame = CGRectMake(15,
                                   40,
                                   30,
                                   30);
    self.shareButton.backgroundColor = [UIColor clearColor];
    [self.shareButton setImage:[UIImage imageNamed:SHARE_IMAGE] forState:UIControlStateNormal];
    [self.shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview: self.shareButton];
}

-(void)collectButtonAction{
    [self.myDelegate doCollect];
}

-(void)shareButtonAction{
    [self.myDelegate doShare];
}


@end
