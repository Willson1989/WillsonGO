//
//  MusicViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MusicViewController.h"

@implementation MusicViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    
    self.titleArray = [NSMutableArray array];
    
    self.urlArray = [NSMutableArray arrayWithObjects:radio_url0, radio_url1, radio_url2, radio_url3, radio_url4, radio_url5, nil];
    
    [self creatBackgroundView];
    
    [self creatCollectionView];
    
    [self initMONA];
}


-(void)creatCollectionView{
    
    self.musicFlowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    
    self.musicFlowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 2 - 10,
                                               self.view.frame.size.width / 2 - 25);
    self.musicFlowLayout.sectionInset = UIEdgeInsetsMake(5,
                                                         5,
                                                         20,
                                                         5);
    self.musicFlowLayout.minimumInteritemSpacing = 1;
    self.musicFlowLayout.minimumLineSpacing = 5;
    
    self.musicCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                  TOP_BAR_HEIGHT,
                                                                                  self.view.frame.size.width,
                                                                                  self.view.frame.size.height) collectionViewLayout:self.musicFlowLayout];

    self.musicCollectionView.backgroundColor = [UIColor clearColor];
    
    self.musicCollectionView.delegate = self;
    
    self.musicCollectionView.dataSource = self;
    
    [self.musicCollectionView registerClass:[FirstListCell class] forCellWithReuseIdentifier:@"cellReuse"];
    
    [self.view addSubview:self.musicCollectionView];
    
    [_musicCollectionView release];
    [_musicFlowLayout release];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.dataArray.count != 0) {
        
        return self.dataArray.count;
    }else
        return 0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FirstListCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellReuse" forIndexPath:indexPath];
    
    myCell.musicList = [self.dataArray objectAtIndex:indexPath.row];
    
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
    
    RadioListRootViewController *radioVC = [[RadioListRootViewController alloc] init];
    
    
    radioVC.urlId = [self.urlArray objectAtIndex:indexPath.row];
    
    if (self.titleArray.count != 0) {
        
        radioVC.name = [self.titleArray objectAtIndex:indexPath.row];
        
    }
    
    [self.delegate pushSubVCmethod:radioVC];
    
    [radioVC release];
}



-(void)creatBackgroundView{
    
    UIImageView *bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
   
    bg_view.alpha = 0.5;
    
    bg_view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];

    
    [self.view addSubview:bg_view];
    
    [bg_view release];
    
}
-(void)getData{
    
    [PublicFunction getDataByAFNetWorkingWithURL:@"http://mobile.ximalaya.com/m/category_tag_list?category=lvyou&device=iPhone&type=album" Success:^(id data) {
        
        NSMutableDictionary *bigDic = [NSMutableDictionary dictionaryWithDictionary:data];
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:[bigDic objectForKey:@"list"]];
        [self.dataArray removeAllObjects];
        for (NSMutableDictionary *dic in array) {
            MusicModel *musicList = [[MusicModel alloc] init];
            [musicList setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:musicList];
            [self.titleArray addObject:musicList.tname];
            [musicList release];
        }
         
        [self.musicCollectionView reloadData];
        [self.MONAView stopAnimating];
        
        if (self.dataArray.count != 0) {
            //获取缓存文件夹路径
            NSString *cachePath = [[CacheDataHandle shareDataHandle] getCachePath];
            //删除缓存文件
            NSString *filePath = [NSString stringWithFormat:@"%@/musicDataArray.av",[[CacheDataHandle shareDataHandle] getCachePath]];
            [[CacheDataHandle shareDataHandle] removeCacheData:filePath];
            //获取缓存文件路径并创建缓存文件
            self.filePath = [[CacheDataHandle shareDataHandle] getKey:@"musicDataArray" andObject:self.dataArray andPath:cachePath];
        }
    }];
}
-(void)getCacheData{
    //获取缓存数据
    NSString *cachePath = [NSString stringWithFormat:@"%@/musicDataArray.av",[[CacheDataHandle shareDataHandle] getCachePath]];
    //创建一个文件管理器对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
    if ([fileManager fileExistsAtPath:cachePath]) {
    
        self.dataArray = [[CacheDataHandle shareDataHandle] setData:cachePath];
        [self.musicCollectionView reloadData];
    }

}
-(void)initMONA{
    NSLog(@"开始动画");
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [self.MONAView startAnimating];
    [self.view addSubview:self.MONAView];
    [_MONAView release];
    [self getData];
    
}
-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)dealloc{
    [_musicFlowLayout release];
    [_musicCollectionView release];
    [_MONAView release];
    [super dealloc];
    
}


@end
