//
//  ViewController.m
//  TypeView_Demo
//
//  Created by ZhengYi on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "TypeSelectView.h"


@interface ViewController (){
    TypeSelectView * tview;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
    tview = [[TypeSelectView alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 120, self.view.frame.size.height - 200)];
    tview.title = @"hello i am willson and I love helen";
    tview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tview];
    tview.typeArray = @[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888",@"999",@"aaa",@"bbb",@"ccc",@"ddd",@"eee",@"fff",];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touch begin");
    tview.typeArray = @[@"222",@"333",@"444",@"555",@"666"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
