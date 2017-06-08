//
//  DetailPageCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DetailPageCell.h"

@implementation DetailPageCell

-(void)dealloc{
    [self.hotTitleLabel release];
    [self.allListButton release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)createSubViews{
    
    self.hotTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(6, 0, self.bounds.size.width/2, DETAIL_CELL_TOP_HEIGHT)];
    self.hotTitleLabel.textColor = [UIColor blackColor];
    self.hotTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.allListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allListButton.frame = CGRectMake(CGRectGetWidth([[UIScreen mainScreen]bounds])-80 * WIDTHR, 0, 80 * WIDTHR, DETAIL_CELL_TOP_HEIGHT);
    [self.allListButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.allListButton setTitle:@"查看所有" forState:UIControlStateNormal];
    self.allListButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.allListButton addTarget:self action:@selector(allListButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.allListButton.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.hotTitleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.allListButton];
    [self.contentView addSubview:self.hotTitleLabel];
    [self.allListButton release];
    [self.hotTitleLabel release];
}

-(void)allListButtonAction:(UIButton *)button{
    [self.myDelegate gotoAllListPageByClickedButton:button];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
