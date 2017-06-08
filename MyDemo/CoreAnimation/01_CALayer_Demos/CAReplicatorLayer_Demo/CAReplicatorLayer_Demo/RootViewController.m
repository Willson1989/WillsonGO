//
//  RootViewController.m
//  CAReplicatorLayer_Demo
//
//  Created by Willson on 16/4/25.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "RootViewController.h"
#import "ZYProgressView.h"
#import "UIScrollView+zyProgress.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RootViewController

- (void)loadView{
    NSLog(@"aaa");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100;
    _tableView.zy_header = [ZYProgressView progressViewWithBlock:^{
        
    }];
    [self.view addSubview:_tableView];
    _tableView.panGestureRecognizer;
}

- (void)addReplicatorLayer{
    CAReplicatorLayer *rLayer = [CAReplicatorLayer layer];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellid = @"adad";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"index : %li",indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
