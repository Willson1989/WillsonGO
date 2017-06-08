//
//  PlayListViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PlayListViewController.h"

@implementation PlayListViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, 20, 20, 20);
    
    
    [self.backButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIImage * image = [UIImage imageNamed:@"auth_back_button_image.png"];
    image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.backButton setBackgroundImage:image forState:UIControlStateNormal];
    self.backButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft; //button居左
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:self.backButton] autorelease];
    
    self.page = 1;
    
    self.dataArray = [NSMutableArray array];
    
    [self addFooter];
    
    [self creatTableView];
    
    [self initMONA];
    
}

-(void)leftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)creatTableView{
    
    self.musicListTable = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        self.view.frame.size.width,
                                                                        MYHEIGHT - 69) style:UITableViewStyleGrouped];
    self.musicListTable.backgroundColor = [UIColor lightGrayColor];
    self.musicListTable.delegate = self;
    self.musicListTable.dataSource = self;
    [self.view addSubview:self.musicListTable];
    
    [self.musicListTable release];
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
    
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"resueCell";
    
    PlayListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[PlayListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (self.dataArray.count != 0) {
        cell.playList = [self.dataArray objectAtIndex:indexPath.row];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MusicModel *music = [[[MusicModel alloc] init] autorelease];
    
    music = [self.dataArray objectAtIndex:indexPath.row];
    
    [PlayMusicViewController shareDataHandle].name = music.title;
    
    [PlayMusicViewController shareDataHandle].coverLarge = music.coverLarge;
    
    [PlayMusicViewController shareDataHandle].playUrl64 = music.playUrl64;
    
    [PlayMusicViewController shareDataHandle].index = indexPath.section;
    
    [PlayMusicViewController shareDataHandle].urlArray = [NSMutableArray array];
    
    [PlayMusicViewController shareDataHandle].nameArray = [NSMutableArray array];
    
    [PlayMusicViewController shareDataHandle].imageArray = [NSMutableArray array];
    
    for (MusicModel *model in self.dataArray) {
        
        [[PlayMusicViewController shareDataHandle].urlArray addObject:model.playUrl64];
        
        [[PlayMusicViewController shareDataHandle].nameArray addObject:model.title];
        
        [[PlayMusicViewController shareDataHandle].imageArray addObject:model.coverLarge];
        
    }
    
    UINavigationController *playMusicNC = [[UINavigationController alloc] initWithRootViewController:[PlayMusicViewController shareDataHandle]];
    
    [self presentViewController:playMusicNC animated:YES completion:^{
        
    }];
    [playMusicNC release];
}

-(void)getData{
    
    [PublicFunction getDataByAFNetWorkingWithURL:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/%ld/30?device=iPhone", self.albumId, (long)self.page] Success:^(id data) {
        
        NSMutableDictionary *bigDic = [NSMutableDictionary dictionaryWithDictionary:data];
        
        NSMutableDictionary *contentDic = [NSMutableDictionary dictionaryWithDictionary:[bigDic objectForKey:@"tracks"]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[contentDic objectForKey:@"list"]];
        
        for (NSMutableDictionary *dic in array) {
            MusicModel *playList = [[MusicModel alloc] init];
            
            [playList setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:playList];
            [playList release];
        }
        
        [self.musicListTable reloadData];
        [self.musicListTable footerEndRefreshing]; //停止上拉刷新
        
        self.page++;
        
    } failure:^{
        
        [self.musicListTable footerEndRefreshing]; //停止上拉刷新
        
        
    }];
}

-(void)getData2{
    
    [PublicFunction getDataByAFNetWorkingWithURL:[NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/track/%@/true/1/30?device=iPhone", self.albumId] Success:^(id data) {
        
        NSMutableDictionary *bigDic = [NSMutableDictionary dictionaryWithDictionary:data];
        
        NSMutableDictionary *contentDic = [NSMutableDictionary dictionaryWithDictionary:[bigDic objectForKey:@"tracks"]];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[contentDic objectForKey:@"list"]];
        
        for (NSMutableDictionary *dic in array) {
            MusicModel *playList = [[MusicModel alloc] init];
            
            [playList setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:playList];
            [playList release];
        }
        
        [self.musicListTable reloadData];
        [self.MONAView stopAnimating];
        
        
    } failure:^{
        
        [self.MONAView stopAnimating];
        
    }];
}
-(void)initMONA{
    self.MONAView = [[[MONActivityIndicatorView alloc] init] autorelease];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    self.MONAView.center = self.musicListTable.center;
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    [self.MONAView release];
    [self getData2];
    
}
-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
}


-(void)addFooter{
    
    [self.musicListTable addFooterWithCallback:^{
        
        [self getData];
    }];
}
-(void)dealloc{
    
    [self.musicListTable release];
    [self.MONAView release];
    [super dealloc];
}

@end
