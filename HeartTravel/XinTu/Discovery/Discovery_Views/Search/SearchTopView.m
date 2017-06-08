//
//  SearchTopView.m
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SearchTopView.h"

@implementation SearchTopView

-(instancetype)init{
    self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), 64)];
    if (self) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelButton.frame = CGRectMake(CGRectGetWidth([[UIScreen mainScreen]bounds]) - 48, 20, 44, 44);
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 2];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelButton];
}

-(void)cancelButtonAction{
    NSLog(@"asdasd");
    [self.myDelegate dismissCurrentPage];
}

@end
