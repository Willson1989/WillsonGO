//
//  NavBackButton.h
//  XinTu
//
//  Created by WillHelen on 15/7/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavBackButton : UIBarButtonItem

@property (assign,nonatomic) SEL myAction;
@property (assign,nonatomic) id  myTarget;

+(instancetype)NavBackButtonWithTarget:(id)target Action:(SEL)sel;

@end
