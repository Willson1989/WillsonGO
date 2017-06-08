//
//  TypeSelectView.h
//  TypeView_Demo
//
//  Created by ZhengYi on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeSelectView : UIView

@property (strong, nonatomic) NSArray *typeArray;
@property (strong, nonatomic) NSMutableArray *selectedTypes;
@property (strong, nonatomic) NSString *title;

@end
