//
//  DiaryDollectViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DiaryDollectViewController.h"

@implementation DiaryDollectViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    
    [self setNavigationItem];
    
    [self creatTableView];
}
-(void)setNavigationItem{
    [PublicFunction setupNavigationBarforViewController:self];
    
    self.title = @"热门游记收藏";
    
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
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    NSMutableDictionary *dic = [[SQLDataHandle shareDataHandle] selectAllHotDollectList];
    
    [self.dataArray removeAllObjects];
    for (NSString *key in dic) {
        
        DiaryDellectModel *list = [[DiaryDellectModel alloc] init];
        list.imageTitle = key;
        list.nextID = [dic objectForKey:key];
        [self.dataArray addObject:list];
        [list release];
    }
    if (self.dataArray.count == 0) {
        
        [self creatAlerView];
    }
}
-(void)creatAlerView{
    
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"空空的" message:@"主人，快去看看有神马你想藏起来悄悄观赏的热门游记吧" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [alerView show];
}

-(void)getTitle:(NSString *)title andID:(NSString *)nextID{
    
    DiaryDellectModel *list = [[DiaryDellectModel alloc] init];
    list.imageTitle = title;
    list.nextID = nextID;
    [self.dataArray addObject:list];
    [list release];
}
-(void)creatTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   MYWIDTH,
                                                                   MYHEIGHT - 64)];
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
    
    DiaryDellectModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [self.dataArray removeObjectAtIndex:indexPath.row];
    
    [[SQLDataHandle shareDataHandle] deletHotDollectList:model.imageTitle];
    
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
    
    DiaryDollectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DiaryDollectViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.list = [[DiaryDellectModel alloc] init];
    if (self.dataArray.count != 0) {
        cell.list = [self.dataArray objectAtIndex:indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//显示右箭头
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消被选择时的效果
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didselect");
    HotTravelViewController *hotTravelVC = [[HotTravelViewController alloc] init];
    
    DiaryDellectModel *list = [[[DiaryDellectModel alloc] init] autorelease];
    
    list = [self.dataArray objectAtIndex:indexPath.row];
    
    hotTravelVC.urlId = list.nextID;
    
    [self.navigationController pushViewController:hotTravelVC animated:YES];
    
    [hotTravelVC release];
}

@end
