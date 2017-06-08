//
//  GuideListTitleCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GuideListTitleCell.h"

#define GUIDE_DETAIL_AVA_WIDTH  35.0f

//标题cell中除了标题描述的其他内容的高度和
#define TITLE_OTHER_TOTAL_HEIGHT 111.0f
#define SIDE_INSET  10.0f * WIDTHR
#define TITLE_DESC_FONTSIZE 16

@implementation GuideListTitleCell

-(void)dealloc{

    [self.avatarImage release];
    [self.uNameLabel release];
    [self.titleLabel release];
    [self.titleDesc release];
    [super dealloc];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)setHotGuide:(HotGuide *)hotGuide{
    if (_hotGuide != hotGuide) {
        [_hotGuide release];
        _hotGuide = [hotGuide retain];
    }
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:hotGuide.avatar]];
//    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:hotGuide.avatar] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    self.uNameLabel.text = hotGuide.username;
    self.titleLabel.text = hotGuide.title;
    self.titleDesc.text = hotGuide.guideDesc;
    CGRect tempFrame = self.titleDesc.frame;
    tempFrame.size.height = [PublicFunction heightForSubView:self.titleDesc.text
                                            andWidth:[[UIScreen mainScreen] bounds].size.width - SIDE_INSET*2
                                            andFontOfSize:TITLE_DESC_FONTSIZE];
    self.titleDesc.frame = tempFrame;
}

-(void)createSubViews{
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake(( screenWidth - GUIDE_AVATAR_WITH)/2,
                                                                      0,
                                                                      GUIDE_AVATAR_WITH,
                                                                      GUIDE_AVATAR_WITH)];
    CALayer * layer = self.avatarImage.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:GUIDE_AVATAR_WITH / 2];
    self.uNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                               self.avatarImage.frame.origin.y + self.avatarImage.frame.size.height + 3,
                                                               screenWidth,
                                                               19)];
    self.uNameLabel.textAlignment = NSTextAlignmentCenter;
    self.uNameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 7];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                               self.uNameLabel.frame.origin.y + self.uNameLabel.frame.size.height + 10,
                                                               screenWidth,
                                                               30)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:COMMON_FONT_SIZE -2];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleDesc = [[UILabel alloc]initWithFrame:CGRectMake(SIDE_INSET,
                                                              self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height,
                                                              screenWidth - SIDE_INSET*2,
                                                              100)];
    self.titleDesc.font = [UIFont systemFontOfSize:TITLE_DESC_FONTSIZE];
    self.titleDesc.textAlignment = NSTextAlignmentLeft;
    self.titleDesc.textColor = [PublicFunction getColorWithRed:184.0f Green:184.0f Blue:184.0f];
    self.titleDesc.numberOfLines = 0;
    self.avatarImage.center = CGPointMake(screenWidth/2, GUIDE_DETAIL_AVA_WIDTH/2);
//    self.uNameLabel.center  = CGPointMake(screenWidth/2, self.uNameLabel.frame.origin.y);
//    self.titleLabel.center  = CGPointMake(screenWidth/2, self.titleLabel.frame.origin.y);

    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.uNameLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.titleDesc];
    
    [self.avatarImage release];
    [self.uNameLabel release];
    [self.titleDesc release];
    [self.titleDesc release];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
