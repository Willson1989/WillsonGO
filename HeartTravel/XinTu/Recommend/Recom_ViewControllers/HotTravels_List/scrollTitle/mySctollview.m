//
//  mySctollview.m
//  豆瓣1.1
//
//  Created by 菊次郎 on 15-6-8.
//  Copyright (c) 2015年 菊次郎. All rights reserved.
//

#import "mySctollview.h"
@interface UIScrollView () <UIScrollViewDelegate>

@end
@implementation mySctollview

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.page = 1;
        self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //边框回弹取消
        self.scroll.bounces = NO;
        self.scroll.delegate = self;
        self.scroll.showsHorizontalScrollIndicator = NO;
        self.scroll.showsVerticalScrollIndicator = NO;
        [self addSubview:_scroll];
        //加点
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(60*WIDTHR, 150, 260*WIDTHR, 30)];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:self.pageControl];
        
        
        [_pageControl release];
    }
    return self;
}
#pragma mark -
#pragma mark 给scrollView添加图片
//为什么要建一个方法
- (void)setImages:(NSMutableArray *)namesArr{
    NSMutableArray *names = [NSMutableArray arrayWithArray:namesArr];
    NSString *first = [names firstObject];
    NSString *last = [names lastObject];
    [names insertObject:last atIndex:0];
    
    [names addObject:first];
    self.pageControl.numberOfPages =names.count-2;
    //滑动范围
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width *names.count, 0);
    
    [self createTimer];//创建定时器
    
    NSMutableArray *arr = [NSMutableArray array];
   
    for (NSString *titlePic in names) {
        
        [arr addObject:titlePic];
    }
    
    int i = 0;
   
    
    for (NSString *name in arr) {
        
        UIImageView *im = [[UIImageView alloc]initWithFrame:CGRectMake(self.scroll.frame.size.width * i, 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
        im.tag = 10000 + i;
        NSURL *url = [NSURL URLWithString:name];
       
        [im sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];

        
        [self.scroll addSubview:im];
        _scroll.pagingEnabled= YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [im addGestureRecognizer: tap];
        im.userInteractionEnabled = YES;
        
        i++;
    }
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width, 0)];

}
#pragma mark --创建定时器
-(void)createTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAciton:) userInfo:nil repeats:YES];
}

#pragma mark --定时器调用的方法
- (void)timerAciton:(NSTimer *)timer{
    
    //当正常滚动的时候
    self.page ++;
    //将要到达偏移量的宽度
    CGFloat offWith = _scroll.frame.size.width *self.page;
    
    
       [self.scroll setContentOffset:CGPointMake(offWith, 0) animated:YES];
  
    
    
    //当不是正常滚动,滚动到边缘就取消动画
    NSInteger number = self.scroll.contentSize.width / self.scroll.frame.size.width;
    //number是当前图片个数
    if (offWith == self.scroll.frame.size.width * (number - 1)) {
        self.page = 1;
        [self.scroll setContentOffset:CGPointMake(0, 0)];
       
    }
    
}

#pragma mark-- 停止定时器
-(void)stopTimer
{
    if (self.myTimer) {
        
        if (self.myTimer.isValid) {//如果是开启状态
            
            [self.myTimer invalidate];
            self.myTimer = nil;
        }
        
    }
    
}

#pragma mark--手指将要拖拽的时候停止计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
    }
#pragma mark--将要结束拖拽,也就是手指离开的时候
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self createTimer];
    
}

#pragma mark --加速结束的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    

    CGSize  size = scrollView.contentSize;
    CGFloat with = scrollView.frame.size.width;
    self.page = scrollView.contentOffset.x / with;
    
    //往左划,如果是滑到最后一张图
    if (scrollView.contentOffset.x == (size.width - with)) {
        
        self.page = 1;
        [scrollView setContentOffset:CGPointMake(with, 0)];
        
    }
    //往右滑,如果滑到第一张图
    if (scrollView.contentOffset.x == 0){
        
        self.page = scrollView.contentSize.width / scrollView.frame.size.width - 2 ;
        [scrollView setContentOffset:CGPointMake(size.width - with * 2, 0)];
    }
    
}


#pragma mark tapAction;
//题头图片点击触发的方法
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    
    //获得点击的视图
    UIImageView *image = (UIImageView *)tap.view;
    
  
    return;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.pageControl.currentPage = self.scroll.contentOffset.x / 375;
}


- (void)changePage:(UIPageControl *)page
{
    [self.scroll setContentOffset:CGPointMake((page.currentPage + 1) * 355, 0) animated:YES];
}

@end
