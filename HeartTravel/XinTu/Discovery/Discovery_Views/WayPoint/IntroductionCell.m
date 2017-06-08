//
//  IntroductionCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "IntroductionCell.h"

@implementation IntroductionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WP_DETAIL_CELL_INSET,
                                                               WP_DETAIL_CELL_INSET + 2,
                                                               screenWidth,
                                                               screenWidth/25)];
    self.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 3];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor blackColor];
    
    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x,
                                                               self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height,
                                                               self.titleLabel.frame.size.width,
                                                               100)];
    self.introLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.introLabel.textColor = [UIColor grayColor];
    self.introLabel.textAlignment = NSTextAlignmentLeft;
    
    self.extendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.extendButton setTitle:@"展开" forState:UIControlStateNormal];
    self.extendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.extendButton addTarget:self action:@selector(extendAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel release];
}

-(void)extendAction{
    [self.myDelegate extendCell];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
