//
//  FeatureDollectViewCell.m
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FeatureDollectViewCell.h"

@implementation FeatureDollectViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   self.frame.size.width,
                                                                   self.frame.size.height)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self addSubview:self.titleLabel];
    [_titleLabel release];
}

-(void)setList:(FeatureDollectModel *)list{
    
    if (_list != list) {
        
        [_list release];
       _list = [list retain];
    }
    self.titleLabel.text = [NSString stringWithFormat:@"      %@", list.hotGuideTitle];
   
    
}

@end
