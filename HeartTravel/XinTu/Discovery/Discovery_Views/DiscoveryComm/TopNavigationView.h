//
//  TopNavigationView.h
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopNavigationViewDelegate <NSObject>

-(void)navigationViewReturnButtonClicked;

@optional
-(void)navigationViewRightButtonClicked;
//-(void)changeTopNavigationViewAlphaWithOffsetY:(CGFloat)offsetY andOriginY:(CGFloat)originY;

@end

@interface TopNavigationView : UIView

@property (retain,nonatomic) UILabel  * cnnameLabel;
@property (retain,nonatomic) UILabel  * ennameLabel;
@property (retain,nonatomic) UIButton * returnButton;
@property (retain,nonatomic) UIImageView * imageView;
@property (retain,nonatomic) UIButton * rightButton;
@property (retain,nonatomic) UIView   * BKView;

@property (assign,nonatomic) id<TopNavigationViewDelegate> myDelegate;

-(void)setAlphaforSubViews:(CGFloat)alpha;

@end
