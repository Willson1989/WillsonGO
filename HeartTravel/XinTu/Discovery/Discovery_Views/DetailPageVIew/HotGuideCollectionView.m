//
//  HotGuideCollectionView.m
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotGuideCollectionView.h"

@implementation HotGuideCollectionView

+(instancetype)hotGuideCollectionViewWithGuideCount:(NSInteger)count{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = layout.sectionInset = UIEdgeInsetsMake(10.0f, COLL_CELL_LINE_SPACE/2, COLL_CELL_LINE_SPACE, COLL_CELL_LINE_SPACE/2);
    layout.itemSize = CGSizeMake(([[UIScreen mainScreen]bounds].size.width - COLL_CELL_LINE_SPACE * 2) / 2,100.0f * 1.5);
    layout.minimumInteritemSpacing = COLL_CELL_LINE_SPACE;
    layout.minimumLineSpacing = COLL_CELL_LINE_SPACE;
    CGFloat coll_height = ceil(count/2.0f) * (layout.itemSize.height + layout.minimumLineSpacing) + COLL_CELL_LINE_SPACE;
    HotGuideCollectionView * HGCollView = [[HotGuideCollectionView alloc] initWithFrame:
                                           CGRectMake(0,DETAIL_CELL_TOP_HEIGHT,[[UIScreen mainScreen]bounds].size.width,coll_height) collectionViewLayout:layout];
    HGCollView.backgroundColor = [UIColor whiteColor];
    [HGCollView registerClass:[HotGuideCell class] forCellWithReuseIdentifier:HOT_GUIDE_CELLID];
    return [HGCollView autorelease];
}

@end
