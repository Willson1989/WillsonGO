//
//  TopPhotoScrollView.m
//  XinTu
//
//  Created by WillHelen on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TopPhotoScrollView.h"


//static NSInteger  pageIndex = 1;

@implementation TopPhotoScrollView

-(void)dealloc{
    
    [self.myTimer release];
    [self.allPhotoArray release];
    [self.photoArray release];
    [self.myPageControl release];
    [super dealloc];

}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.pageIndex = 1;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.bounces = NO;
    }
    return self;
}

-(void)setPhotoArray:(NSMutableArray *)photoArray{
    if (_photoArray != photoArray) {
        [_photoArray release];
        _photoArray = [photoArray retain];
    }
    self.allPhotoArray = [NSMutableArray arrayWithArray:photoArray];
    if (photoArray.count > 1) {
        [self.allPhotoArray addObject:[photoArray firstObject]];
        [self.allPhotoArray insertObject:[photoArray lastObject] atIndex:0];
    }
    [self setupImages];
    [self startTimer];
}

-(void)setupImages{
    
    self.contentSize = CGSizeMake(TOP_IMAGE_WIDTH * self.allPhotoArray.count, SCROLL_HEIGHT);
    for (NSInteger i = 0 ; i < self.allPhotoArray.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(TOP_IMAGE_WIDTH * i, 0, TOP_IMAGE_WIDTH, SCROLL_HEIGHT)];
        NSString * urlStr = [self.allPhotoArray objectAtIndex:i];
        //设置图片
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
        //添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
        [imageView release];
    }
}

-(void)setupPageControl{
    self.myPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SCROLL_HEIGHT-50, TOP_IMAGE_WIDTH, 40)];
    self.myPageControl.numberOfPages = self.allPhotoArray.count-2;
    [self addSubview:self.myPageControl];
}

-(void)startTimer{

    [self stopTimer];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}

-(void)stopTimer{
    if (self.myTimer) {
        if ([self.myTimer isValid]) {
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
    }
}

-(void)timeAction{
    self.myPageControl.currentPage = self.pageIndex;
    [self setContentOffset:CGPointMake(TOP_IMAGE_WIDTH * self.pageIndex, 0) animated:YES];
    if (self.pageIndex == self.allPhotoArray.count - 1) {
        self.contentOffset = CGPointMake(0, 0);
        self.pageIndex = 0;
    }
    self.pageIndex++;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.myPageControl.currentPage = self.contentOffset.x/375;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.myPageControl.currentPage = self.pageIndex;
    self.pageIndex = self.contentOffset.x/TOP_IMAGE_WIDTH;
    if (self.contentOffset.x == 0) {
        self.contentOffset = CGPointMake((self.allPhotoArray.count-2) * TOP_IMAGE_WIDTH, 0);
        self.pageIndex = self.allPhotoArray.count - 1;
    }
    if (self.contentOffset.x == TOP_IMAGE_WIDTH * (self.allPhotoArray.count - 1)) {
        self.contentOffset = CGPointMake(TOP_IMAGE_WIDTH, 0);
        self.pageIndex = 0;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self startTimer];
}

-(void)tapAction:(UITapGestureRecognizer*)tap{
    [self.myDelegate TopPhotoScrollView:self didSelectedAtIndex:self.pageIndex-1];
}

@end
