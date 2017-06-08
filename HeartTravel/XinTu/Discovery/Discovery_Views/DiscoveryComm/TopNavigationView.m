//
//  TopNavigationView.m
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TopNavigationView.h"

#define LABEL_WIDTH 247.0f * WIDTHR
#define VIEW_HEIGHT 64.0f
#define EN_LABEL_HEIGHT 20.0f
#define CN_LABEL_HEIGHT 24.0f
#define SIDE_BUTTON_WIDTH 64.0f * WIDTHR
#define SCREEN_WIDTH  [[UIScreen mainScreen]bounds].size.width

@implementation TopNavigationView

-(void)dealloc{
    
    [self.cnnameLabel release];
    [self.ennameLabel release];
    [self.returnButton release];
    [self.imageView release];
    [self.rightButton release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
//    self.backgroundColor = SELECT_COLOR;
    self.BKView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.BKView.backgroundColor = SELECT_COLOR;
    self.cnnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIDE_BUTTON_WIDTH, 20, LABEL_WIDTH, CN_LABEL_HEIGHT)];
    self.ennameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIDE_BUTTON_WIDTH, CN_LABEL_HEIGHT+20, LABEL_WIDTH, EN_LABEL_HEIGHT)];
    
    self.cnnameLabel.font = [UIFont boldSystemFontOfSize:COMMON_FONT_SIZE];
    self.ennameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 3];
    self.cnnameLabel.textColor = [UIColor blackColor];
    self.ennameLabel.textColor = [UIColor grayColor];
    self.cnnameLabel.textAlignment = NSTextAlignmentCenter;
    self.ennameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.returnButton.frame = CGRectMake(0, 20, SIDE_BUTTON_WIDTH, SIDE_BUTTON_WIDTH-20);
    [self.returnButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.returnButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.returnButton setImage:[UIImage imageNamed:BACK_IMAGE] forState:UIControlStateNormal];
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(self.frame.size.width - self.returnButton.frame.size.width, 20, SIDE_BUTTON_WIDTH, SIDE_BUTTON_WIDTH-20);
    [self.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"dest_map_route@2x.png"] forState:UIControlStateNormal];
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"navViewBKG.png"]];
    _imageView.frame = self.frame;
    
    self.rightButton.backgroundColor  = [UIColor clearColor];
    self.returnButton.backgroundColor = [UIColor clearColor];
    self.ennameLabel.backgroundColor  = [UIColor clearColor];
    self.cnnameLabel.backgroundColor  = [UIColor clearColor];
    
    [self addSubview:self.BKView];
    [self addSubview:self.returnButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.ennameLabel];
    [self addSubview:self.cnnameLabel];
    
    [self.ennameLabel release];
    [self.cnnameLabel release];
}

-(void)buttonAction:(UIButton*)button{
    [self.myDelegate navigationViewReturnButtonClicked];
}

-(void)rightButtonAction:(UIButton*)button{
    [self.myDelegate navigationViewRightButtonClicked];
}

-(void)setAlphaforSubViews:(CGFloat)alpha {
    if (alpha >= 0.9999) {
        alpha = 0.9999;
    }
    self.imageView.alpha = alpha;   
    self.BKView.alpha = alpha;
    self.ennameLabel.alpha = alpha;
    self.cnnameLabel.alpha = alpha;
}

@end
