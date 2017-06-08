//
//  MainListViewController.m
//  Audio_Test-001
//
//  Created by ZhengYi on 16/9/22.
//  Copyright © 2016年 ZhengYi. All rights reserved.
//

#import "MainListViewController.h"
#import "AVPlayerDemoViewController.h"
#import "RecordViewController.h"
#import "GetWifiInfoViewController.h"

#define  kCell_Title_AVAudioPlayer @"音频播放"
#define  kCell_Title_AVAudioRecord @"录音"
#define  kCell_Title_WIFIName @"获取wifi网络名称"

@interface MainListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;

@end

@implementation MainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Audio Demo";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.titleArray = [[NSMutableArray alloc]initWithObjects:kCell_Title_AVAudioPlayer,
                       kCell_Title_AVAudioRecord,kCell_Title_WIFIName,nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"commonCellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *title = [self.titleArray objectAtIndex:indexPath.row];
    
    if ([title isEqualToString:kCell_Title_AVAudioPlayer]) {
        AVPlayerDemoViewController *playerVC = [[AVPlayerDemoViewController alloc] init];
        [self.navigationController pushViewController:playerVC animated:YES];
    }
    else if ([title isEqualToString:kCell_Title_AVAudioRecord]) {

        RecordViewController *recordVC = [[RecordViewController alloc] init];
        [self.navigationController pushViewController:recordVC animated:YES];
        
    }
    else if ([title isEqualToString:kCell_Title_WIFIName]) {

        GetWifiInfoViewController *recordVC = [[GetWifiInfoViewController alloc] init];
        [self.navigationController pushViewController:recordVC animated:YES];
        
    }
}

@end
