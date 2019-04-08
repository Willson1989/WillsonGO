//
//  ViewController.m
//  UIVisualEffectView_Demo
//
//  Created by ZhengYi on 16/10/25.
//  Copyright © 2016年 ZhengYi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIVisualEffectView *effectView;
@property (nonatomic, strong) UIVisualEffectView *subEffectView;

//为了使添加在模糊化图层上面的视图显示得更加生动，这里面需要使用 UIVibrancyEffect 来实现
@property (nonatomic, strong) UIVibrancyEffect *vibrancyEffect;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView addSubview:self.imageView];
    [self.scrollView setContentSize:self.imageView.frame.size];
    [self.view addSubview:self.scrollView];
    
    self.titleLabel.frame = CGRectMake(0, 0, self.effectView.frame.size.width, 30);
    self.titleLabel.center = CGPointMake(self.effectView.frame.size.width/2,
                                         self.effectView.frame.size.height/2);
    //注意，这里需要将子视图添加到 UIVisualEffectView 的 contentView 上面
    [self.subEffectView.contentView addSubview:self.titleLabel];
//    [self.effectView.contentView addSubview:self.titleLabel];
    //    UIBlurEffect;
    //    UIVisualEffect;
    //    UIVibrancyEffect;
    //    UIMotionEffect;
    //    UIInterpolatingMotionEffect : UIMotionEffect;
}

- (UIVisualEffectView *)effectView{
    if (_effectView == nil) {
        //通过 UIBlurEffect 来创建UIVisualEffectView实例
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _effectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        //设置UIVisualEffectView的frame
        _effectView.frame = CGRectMake(0, 200, self.view.bounds.size.width, 200);
        //将effectView添加到self.view上面，相当于一个遮罩层，在它后面的部分都会被模糊化
        [self.view addSubview:_effectView];
    }
    return _effectView;
}

- (UIVisualEffectView *)subEffectView{
    if (_subEffectView == nil) {
        //通过 effectView 的 effect 来创建 vibrancyEffect 实例
        UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:(UIBlurEffect *)self.effectView.effect];
        _subEffectView = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
        _subEffectView.frame = self.effectView.bounds;
        [self.effectView.contentView addSubview:_subEffectView];
    }
    return _subEffectView;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"bigImage"];
        _imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        _imageView.image = image;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"Hello World";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:45];
    }
    return _titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
