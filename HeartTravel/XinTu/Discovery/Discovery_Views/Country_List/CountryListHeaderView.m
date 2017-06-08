//
//  CountryListHeaderView.m
//  XinTu
//
//  Created by WillHelen on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CountryListHeaderView.h"

@implementation CountryListHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        self.titleLabel.text = @"其他国家";
        self.titleLabel.font = [UIFont boldSystemFontOfSize:COMMON_FONT_SIZE - 3];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
