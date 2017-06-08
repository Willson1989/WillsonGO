//
//  HotGuideListCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotGuideListCell.h"

@implementation HotGuideListCell

-(void)dealloc{
    
    [self.gImageView release];
    [self.avatarBKView release];
    [self.uNameLabel release];
    [self.gTitleLabel release];
    [self.avatarImageView release];
    [self.guideList release];
    [super dealloc];
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setGuideList:(HotGuideList *)guideList{
    if (_guideList != guideList) {
        [_guideList release];
        _guideList = [guideList retain];
    }
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:guideList.avatar] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    [self.gImageView sd_setImageWithURL:[NSURL URLWithString:guideList.photo] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    self.uNameLabel.text = guideList.username;
    self.gTitleLabel.text = guideList.title;
}

-(void)createSubViews{
    self.gImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MYWIDTH, GUIDE_LIST_CELL_HEIGHT *3/4)];
    self.avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, self.gImageView.frame.size.height - GUIDE_AVATAR_WITH/2,
                                                                        GUIDE_AVATAR_WITH, GUIDE_AVATAR_WITH)];
    self.avatarBKView = [[UIView alloc]init];
    CGRect newFrame = self.avatarBKView.frame;
    newFrame.size.height = GUIDE_AVATAR_WITH + 1.5;
    newFrame.size.width  = GUIDE_AVATAR_WITH + 1.5;
    self.avatarBKView.frame = newFrame;
    self.avatarBKView.center = self.avatarImageView.center;
    self.avatarBKView.backgroundColor = [UIColor whiteColor];
    
    //变换圆角
    self.avatarBKView.layer.cornerRadius = 15.0f;
    CALayer * layer = self.avatarImageView.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius  = 15.0f;
    
    self.uNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.avatarBKView.frame.origin.x + self.avatarBKView.frame.size.width + 2,
                                                               self.gImageView.frame.size.height,
                                                               self.gImageView.frame.size.width - self.avatarBKView.frame.size.width - self.avatarBKView.frame.origin.x - 2,
                                                               GUIDE_AVATAR_WITH/2)];
    self.uNameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 6];
    self.uNameLabel.textColor = [UIColor lightGrayColor];
    self.uNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.gTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.avatarBKView.frame.origin.x,
                                                                self.gImageView.frame.size.height + GUIDE_AVATAR_WITH/2 + 2,
                                                                self.gImageView.frame.size.width,
                                                                GUIDE_LIST_CELL_HEIGHT - self.gImageView.frame.size.height - GUIDE_AVATAR_WITH/2 -2)];
    self.gTitleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
    self.gTitleLabel.numberOfLines = 2;
    self.gTitleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:self.gImageView];
    [self.contentView addSubview:self.gTitleLabel];
    [self.contentView addSubview:self.uNameLabel];
    [self.contentView addSubview:self.avatarBKView];
    [self.contentView addSubview:self.avatarImageView];
    
    [self.gTitleLabel release];
    [self.uNameLabel release];
    [self.avatarBKView release];
    [self.avatarImageView release];
    [self.gImageView release];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
