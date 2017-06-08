//
//  FeatureDollectViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FeatureDollectViewController.h"

@implementation FeatureDollectViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    
    [self setNavigationItem];
    
    [self creatBackgroundView];
    
    [self creatTableView];
}

-(void)setNavigationItem{
    
    self.title = @"当地特色收藏";
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10 * WIDTHR,
                                  (64 / 2 * HEIGHTR - 10 * HEIGHTR),
                                  50 * WIDTHR ,
                                  30 * HEIGHTR);
    [leftButton setImage:[UIImage imageNamed:BACK_IMAGE] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
}
-(void)leftButtonAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    NSMutableDictionary *dic = [[SQLDataHandle shareDataHandle] selectAllFeatureDollectList];
    
    
    [self.dataArray removeAllObjects];
    for (NSString *key in dic) {
        
        FeatureDollectModel *list = [[FeatureDollectModel alloc] init];
        list.hotGuideTitle = key;
        list.hotGuideID = [dic objectForKey:key];
        [self.dataArray addObject:list];
        [list release];
    }
    if (self.dataArray.count == 0) {
        
        [self creatAlerView];
    }
}
-(void)creatAlerView{
    
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"空空的" message:@"主人，快去看看有神马你想藏起来悄悄观赏的当地特色吧" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alerView show];
}

-(void)getTitle:(NSString *)title andID:(NSString *)guideID{
    
    FeatureDollectModel *list = [[FeatureDollectModel alloc] init];
    list.hotGuideTitle = title;
    list.hotGuideID = guideID;
    [self.dataArray addObject:list];
    [list release];
}

-(void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   64,
                                                                   375,
                                                                   667 - 64)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    [_tableView release];
    
}
#pragma mark 设置需要编辑的row
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
#pragma mark 设置编辑的类型
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark 设置编辑的逻辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeatureDollectModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [[SQLDataHandle shareDataHandle] deletFeatureDollectList:model.hotGuideTitle];
    
    [tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"NewsListCell";
    
    FeatureDollectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FeatureDollectViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.list = [[FeatureDollectModel alloc] init];
    if (self.dataArray.count != 0) {
        cell.list = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示右箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消被选择时的效果
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotGuideDetailViewController *hotGuideVC = [[HotGuideDetailViewController alloc] init];
    
    FeatureDollectModel *list = [[[FeatureDollectModel alloc] init] autorelease];
    
    list = [self.dataArray objectAtIndex:indexPath.row];
    
    hotGuideVC.guideID = list.hotGuideID;
    
    [self.navigationController pushViewController:hotGuideVC animated:YES];
    
    [hotGuideVC release];
}



-(void)creatBackgroundView{
    
    UIImageView *bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    bg_view.alpha = 0.5;
    
    bg_view.image = [UIImage imageNamed:@"boat_background_image@2x.png"];
    
    [self.view addSubview:bg_view];
    
    [bg_view release];
    
    
}



@end
