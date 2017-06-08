//
//  UILabel+VerticalUpAlignment.m
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UILabel+VerticalUpAlignment.h"

@implementation UILabel (VerticalUpAlignment)

//使UIlabel的文字顶部对齐,实则是根据文字的多少来改变UILabel的高度
- (void)verticalUpAlignmentWithText:(NSString *)text maxHeight:(CGFloat)maxHeight
{
    self.numberOfLines = 0;
    CGRect frame = self.frame;
    CGSize size = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(frame.size.width, maxHeight)];
    frame.size = CGSizeMake(frame.size.width, size.height);
    self.frame = frame;
    self.text = text;
}


@end
