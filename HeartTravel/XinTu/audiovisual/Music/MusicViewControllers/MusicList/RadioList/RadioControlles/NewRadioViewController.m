//
//  NewRadioViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NewRadioViewController.h"

@implementation NewRadioViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];;
    
    self.page = 1;
    
    self.dataArray = [NSMutableArray array];
    
    [self initMONA];
    
    [self creatBackgroundView];
    
    [self creatTableView];
    
    [self addHeader];
    
//    [self addFooter];
}

-(void)creatTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                TOP_BAR_HEIGHT,
                                                                MYWIDTH,
                                                                self.view.frame.size.height - self.tableView.frame.origin.y - 49 - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView release];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataArray.count != 0) {
        
        return self.dataArray.count;
    }else
        return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 115;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"resueCell";
    
    RadioListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[RadioListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if (self.dataArray.count != 0) {
        
        cell.musicList = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //渐变效果
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.alpha = 0;
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1];
    cell.alpha = 1;
    [UIView commitAnimations];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlayListViewController *playListVC = [[PlayListViewController alloc] init];
    
    MusicModel *model = [[MusicModel alloc] init];
    
    model = [self.dataArray objectAtIndex:indexPath.row];
    
    playListVC.albumId = model.albumId;
    
    playListVC.title = model.title;
    
    [self.delegate pushPlayListVC:playListVC];
    
    [playListVC release];
}

-(void)getData{
    
    
    [PublicFunction getDataByAFNetWorkingWithURL:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=lvyou&condition=recent&device=iPhone&page=1&per_page=20&status=0&tag_name=%@", self.urlId] Success:^(id data) {
        
        [self.dataArray removeAllObjects];
        
        NSMutableDictionary *bigDic = [NSMutableDictionary dictionaryWithDictionary:data];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[bigDic objectForKey:@"list"]];
        
        
        for (NSMutableDictionary *dic in array) {
            MusicModel *radioList = [[MusicModel alloc] init];
            
            [radioList setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:radioList];
            [radioList release];
        }
        
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        
        [self.MONAView stopAnimating];

    } failure:^{
        [self.tableView headerEndRefreshing];
        
        [self.MONAView stopAnimating];
        
    }];


    
}
-(void)getData2{
    
    [PublicFunction getDataByAFNetWorkingWithURL:[NSString stringWithFormat:@"http://mobile.ximalaya.com/m/explore_album_list?category_name=lvyou&condition=recent&device=iPhone&page=%ld&per_page=20&status=0&tag_name=%@", (long)self.page, self.urlId] Success:^(id data) {
        
        NSMutableDictionary *bigDic = [NSMutableDictionary dictionaryWithDictionary:data];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[bigDic objectForKey:@"list"]];
        
        
        for (NSMutableDictionary *dic in array) {
            MusicModel *radioList = [[MusicModel alloc] init];
            
            [radioList setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:radioList];
            [radioList release];
        }
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing]; //停止上拉刷新
        
        self.page++;

    } failure:^{
        
        [self.tableView footerEndRefreshing]; //停止上拉刷新

    }];


}

-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    [self.MONAView release];
    self.isHUB = YES;
    [self getData];
    
}
-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}
-(void)addHeader{
    
    [self.tableView addHeaderWithCallback:^{
        
        self.tableView.headerRefreshingText = @"为您查看目前最新内容...";
        self.isHeader = YES;
        [self getData];
        
    }];
    
}


-(void)addFooter{
    
    
    [self.tableView addFooterWithCallback:^{
        
        self.tableView.footerReleaseToRefreshText = @"为您玩命加载中...";
        self.isHeader = NO;
        [self getData2];
        
    }];
    
}


-(void)creatBackgroundView{
    
    UIImageView *bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    bg_view.alpha = 0.5;
    
    bg_view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];
    
    [self.view addSubview:bg_view];
    
    [bg_view release];
}
-(void)dealloc{
    [_tableView release];
    [_MONAView release];
    [super dealloc];
}





@end
