//
//  MapBottomView.h
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMapList.h"

@protocol BottomViewDelegate <NSObject>

-(void)gotoPointDetailPage;

@end

@interface MapBottomView : UIView

@property (retain,nonatomic) UILabel * cnnameLabel;
@property (retain,nonatomic) UILabel * ennameLabel;
@property (retain,nonatomic) UIImageView * miniImageV;
@property (retain,nonatomic) BaseMapList * baseList;
@property (retain,nonatomic) UIImageView * bkImageV;

@property (assign,nonatomic) id <BottomViewDelegate> myDelegate;


-(instancetype)bottomView;

@end
