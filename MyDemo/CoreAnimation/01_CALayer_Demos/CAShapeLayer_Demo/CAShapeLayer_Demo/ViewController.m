//
//  ViewController.m
//  CAShapeLayer_Demo
//
//  Created by Willson on 16/4/18.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"
#import "MultipleProgressView.h"

@interface ViewController ()
{
    CGFloat _redValue;
    CGFloat _yellowValue;
    CGFloat _blueValue;
    
}
@property (strong, nonatomic) MultipleProgressView *pView;
@property (strong, nonatomic) UITextField *redText;
@property (strong, nonatomic) UITextField *yellowText;
@property (strong, nonatomic) UITextField *blueText;
@property (strong, nonatomic) UIButton *confirmButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.redText];
    [self.view addSubview:self.blueText];
    [self.view addSubview:self.yellowText];
    [self.view addSubview:self.confirmButton];
    [self.view addSubview:self.pView];
}

- (MultipleProgressView *)pView{
    if (_pView == nil) {
        _pView = [[MultipleProgressView alloc]initWithFrame:CGRectMake(15, 244, 200, 200)];
    }
    return _pView;
}

- (UITextField *)redText{
    if (_redText == nil) {
        _redText = [[UITextField alloc]initWithFrame:CGRectMake(15, 64, 100, 30)];
        _redText.backgroundColor = [UIColor whiteColor];
        _redText.borderStyle = UITextBorderStyleRoundedRect;
        _redText.textAlignment = NSTextAlignmentLeft;
    }
    return _redText;
}

- (UITextField *)yellowText{
    if (_yellowText == nil) {
        _yellowText = [[UITextField alloc]initWithFrame:CGRectMake(15, 104, 100, 30)];
        _yellowText.backgroundColor = [UIColor whiteColor];
        _yellowText.borderStyle = UITextBorderStyleRoundedRect;
        _yellowText.textAlignment = NSTextAlignmentLeft;
    }
    return _yellowText;
}

- (UITextField *)blueText{
    if (_blueText == nil) {
        _blueText = [[UITextField alloc]initWithFrame:CGRectMake(15, 144, 100, 30)];
        _blueText.backgroundColor = [UIColor whiteColor];
        _blueText.borderStyle = UITextBorderStyleRoundedRect;
        _blueText.textAlignment = NSTextAlignmentLeft;
    }
    return _blueText;
}

- (UIButton *)confirmButton{
    if (_confirmButton == nil) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.frame = CGRectMake(15, 184, 50, 30);
        _confirmButton.backgroundColor = [UIColor whiteColor];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (void)confirmAction{
    _redValue    = _redText.text.floatValue;
    _yellowValue = _yellowText.text.floatValue;
    _blueValue   = _blueText.text.floatValue;
    [self.pView setProgressWithRedValue:_redValue
                            YellowValue:_yellowValue
                              BlueValue:_blueValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
