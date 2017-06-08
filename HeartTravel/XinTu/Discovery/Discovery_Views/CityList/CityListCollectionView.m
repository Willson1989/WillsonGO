//
//  CityListCollectionView.m
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CityListCollectionView.h"

@implementation CityListCollectionView

+(instancetype) CListCollectionView{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(CITY_LIST_CELL_WIDTH , CITY_LIST_CELL_HEIGHT);
    layout.minimumInteritemSpacing = 10.0f;
    layout.minimumLineSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 15.0, 10.0f, 15.0f);
    CityListCollectionView * clCollView = [[CityListCollectionView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    [clCollView registerClass:[CityListCell class] forCellWithReuseIdentifier:CITY_LIST_CELLID];
    
    clCollView.backgroundColor = [PublicFunction getColorWithRed:230.0f Green:235.0f Blue:239.0f];
    [layout release];
    
    return [clCollView autorelease];
     
}

@end
