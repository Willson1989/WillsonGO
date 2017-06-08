//
//  PhotoViewController.h
//  XinTu
//
//  Created by 菊次郎 on 15-7-3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTravel.h"

@protocol goBackInDetaC <NSObject>

-(void) goBackgoBack:(NSInteger )number;

@end

@interface PhotoViewController : UIViewController<UIScrollViewDelegate>


@property (nonatomic,retain) NSMutableArray *ArrayOfframe;

@property (nonatomic,retain) HotTravel  *myHotTravel;

//row 数值
@property (nonatomic,assign)NSInteger rowOfnumber;

@property (nonatomic,assign)CGFloat  frame;


//******全属性
@property (nonatomic,retain) UIScrollView *photoView;
@property (nonatomic,retain) UIImageView *photo;
@property (nonatomic,retain) UILabel *photoText;
@property (nonatomic,retain) UIView *blackView ;
@property (nonatomic,retain) UIScrollView *textScroll;
@property (nonatomic,retain) UILabel *local_time;
@property (nonatomic,retain) UILabel  *province;

//协议
@property (nonatomic,assign)id<goBackInDetaC>myDelegate;
@property (nonatomic,assign)NSInteger wichOne;
@end
