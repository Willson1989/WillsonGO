//
//  Spots_DetaTVCell.m
//  XinTu
//
//  Created by 菊次郎 on 15-6-28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Spots_DetaTVCell.h"

@implementation Spots_DetaTVCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
-(void)creatSubViews{
    
    NSLog(@"初始化-------");
    self.bigPicUrl = [[UIImageView alloc] initWithFrame:CGRectMake(5,
                                                                   5,
                                                                  MYWIDTH-10,
                                                                   200)];
    [self.bigPicUrl.layer setMasksToBounds:YES];
    [self.bigPicUrl.layer setCornerRadius:4.5];
    [self addSubview:self.bigPicUrl];
    
    
    self.nameOne = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                             5,
                                                             MYWIDTH-20, 20)];
    
    
    self.nameOne.textColor  = [UIColor whiteColor];
    //调字体大小(黑体)
    self.nameOne.font = [UIFont boldSystemFontOfSize:21];
 

    [self.bigPicUrl addSubview:self.nameOne];
    
    self.nameTwo = [[UILabel alloc] init];
    self.nameTwo.textColor  = [UIColor grayColor];
    self.nameTwo.lineBreakMode=NSLineBreakByClipping;
    //设置无限行
    self.nameTwo.numberOfLines=0;

    //调字体大小(黑体)
    self.nameTwo.font = [UIFont boldSystemFontOfSize:15];

    [self addSubview:self.nameTwo];
}
-(void)setMyRoute:(Route *)myRoute
{
    if(_myRoute != myRoute){
        [_myRoute release];
        _myRoute = [myRoute retain];
    }
    
    NSString *urStr =myRoute.spotsPic;
    NSURL *url =[NSURL URLWithString:urStr];
    [self.bigPicUrl sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    self.nameOne.text = myRoute.spotsName;
    self.nameTwo.text = myRoute.spotText;
    //自定义高度
    CGFloat height = [PublicFunction heightForSubView:self.nameTwo.text andWidth:[UIScreen mainScreen].bounds.size.width-35
                                        andFontOfSize:15];
    self.nameTwo.frame =CGRectMake(5,
                                    210,
                                    [UIScreen mainScreen].bounds.size.width-35, height*HEIGHTR);

    
}
-(void)dealloc{
    [_bigPicUrl release];
    
    [super dealloc];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
