//
//  RootViewController.m
//  downLoad_Demo
//
//  Created by Willson on 16/4/11.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "RootViewController.h"
#import "DownloadViewController.h"

@interface RootViewController ()


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)afnButtonAction:(id)sender {
    DownloadViewController *vc = [[DownloadViewController alloc]init];
    [vc setAFNStyle:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sessionButtonAction:(id)sender {
    DownloadViewController *vc = [[DownloadViewController alloc]init];
    [vc setAFNStyle:NO];
    [self.navigationController pushViewController:vc animated:YES];
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
