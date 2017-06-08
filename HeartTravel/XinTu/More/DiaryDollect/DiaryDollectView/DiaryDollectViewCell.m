//
//  DiaryDollectViewCell.m
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DiaryDollectViewCell.h"

@implementation DiaryDollectViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * WIDTHR,
                                                                0,
                                                                self.frame.size.width - 5 * WIDTHR * 2,
                                                                self.frame.size.height)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self addSubview:self.titleLabel];
    [_titleLabel release];
}

-(void)setList:(DiaryDellectModel *)list{
    
    if (_list != list) {
        
        [_list release];
        _list = [list retain];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"      %@", list.imageTitle];
    
    
}



@end
