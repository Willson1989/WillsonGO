//
//  FunctionCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FunctionCell.h"

@implementation FunctionCell

-(void)dealloc{
    
    [self.practicalInfoButton release];
    [self.recomRouteButton release];
    [super dealloc];
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)createSubViews{
    self.practicalInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.practicalInfoButton.frame = CGRectMake(0, CELL_INSET, FUNC_CELL_WIDTH-2, BUTTON_HEIGHT-2);
    [self.practicalInfoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.practicalInfoButton setTitle:@"实用信息" forState:UIControlStateNormal];
    
    self.recomRouteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recomRouteButton.frame = CGRectMake(0, BUTTON_HEIGHT+CELL_INSET*2, FUNC_CELL_WIDTH - 2, BUTTON_HEIGHT-2);
    [self.recomRouteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.recomRouteButton setTitle:@"推荐行程" forState:UIControlStateNormal];
    
    [self.practicalInfoButton addTarget:self action:@selector(pInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.recomRouteButton addTarget:self action:@selector(rRouteAction:) forControlEvents:UIControlEventTouchUpInside];
    self.practicalInfoButton.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
    self.recomRouteButton.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
    
    UIColor * uColor = [PublicFunction getColorWithRed:17.0 Green:117.0 Blue:67.0];
    [self.practicalInfoButton setTitleColor:uColor forState:UIControlStateNormal];
    [self.recomRouteButton setTitleColor:uColor forState:UIControlStateNormal];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.practicalInfoButton];
    [self.contentView addSubview:self.recomRouteButton];
    [self.practicalInfoButton release];
    [self.recomRouteButton release];
}

-(void)pInfoAction:(UIButton *)button{
    [self.myDelegate gotoPracticalInfoPage];
}

-(void)rRouteAction:(UIButton *)button{
    [self.myDelegate gotoRecomRoutePage];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
