//
//  OtherCountryCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "OtherCountryCell.h"

@implementation OtherCountryCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    self.backgroundColor = [UIColor whiteColor];
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
    [self.contentView addSubview:self.contentLabel];
}

@end
