//
//  HotTravelCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotTravelCell.h"

@implementation HotTravelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self creatSubView];
        
    }

    return self;
}
-(void)creatSubView
{
    //定义cell封面图片
    self.cover = [[UIImageView alloc] initWithFrame:CGRectMake(10,
                                                               10,
                                                           MYWIDTH-20, 214)];
    //self.cover.backgroundColor = [UIColor orangeColor];
   //给封面图片加圆角
    CALayer *lay = self.cover.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:4.50];
    [self addSubview:self.cover];
    [_cover release];
    
    UIView *layView= [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                             MYWIDTH-20, 214)];
    layView.backgroundColor = [UIColor blackColor];
    layView.alpha=0.15;
    [self.cover addSubview:layView];
      
    
    //定义cell标题
  
    self.title=[[UILabel alloc] init];
    
    self.title.textColor  = [UIColor whiteColor];
    //调字体大小(黑体)
    self.title.font = [UIFont boldSystemFontOfSize:21];
    //换行
    self.title.lineBreakMode=NSLineBreakByClipping;
    //设置无限行
    self.title.numberOfLines=0;
    [self addSubview:self.title];
    [_title release];
    //定义cell日期
    self.date = [[UILabel alloc] init];
    //self.date.text =@"2015.05.16";
    self.date.textColor=[UIColor whiteColor];
    self.date.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:self.date];
    [_date release];
    //定义cell旅行时长
    self.days = [[UILabel alloc] init];
    //self.days.text=@"7天";
    self.days.textColor=[UIColor whiteColor];
    self.days.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:self.days];
    [_days release];
    
    //定义浏览次数
    self.browse = [[UILabel alloc]init];
    self.browse.textColor=[UIColor whiteColor];
    //self.browse.text = @"279 次浏览";
    self.browse.font = [UIFont boldSystemFontOfSize:13];
    [self addSubview:self.browse];
    [_browse release];
    //定义地点
    self.place = [[UILabel alloc]init];
    self.place.textColor = [UIColor whiteColor];
    //self.place.text = @"希腊.米克诺斯";
    self.place.font = [UIFont boldSystemFontOfSize:10];
    [self addSubview:self.place];
    [_place release];
    //设置cell 小图标icon
    self.icon = [[UIImageView alloc] init];
    //给封面图片加圆角
    CALayer *iconlay = self.icon.layer;
    [iconlay setMasksToBounds:YES];
    [iconlay setCornerRadius:4.10];

    self.icon.backgroundColor = [UIColor  orangeColor];
    [self addSubview:self.icon];
    [_icon release];
    
    //设置用户头像
    self.Userpic = [[UIImageView alloc] initWithFrame:CGRectMake(28,
                                                                 183,
                                                                 25, 25)];
    self.Userpic.backgroundColor = [UIColor yellowColor];
    //让图片变成圆形** radius 为 高的一半
    CALayer *Userlay = self.Userpic.layer;
    [Userlay setMasksToBounds:YES];
    [Userlay setCornerRadius:12.5];

    [self addSubview:self.Userpic];
    //by
    self.UserBy = [[UILabel alloc] initWithFrame:CGRectMake(60,
                                                            188,
                                                            15, 15)];
    self.UserBy.text = @"by";
    //设置字体为斜体
    self.UserBy.font = [UIFont italicSystemFontOfSize:12 ];
    self.UserBy.textColor= [UIColor whiteColor];
    [self addSubview:self.UserBy];
    [_UserBy release];
    //设置cell用户名
    self.UserName = [[UILabel alloc] initWithFrame:CGRectMake(80,
                                                              188,
                                                              150, 20)];
    self.UserName.textColor = [UIColor whiteColor];
    self.UserName.text = @"ailsalily";
    self.UserName.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.UserName];
    [_UserName release];
    
    
    
    
    
    
    
}

-(void)setMyHotTravel:(HotTravel *)myHotTravel
{
    if (_myHotTravel != myHotTravel) {
        [_myHotTravel release];
        _myHotTravel = [myHotTravel retain];
    }
    
    _title.text =self.myHotTravel.title;
    _date.text  =self.myHotTravel.date ;
    _days.text  =[self.myHotTravel.days stringByAppendingString:@"天"];
    _browse.text=[self.myHotTravel.browse stringByAppendingString:@" 次浏览"];
    _place.text =self.myHotTravel.place;
    _UserName.text=self.myHotTravel.UserName;
    
    //图片
    NSString *urStr = myHotTravel.cover;
    NSURL *url =[NSURL URLWithString:urStr];
    [self.cover sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    NSString *usrStr2=myHotTravel.Userpic;
    NSURL *url2= [NSURL URLWithString:usrStr2];
    [self.Userpic sd_setImageWithURL:url2 ];
//    [self.moviepic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHoderImage.png"]];

    //自定义高度
    CGFloat height = [PublicFunction heightForSubView:self.title.text andWidth:260 andFontOfSize:21];
    self.title.frame=CGRectMake(23,
                                15,
                                260, height+10);

    self.date.frame=CGRectMake(36,
                                height+10+13,
                                80, 20);
    self.days.frame=CGRectMake(112,
                                height+10+13,
                                30, 20);
    self.browse.frame=CGRectMake(145,
                                  height+23,
                                100, 20);
    self.place.frame=CGRectMake(38
                                , height+10+33,
                                160, 10);
    self.icon.frame=CGRectMake(23,
                                height+10+16,
                                5, 28);

    
    

    
    
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
