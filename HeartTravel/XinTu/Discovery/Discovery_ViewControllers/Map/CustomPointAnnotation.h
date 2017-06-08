//
//  CustomPointAnnotation.h
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "BaseMapList.h"

@interface CustomPointAnnotation : MAPointAnnotation<MAAnnotation>


@property (retain,nonatomic) BaseMapList * baseList;

@end
