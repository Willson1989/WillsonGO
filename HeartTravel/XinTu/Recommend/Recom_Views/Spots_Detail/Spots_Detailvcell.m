//
//  Spots_Detailvcell.m
//  XinTu
//
//  Created by 菊次郎 on 15-6-25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Spots_Detailvcell.h"

@implementation Spots_Detailvcell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
-(void)creatSubViews{
    
    self.bigPicUrl = [[UIImageView alloc] initWithFrame:CGRectMake(5,
                                                                   5,
                                                                   self.frame.size.width - 10,
                                                                   self.frame.size.height - 50)];
    [self.bigPicUrl.layer setMasksToBounds:YES];
    [self.bigPicUrl.layer setCornerRadius:4.5];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                           20,
                                                           20,
                                                           20)];
    self.title.font = [UIFont systemFontOfSize:13];
    self.title.numberOfLines = 0;
    self.title.lineBreakMode = NSLineBreakByCharWrapping;
    self.title.textColor = [UIColor blackColor];
    
    
    
    
   
    [self.bigPicUrl addSubview:self.title];
    
    [self addSubview:self.bigPicUrl];
    
    [_bigPicUrl release];
    [_title release];
  
    
}
-(void)setMyRoute:(Route *)myRoute
{
 
   
    NSString *urStr =myRoute.spotsPic;
    
    NSURL *url =[NSURL URLWithString:urStr];
    [self.bigPicUrl sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];

    self.title.text =myRoute.spotText;



}
-(void)dealloc{
    [_bigPicUrl release];
    [_title release];
       [_bgView release];
    [super dealloc];
    
}

@end
