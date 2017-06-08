//
//  TopTabBar.h
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


#define TOP_BAR_HEIGHT  30.0f

@protocol TopTabBarDelegate <NSObject>

-(void)switchLeftPage;
-(void)switchRightPage;
@end

@interface TopTabBar : UIView

@property (retain,nonatomic) UIButton * lButton;
@property (retain,nonatomic) UIButton * rButton;
@property (assign,nonatomic) BOOL  leftSelected;

@property (assign,nonatomic) id <TopTabBarDelegate> myDelegate;

-(instancetype)initTopTabBarWithLeftName:(NSString*) lName andRightName:(NSString*)rName;


@end
