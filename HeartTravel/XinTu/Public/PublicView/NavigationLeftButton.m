//
//  NavigationLeftButton.m
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NavigationLeftButton.h"

@implementation NavigationLeftButton

-(instancetype)init{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    self.frame = CGRectMake(0, 0, 64, 44);
    if (self) {
//        [self setValue:UIButtonTypeCustom forKey:@"self.buttonType"];
//        [self setTitle:@"back" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:BACK_IMAGE] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        /*可以追加新内容*/
    }
    return self;
}

@end
