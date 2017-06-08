//
//  TopPhotoScrollView.h
//  XinTu
//
//  Created by WillHelen on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCROLL_HEIGHT  260
#define TOP_IMAGE_WIDTH  [[UIScreen mainScreen]bounds].size.width


@class TopPhotoScrollView;

@protocol TopPhotoScrollViewDelegate <NSObject>

@optional
-(void)TopPhotoScrollView:(TopPhotoScrollView *)scrollView didSelectedAtIndex:(NSInteger)index;

@end

@interface TopPhotoScrollView : UIScrollView<UIScrollViewDelegate>

@property (copy,nonatomic) id<TopPhotoScrollViewDelegate> myDelegate;
@property (retain,nonatomic) NSTimer * myTimer;
@property (retain,nonatomic) NSMutableArray * allPhotoArray;
@property (retain,nonatomic) NSMutableArray * photoArray;
@property (retain,nonatomic) UIPageControl * myPageControl;
@property (assign,nonatomic) NSInteger pageIndex;

//-(instancetype)initWithFrame:(CGRect)frame andPhotoArray:(NSMutableArray*)pArray;

-(void)startTimer;

-(void)stopTimer;

@end
