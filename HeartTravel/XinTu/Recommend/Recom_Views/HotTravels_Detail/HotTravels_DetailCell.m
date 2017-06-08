//
//  HotTravels_DetailCell.m
//  XinTu
//
//  Created by 菊次郎 on 15-6-22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotTravels_DetailCell.h"

@implementation HotTravels_DetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self DetaCreatSubView];
        
    }
    
    return self;
}
-(void)DetaCreatSubView
{
    self.contentView.backgroundColor =[UIColor whiteColor];
   //主图片
    self.photo = [[UIImageView alloc] init];
    self.photo.backgroundColor= [UIColor orangeColor];
    [self addSubview:self.photo];
   //主要内容
    self.Text = [[UILabel alloc] init];
    
    self.Text.font= [UIFont boldSystemFontOfSize:15];
    //self.Text.backgroundColor=[UIColor redColor];
    //换行
    self.Text.lineBreakMode=NSLineBreakByClipping;
    //设置无限行
    self.Text.numberOfLines=0;
    [self addSubview:self.Text];
    
    //时间
    self.local_time = [[UILabel alloc] init];
   self.local_time.text = @"2015-06-05 12:12:49";
    self.local_time.textColor=[UIColor grayColor];
    self.local_time.font=[UIFont italicSystemFontOfSize:13];
    [self addSubview:self.local_time];
    
    //地点
    self.province  = [[UILabel alloc] init];
    self.province.font=[UIFont boldSystemFontOfSize:13];
    self.province.textColor=[UIColor grayColor];
    //让文字靠右
    self.province.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.province];
    //地点底图
//    self.ioc = [[UIImageView alloc] init];
//    self.ioc.backgroundColor =[UIColor grayColor];
//    CALayer *lay = self.ioc.layer;
//    [lay setMasksToBounds:YES];
//    [lay setCornerRadius:4.50];
//    [self addSubview:self.ioc];
    
}

-(void)setMyHotTravel:(HotTravel *)myHotTravel
{
    if (_myHotTravel != myHotTravel) {
        [_myHotTravel release];
        _myHotTravel = [myHotTravel retain];
    }
    
    _Text.text =[@"           "  stringByAppendingString:myHotTravel.NextText];
    
  
    
    _local_time.text=[myHotTravel.NextTime substringToIndex:16];
   
    _province.text  =myHotTravel.NextPlace;
   
    //图片
    NSString *urStr =myHotTravel.Nextcover;
    
    NSURL *url =[NSURL URLWithString:urStr];
    [self.photo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    CGFloat height = [PublicFunction heightForSubView:self.Text.text andWidth:335 andFontOfSize:15];
    if (myHotTravel.Hight!=0) {
        
    
    self.photo.frame=CGRectMake(10,
                                40,
                                MYWIDTH-20, (myHotTravel.Hight*355)/myHotTravel.Width);
   
    self.Text.frame=CGRectMake(20,
                               (myHotTravel.Hight*355)/myHotTravel.Width+58,
                               MYWIDTH-40,height);
    self.local_time.frame=CGRectMake(20,
                                    (myHotTravel.Hight*355)/myHotTravel.Width+67+height,
                                    200, 20);
    self.province.frame =CGRectMake(265,
                                    (myHotTravel.Hight*355)/myHotTravel.Width+67+height,
                                    90, 20);
    }
    else
    {
        self.Text.frame=CGRectMake(20,
                                    0,
                                   335,height);
        self.local_time.frame=CGRectMake(20,
                                         height+15,
                                         200, 20);
        self.province.frame =CGRectMake(265,
                                       height+15,
                                        90, 20);
        self.photo.frame=CGRectZero;

    
    
    
    
    
    
    
    
    }
    
    
    
    
    
//    self.ioc.frame = CGRectMake(230,
//                                (myHotTravel.Hight*355)/myHotTravel.Width+62+height,
//                                365, 20);

}
//适应view
//-(UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
//    UIGraphicsBeginImageContext(size);
//    
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return scaledImage;
//}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
