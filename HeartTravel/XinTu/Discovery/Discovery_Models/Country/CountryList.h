//
//  CountryList.h
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CountryList : NSObject<NSCoding>

@property (retain,nonatomic) UIImage * cImage;
@property (retain,nonatomic) NSMutableArray * hot_country;
@property (retain,nonatomic) NSMutableArray * other_country;

@end
