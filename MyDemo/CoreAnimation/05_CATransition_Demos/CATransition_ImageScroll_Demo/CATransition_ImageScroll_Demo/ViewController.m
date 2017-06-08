//
//  ViewController.m
//  CATransition_ImageScroll_Demo
//
//  Created by Willson on 16/4/15.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *_imageView;
    NSInteger _currentIndex;
    NSArray *_imgArray;
    NSInteger _imgCount;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgArray = @[@"cloud.png",
                  @"lake.png",
                  @"snow.png",
                  @"winter.png",
                  @"space.png",
                  @"sea.png",
                  @"bk.png"];
    _imgCount = _imgArray.count;
    
    _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _imageView.image = [UIImage imageNamed:_imgArray[_currentIndex]];
    [self.view addSubview:_imageView];
    [self setupSwipGesture];
}

- (void)setupSwipGesture{
    UISwipeGestureRecognizer *leftSwip  = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                   action:@selector(leftSwipAction)];
    UISwipeGestureRecognizer *rightSwip = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                   action:@selector(rightSwipAction)];
    leftSwip.direction  = UISwipeGestureRecognizerDirectionLeft;
    rightSwip.direction = UISwipeGestureRecognizerDirectionRight;
    
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:leftSwip];
    [_imageView addGestureRecognizer:rightSwip];
}

- (void)leftSwipAction{
    [self transition:YES];
}

- (void)rightSwipAction{
    [self transition:NO];
}

- (void)transition:(BOOL)isNext{
    CATransition *transition = [[CATransition alloc]init];
    
    /*
    用来描述动画的行进速度
    Timing function names:
    kCAMediaTimingFunctionLinear          动画匀速执行
    kCAMediaTimingFunctionEaseIn          动画逐渐变慢
    kCAMediaTimingFunctionEaseOut         动画逐渐加速
    kCAMediaTimingFunctionEaseInEaseOut   动画先缓慢，然后逐渐加速
    kCAMediaTimingFunctionDefault         默认值
     */
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.duration = 0.6;
    
    /*
    转场类型（type）
    苹果公开的类型：
    kCATransitionFade     淡出效果
    kCATransitionMoveIn   新视图移动到旧视图上
    kCATransitionPush     新视图推出旧视图
    kCATransitionReveal   移开旧视图显示新视图
     
    未公开的类型（只能使用字符串来指定）：
    cube                  立方体翻转效果
    oglFlip               翻转效果
    suckEffect            收缩效果
    rippleEffect          水滴波纹效果
    pageCurl              向上翻页效果
    pageUnCurl            向下翻页效果
    cameralIrisHollowOpen 摄像头打开效果
    cameraIrisHollowClose 摄像头关闭效果
    -------------------------
     
    转场子类型（subtypes）:
    kCATransitionFromRight  从右侧转场
    kCATransitionFromLeft   从左侧转场
    kCATransitionFromTop    从顶部转场
    kCATransitionFromBottom 从底部转场
     */
    transition.type = kCATransitionFade;
//    transition.type = @"cube";
//    transition.type = @"oglFlip";
//    transition.type = @"suckEffect";
//    transition.type = @"rippleEffect";
//    transition.type = @"suckEffect";
//    transition.type = @"pageCurl";
//    transition.type = @"pageUnCurl";
//    transition.type = @"cameralIrisHollowOpen";
//    transition.type = @"cameraIrisHollowClose";
    
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    } else {
        transition.subtype = kCATransitionFromLeft;
    }
    _imageView.image = [self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"img_transition"];
}

- (UIImage*)getImage:(BOOL)isNext{
    UIImage * image;
    if (isNext) {
        _currentIndex = (_currentIndex + 1) % _imgCount;
    } else {
        _currentIndex = (_currentIndex - 1 + _imgCount) % _imgCount;
    }
    image = [UIImage imageNamed:_imgArray[_currentIndex]];
    
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
