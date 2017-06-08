//
//  RouteListCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RouteListCell.h"

@implementation RouteListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self creatSubView];
        
    }
    
    return self;
}
-(void)creatSubView
{
  self.PlacePic=[[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              MYWIDTH, 40)];
 self.PlacePic.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.PlacePic];
 
    
  self.PlaceText=[[UILabel alloc] initWithFrame:CGRectMake(25,
                                                               0,
                                                               MYWIDTH, 35)];
    [self addSubview:self.PlaceText];
    
    
    self.spotText=[[UILabel alloc] initWithFrame:CGRectMake(25,
                                                             0,
                                                             MYWIDTH, 35)];
    [self addSubview:self.spotText];
 
    
    
}

-(void)setCellRoute:(Route *)cellRoute
{
  
         self.PlaceText.text=cellRoute.PlaceText;
    if ([cellRoute.PlaceType isEqualToString:@"3"]||[cellRoute.PlaceType isEqualToString:@"2"]||[cellRoute.PlaceType isEqualToString:@"1"]) {
        
        self.PlacePic.image = [UIImage imageNamed:@"blue_button@2x"];
    }else
    {
    
        self.PlacePic.image = [UIImage imageNamed:@"navViewBKG"];
    }
    
}

@end
