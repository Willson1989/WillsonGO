//
//  ViewController.m
//  CAShapeLayer_SparkCemera_Demo
//
//  Created by Willson on 16/4/19.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"
#import "ColorLoopView.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *resetButton;
@property (strong, nonatomic) ColorLoopView *colorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.colorView = [[ColorLoopView alloc]initWithFrame:self.view.frame StrokeWidth:10];
    [self.view addSubview:self.colorView];
    [self.view addSubview:self.resetButton];
}

- (UIButton *)resetButton{
    if (_resetButton == nil) {
        _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resetButton.backgroundColor = [UIColor clearColor];
        [_resetButton setTitle:@"reset" forState:UIControlStateNormal];
        _resetButton.frame = CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height - 50, 50, 30);
        [_resetButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_resetButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetButton;
}

- (void)resetAction{
    [self.colorView resetLayers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
