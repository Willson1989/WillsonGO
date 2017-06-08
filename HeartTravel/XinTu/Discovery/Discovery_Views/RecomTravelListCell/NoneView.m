//
//  NoneView.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NoneView.h"

@implementation NoneView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [PublicFunction getColorWithRed:227.0 Green:227.0 Blue:227.0];
        UILabel * noneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), 40)];
        noneLabel.center = self.center;
        noneLabel.text = title;
        noneLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE + 4];
        noneLabel.textColor = [UIColor grayColor];
        noneLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:noneLabel];
        [noneLabel release];
    }
    return self;
}

@end
