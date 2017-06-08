//
//  UIImage+Scale.h
//  qieqie
//
//  Created by Paul on 14-4-16.
//  Copyright (c) 2014年 paulzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

+ (UIImage *)imageCalled:(NSString *)imageName;

//从缓存中获取图片
+ (UIImage *)imageLoadFromCache:(NSString *)strUrl;

//保持横竖比例，以小边为准，小于或等于输入尺寸
- (UIImage *)scaledCopyOfSizeMin:(CGSize)newSize;

//保持横竖比例，以大边为准，大于或等于输入尺寸
- (UIImage*)scaledCopyOfSizeMax:(CGSize)newSize;

- (UIImage*)toGetMaximumPicture:(CGSize)newSize;
@end
