//
//  TypeSelectView.m
//  TypeView_Demo
//
//  Created by ZhengYi on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TypeSelectView.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

//设置颜色
#define COLOR_RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define COLOR_HEX(h,a) COLOR_RGB(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)
//清除背景色
#define CLEARCOLOR [UIColor clearColor]

//系统字体
#define SYSTEM_FONT(a) [UIFont systemFontOfSize:(a)]

//苹方常规字体
#define FONT_REGULAR(a)  [UIFont fontWithName:@"PingFangSC-Regular" size:(a)]

//苹方中等字体
#define FONT_MEDIUM(a) [UIFont boldSystemFontOfSize:(a)]

//苹方粗体字体
#define FONT_BOLD(a)  [UIFont fontWithName:@"PingFangSC-Semibold" size:(a)]

@interface TypeSelectView ()

@property (strong, nonatomic) NSMutableArray *btnArray;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TypeSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.typeArray = [NSArray array];
        self.selectedTypes = [NSMutableArray array];
        self.btnArray = [NSMutableArray array];
        self.layer.cornerRadius = 8.0;
    }
    return self;
}

- (void)setTypeArray:(NSArray *)typeArray{
    _typeArray = typeArray;
    [_selectedTypes removeAllObjects];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsLayout];
}

- (void)removeButtons{
    if (self.btnArray.count) {
        for (UIButton *button in self.btnArray) {
            [button removeFromSuperview];
        }
        [self.btnArray removeAllObjects];
    }
}

- (void)layoutSubviews{
    
    [self removeButtons];
    
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 18, self.frame.size.width - 30, 40)];
        _titleLabel.backgroundColor = CLEARCOLOR;
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = COLOR_HEX(0x333333, 1.0);
        [self addSubview:_titleLabel];
    }
    _titleLabel.text = _title;
    
    CGFloat btnY = (35  + 45) / 2 + 40;
    CGFloat btnX;
    
    CGFloat sumX = 10;
    
    CGFloat maxWidth = self.frame.size.width;
    
    CGFloat countInRow = 1;
    
    CGFloat item_space = 10.0;
    
    CGFloat maxCountInRow = 4;
    
    CGFloat normalButtonWidth = (self.frame.size.width - item_space * (maxCountInRow + 1)) / maxCountInRow;
    
    for (NSInteger index = 0; index < self.typeArray.count; index++) {
        
        NSString * typeString = [self.typeArray objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:typeString forState:UIControlStateNormal];
        [btn setTitle:typeString forState:UIControlStateHighlighted];
        [btn setTitle:typeString forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
        
        CGFloat width = (btn.titleLabel.intrinsicContentSize.width + 10) < normalButtonWidth
                         ? normalButtonWidth
                         : (btn.titleLabel.intrinsicContentSize.width + 10);
        
        BOOL hasAddRow = NO;
        btnX = sumX;
        sumX = sumX + width + item_space;
        if (sumX > maxWidth || countInRow > 4) {
            btnY = btnY + 30 + 15;
            btnX = 10;
            sumX = 10;
            countInRow = 1;
            hasAddRow = YES;
        } else
            countInRow ++;

        btn.frame = CGRectMake(btnX, btnY, width, 30);
        if (hasAddRow) {
            sumX = sumX + width + item_space;
        }
        [self configNormalStyle:btn];
        [self addSubview:btn];
    }
    
}

- (void)configNormalStyle:(UIButton *)btn{
    btn.layer.cornerRadius = 8.0;
    btn.layer.borderColor = [COLOR_HEX(0xaaaaaa, 1.0) CGColor];
    btn.layer.cornerRadius = 8.0;
    btn.layer.borderColor = [COLOR_HEX(0xaaaaaa, 1.0) CGColor];
    btn.layer.borderWidth = 1;
    btn.titleLabel.font = FONT_MEDIUM(15.0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.clipsToBounds = YES;
    [btn setBackgroundColor:self.backgroundColor];
    [btn setTitleColor:COLOR_HEX(0xaaaaaa, 1.0) forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_HEX(0xaaaaaa, 1.0) forState:UIControlStateHighlighted];
}

- (void)configSelectedStyle:(UIButton *)btn{
    btn.layer.cornerRadius = 8.0;
    btn.layer.borderColor = [COLOR_HEX(0xff4444, 1.0) CGColor];
    btn.layer.borderWidth = 1;
    btn.titleLabel.font = FONT_MEDIUM(15.0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.clipsToBounds = YES;
    [btn setBackgroundColor:COLOR_HEX(0xff4444, 1.0)];
    [btn setTitleColor:self.backgroundColor forState:UIControlStateSelected];
}

- (void)buttonAction:(UIButton *)button{
    
//    NSLog(@"button action , index : %li",[self.btnArray indexOfObject:button]);
    
    if (button.selected) {
        button.selected = NO;
        [self configNormalStyle:button];
        if ([self.selectedTypes containsObject:button.titleLabel.text]) {
            [self.selectedTypes removeObject:button.titleLabel.text];
        }
    } else{
        button.selected = YES;
        [self configSelectedStyle:button];
        [self.selectedTypes addObject:button.titleLabel.text];
    }
    NSLog(@"selectedArray : %@",self.selectedTypes);
}


@end
