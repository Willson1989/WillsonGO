//
//  VideoListViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "VideoListViewController.h"

@interface VideoListViewController ()

@end

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    [self creatBackgroundView];
    
    self.dataArray = [NSMutableArray array];
    [self initMONA];
    
    [self creatFlowLayout];
    
    [self creatCollectionView];

}



-(void)creatFlowLayout{
    self.videoFlowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    self.videoFlowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 2 - 10,
                                               self.view.frame.size.width / 2 - 25);
    self.videoFlowLayout.sectionInset = UIEdgeInsetsMake(5,
                                                         5,
                                                         20,
                                                         5);
    self.videoFlowLayout.minimumInteritemSpacing = 1;
    self.videoFlowLayout.minimumLineSpacing = 5;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    CGRect tempFrame = self.videoCollectionView.frame;
    
    tempFrame.size.height = MYHEIGHT - 49 - TOP_BAR_HEIGHT - 64;
    tempFrame.origin.y = 64 + TOP_BAR_HEIGHT;
    
    self.videoCollectionView.frame = tempFrame;
}

-(void)creatCollectionView{
    
    self.videoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                  TOP_BAR_HEIGHT,
                                                                                  self.view.frame.size.width,
                                                                                  MYHEIGHT - 49 - TOP_BAR_HEIGHT - 64) collectionViewLayout:self.videoFlowLayout];
    
    self.videoCollectionView.backgroundColor = [UIColor clearColor];
    
    self.videoCollectionView.delegate = self;
    
    self.videoCollectionView.dataSource = self;
    
    [self.videoCollectionView registerClass:[VideoListCell class] forCellWithReuseIdentifier:@"cellReuse"];
    
    [self.view addSubview:self.videoCollectionView];
    
    [_videoCollectionView release];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    VideoListCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellReuse" forIndexPath:indexPath];
    
    myCell.videoList = [self.dataArray objectAtIndex:indexPath.row];
    
    //渐变效果
    myCell.layer.shadowColor = [[UIColor blackColor]CGColor];
    myCell.alpha = 0;
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:1];
    myCell.alpha = 1;
    [UIView commitAnimations];
    
    return myCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    Video *list = [[[Video alloc] init] autorelease];
    
    list = [self.dataArray objectAtIndex:indexPath.row];
    
    NSURL *urlStr = [NSURL URLWithString:list.outerGPlayerUrl];

    VideoPlayViewController *videoDetailVC = [[VideoPlayViewController alloc] init];
    
    UINavigationController *videoDetailsNC = [[UINavigationController alloc] initWithRootViewController:videoDetailVC];
    
    [self presentViewController:videoDetailsNC animated:YES completion:^{
        
         [videoDetailVC creatWebView:urlStr];
    }];
    
    [videoDetailsNC release];
    [videoDetailVC release];

//    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:urlStr];
//    self.player.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentMoviePlayerViewControllerAnimated:_player];
//    MPMoviePlayerController *player = [self.player moviePlayer];
//    [player play];

}

-(void)getData{
    
    NSString *urlStr = @"http://api.tudou.com/v6/video/search?app_key=90256538062520f9&format=json&kw=侣行&pageNo=1&pageSize=100&orderBy=createTime";
    NSString *urlEcod = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; //若请求的网址有中文,需转码
    
    [PublicFunction getDataByAFNetWorkingWithURL:urlEcod Success:^(id data) {
        NSMutableDictionary *bigDic = [NSMutableDictionary dictionaryWithDictionary:data];
        NSMutableArray *array = [bigDic objectForKey:@"results"];
        [self.dataArray removeAllObjects];
        for (NSMutableDictionary *dic in array) {
            Video *videoList = [[Video alloc] init];
            [videoList setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:videoList];
            [videoList release];
            
        }
        [self.videoCollectionView reloadData];
        [self.MONAView stopAnimating];
        
        if (self.dataArray.count != 0) {
            
            //获取缓存文件夹路径
            NSString *cachePath = [[CacheDataHandle shareDataHandle] getCachePath];
            
            //删除缓存文件
            NSString *filePath = [NSString stringWithFormat:@"%@/videoDataArray.av",cachePath];
            [[CacheDataHandle shareDataHandle] removeCacheData:filePath];

            //获取缓存文件路径
            self.filePath = [[CacheDataHandle shareDataHandle] getKey:@"videoDataArray" andObject:self.dataArray andPath:cachePath];
        }
        

    }];

}


-(void)dealloc{
    [_videoCollectionView release];
    [_videoFlowLayout release];
    [super dealloc];
}

-(void)creatBackgroundView{
    
    UIImageView *bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    bg_view.alpha = 0.5;
    
    bg_view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];
    
    [self.view addSubview:bg_view];
    
    [bg_view release];
    
}
-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    //    self.MONAView.center = [[[UIApplication sharedApplication].delegate window] center];
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    [self getData];
    
}

-(void)getCacheData{
   
    //获取缓存数据
    NSString *cachePath = [NSString stringWithFormat:@"%@/videoDataArray.av",[[CacheDataHandle shareDataHandle] getCachePath]];
    
    //创建一个文件管理器对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //判断文件是否存在
    if ([fileManager fileExistsAtPath:cachePath]) {
        self.dataArray = [[CacheDataHandle shareDataHandle] setData:cachePath];
        [self.videoCollectionView reloadData];
    }
    
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
