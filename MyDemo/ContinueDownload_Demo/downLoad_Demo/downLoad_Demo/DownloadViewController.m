//
//  DownloadViewController.m
//  downLoad_Demo
//
//  Created by Willson on 16/4/11.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "DownloadViewController.h"
#import "DownloadCell.h"
#import "DownLoadInfo.h"
#import "DownLoadInfoEx.h"

@interface DownloadViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dlInfoArr;
    UIButton *_bottomBtn;
}
@end

static NSString *downloadURL = @"http://106.2.184.226:9999/42.81.14.74/dlied6.qq.com/invc/xfspeed/qqpcmgr/download/QQPCDownload72878.exe?mkey=570b66dddeb6249f&f=d511&p=.exe";

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,
                                                              64,
                                                              self.view.frame.size.width,
                                                              self.view.frame.size.height-44-64)
                                             style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([DownloadCell class]) bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([DownloadCell class])];
    [self.view addSubview:_tableView];
    [self initBootomView];
    _dlInfoArr = [NSMutableArray array];
    [_tableView reloadData];
}

//AFNetWorking方式
- (void)addDownLoadTask{
    DownLoadInfo *dlInfo = [[DownLoadInfo alloc]initWithURL:[NSURL URLWithString:downloadURL]
       ProgressHandler:^(CGFloat comp, CGFloat total, NSInteger index) {
         
         [_tableView reloadData];
     } completeHandler:^(NSString *filePath, NSInteger index) {
         
         [_tableView reloadData];
     }];
    
    [_dlInfoArr addObject:dlInfo];
    dlInfo.index = [_dlInfoArr indexOfObject:dlInfo];
    [dlInfo startDownload];
    [_tableView reloadData];
}

//NSURLSession方式
- (void)addDownLoadTaskEx{
    DownLoadInfoEx *dlInfoEx = [[DownLoadInfoEx alloc]initWithURL:[NSURL URLWithString:downloadURL]
      ProgressHandler:^(CGFloat comp, CGFloat total, NSInteger index) {
        [_tableView reloadData];

    } completeHandler:^(NSString *filePath, NSInteger index) {
        [_tableView reloadData];

    }];
    [_dlInfoArr addObject:dlInfoEx];
    dlInfoEx.index = [_dlInfoArr indexOfObject:dlInfoEx];
    [dlInfoEx startDownload];
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dlInfoArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = NSStringFromClass([DownloadCell class]);
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[DownloadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (_dlInfoArr.count != 0) {
        if (_isAFNStyle) {
            [cell setDownLoadInfo:_dlInfoArr[indexPath.row]];
        } else{
            [cell setDownLoadInfoEx:_dlInfoArr[indexPath.row]];
        }
    }
    return cell;
}

-(void)initBootomView{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitle:@"ADD" forState:UIControlStateNormal];
        _bottomBtn.backgroundColor = [UIColor grayColor];
        [_bottomBtn setFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
        [_bottomBtn addTarget:self action:@selector(addDownloadAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomBtn];
    }
}

- (void)addDownloadAction:(UIButton*)sender{
    if (_isAFNStyle) {
        [self addDownLoadTask];
    } else {
        [self addDownLoadTaskEx];
    }
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
