//
//  TopTabBar.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TopTabBar.h"



@implementation TopTabBar

-(void)dealloc{
    [self.lButton release];
    [self.rButton release];
    [super dealloc];
}

-(instancetype)initTopTabBarWithLeftName:(NSString*) lName andRightName:(NSString*)rName{
    self = [super initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), TOP_BAR_HEIGHT)];
    if (self) {
        [self setupSubView:lName :rName];
    }
    return  self;
}

-(void)setupSubView:(NSString*)lName :(NSString*)rName{
    self.lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lButton.frame = CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds])/2, TOP_BAR_HEIGHT);
    self.rButton.frame = CGRectMake(self.lButton.frame.size.width, 0, self.lButton.frame.size.width, TOP_BAR_HEIGHT);
    UIColor * selectColor = SELECT_COLOR;
    self.lButton.backgroundColor = [UIColor whiteColor];
    self.rButton.backgroundColor = [UIColor whiteColor];
    
//    [self.lButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [self.rButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [self.lButton setTitleColor:selectColor forState:UIControlStateNormal];
    [self.rButton setTitleColor:selectColor forState:UIControlStateNormal];
    
    [self.lButton setTitle:lName forState:UIControlStateNormal];
    [self.rButton setTitle:rName forState:UIControlStateNormal];
    
    [self.lButton addTarget:self action:@selector(lButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rButton addTarget:self action:@selector(rButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.leftSelected = NO;
    [self lButtonAction];
    [self addSubview:self.lButton];
    [self addSubview:self.rButton];
}

-(void)lButtonAction{
    
    if (self.leftSelected == NO) {
        [self.myDelegate switchLeftPage];
        UIColor * selectColor = SELECT_COLOR;
        self.lButton.backgroundColor = selectColor;
        [self.lButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rButton setTitleColor:selectColor forState:UIControlStateNormal];
        self.lButton.highlighted = YES;
        self.rButton.backgroundColor = [UIColor whiteColor];
        self.leftSelected = YES;
    }
}

-(void)rButtonAction{
    
    if (self.leftSelected == YES) {
        [self.myDelegate switchRightPage];
        UIColor * selectColor = SELECT_COLOR;
        self.rButton.backgroundColor = selectColor;
        [self.rButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.lButton setTitleColor:selectColor forState:UIControlStateNormal];
        self.lButton.highlighted = YES;
        self.lButton.backgroundColor = [UIColor whiteColor];
        self.leftSelected = NO;
    }
    
}


@end
