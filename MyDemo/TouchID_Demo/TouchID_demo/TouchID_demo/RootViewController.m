//
//  RootViewController.m
//  TouchID_demo
//
//  Created by WillHelen on 16/5/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "RootViewController.h"

//导入Local Authentication框架
#import <LocalAuthentication/LocalAuthentication.h>

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.authenticateBtn];
}

- (void)autenticateAction{
    
    //LAContext是Local Authentication框架的核心
    LAContext *context = [[LAContext alloc]init];
    
    NSError *error = nil;
    //LAPolicyDeviceOwnerAuthenticationWithBiometrics touchID验证方式
    BOOL canEvaluatePolicy = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (canEvaluatePolicy) {
        //如果设备支持touchID
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"你是机主吗？"
                          reply:^(BOOL success, NSError * _Nullable error) {
                              if (error) {
                                  [self showAlertWithTitle:@"Error" Message:@"验证出错"];
                                  return;
                              }
                              if (success) {
                                  //验证通过
                                  [self showAlertWithTitle:@"Success" Message:@"验证通过，你是机主"];
                                  
                              } else{
                                  //验证没通过
                                  [self showAlertWithTitle:@"Failed" Message:@"验证失败，你不是机主"];
                              }
                          }];
        
    } else{
        [self showAlertWithTitle:@"Error" Message:@"设备不支持TouchID"];
    }
}

- (void)showAlertWithTitle:(NSString*)title Message:(NSString*)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (UIButton *)authenticateBtn{
    if (_authenticateBtn == nil) {
        _authenticateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _authenticateBtn.frame = CGRectMake(0, self.view.frame.size.height/2, CGRectGetWidth(self.view.frame), 50);
        [_authenticateBtn setTitle:@"TouchID验证身份" forState:UIControlStateNormal];
        [_authenticateBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_authenticateBtn setBackgroundColor:self.view.backgroundColor];
        [_authenticateBtn addTarget:self action:@selector(autenticateAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    return _authenticateBtn;
}
@end
