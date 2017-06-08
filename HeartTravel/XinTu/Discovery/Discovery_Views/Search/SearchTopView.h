//
//  SearchTopView.h
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTopDeleget <NSObject>

-(void)dismissCurrentPage;

@end

@interface SearchTopView : UIView

@property (retain,nonatomic) UIButton * cancelButton;

@property (assign,nonatomic) id <SearchTopDeleget> myDelegate;


-(instancetype)init;

@end
