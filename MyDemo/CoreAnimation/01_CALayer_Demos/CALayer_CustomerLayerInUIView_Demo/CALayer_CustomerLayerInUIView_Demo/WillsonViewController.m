//
//  WillsonViewController.m
//  CALayer_CustomerLayerInUIView_Demo
//
//  Created by Willson on 16/4/12.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "WillsonViewController.h"
#import "WillsonView.h"

@interface WillsonViewController ()

@end

@implementation WillsonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    WillsonView *view = [[WillsonView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
