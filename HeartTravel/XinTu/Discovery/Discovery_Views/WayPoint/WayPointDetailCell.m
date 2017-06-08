//
//  WayPointDetailCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WayPointDetailCell.h"

@implementation WayPointDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andOption:(NSInteger)option{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.option = option;
        if (option == 0) {
            [self createTitleSubViews];
        }
        else if (option == 1){
            [self createIntroSubViews];
        }
        else{
            [self createDescSubViews];
        }
    }
    return self;
}

-(void)setWayPoint:(WayPoint *)wayPoint{
    if (_wayPoint != wayPoint) {
        [_wayPoint release];
        _wayPoint = [wayPoint retain];
    }
    if (self.option == 0) {
        self.firstNameLabel.text = self.wayPoint.firstname;
        self.secondNameLabel.text = self.wayPoint.secnodname;
        self.beentoLabel.text = [NSString stringWithFormat:@"%li个人去过",self.wayPoint.beentocounts];
        
    }
    if (self.option == 1){
        self.introLabel.text = self.wayPoint.introduction;
        self.titleLabel.text = @"简介";
    }
}


-(void)setHeightForLabel:(UILabel *)label andType:(NSString*)type{
    
    CGRect tempFrame = label.frame;
    if ([label.text isEqualToString:@""]) {

    }
    else{
        if (label.frame.size.height <= (WP_DESC_CELL_HEIGHT - WP_DETAIL_CELL_INSET*2 - TITLE_HEIGHT)) {
            tempFrame.size.height = (WP_DESC_CELL_HEIGHT - WP_DETAIL_CELL_INSET*2 - TITLE_HEIGHT);
        }
        else{
            tempFrame.size.height = [PublicFunction heightForSubView:label.text andWidth:CGRectGetWidth([[UIScreen mainScreen]bounds]) - WP_DETAIL_CELL_INSET*2 andFontOfSize:MAIN_FONT_SIZE];
            label.frame = tempFrame;
        }
    }
}



-(void)createTitleSubViews{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    self.firstNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(WP_DETAIL_CELL_INSET, WP_DETAIL_CELL_INSET, screenWidth - WP_DETAIL_CELL_INSET*2, screenWidth/25)];
    self.firstNameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
    self.firstNameLabel.textAlignment = NSTextAlignmentLeft;
    self.secondNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.firstNameLabel.frame.origin.x,
                                                                    self.firstNameLabel.frame.origin.y + self.firstNameLabel.frame.size.height,
                                                                    self.firstNameLabel.frame.size.width,
                                                                    self.firstNameLabel.frame.size.height * 1.5)];
    self.secondNameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 2];
    self.secondNameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.recomStar = [[UIImageView alloc]initWithFrame:CGRectMake(self.firstNameLabel.frame.origin.x,
                                                                  self.secondNameLabel.frame.origin.y + self.secondNameLabel.frame.size.height,
                                                                  screenWidth/4,
                                                                  self.firstNameLabel.frame.size.height)];
    self.beentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.firstNameLabel.frame.origin.x,
                                                                self.recomStar.frame.origin.y + self.recomStar.frame.size.height,
                                                                screenWidth - WP_DETAIL_CELL_INSET*2,
                                                                self.recomStar.frame.size.height)];
    self.beentoLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 3];
    self.beentoLabel.textAlignment = NSTextAlignmentLeft;
    self.beentoLabel.textColor = [UIColor grayColor];
    
    [self.contentView addSubview:self.firstNameLabel];
    [self.contentView addSubview:self.secondNameLabel];
    [self.contentView addSubview:self.recomStar];
    [self.contentView addSubview:self.beentoLabel];
    
    [self.firstNameLabel release];
    [self.secondNameLabel release];
    [self.beentoLabel release];
    
}

-(void)createIntroSubViews{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WP_DETAIL_CELL_INSET,
                                                               WP_DETAIL_CELL_INSET + 2,
                                                               screenWidth - WP_DETAIL_CELL_INSET*2,
                                                               screenWidth/30)];
    self.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE ];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.introLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x,
                                                               self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height,
                                                               self.titleLabel.frame.size.width,
                                                               100)];
    self.introLabel.font = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
    self.introLabel.textAlignment = NSTextAlignmentLeft;
    self.introLabel.numberOfLines = 0;
    self.introLabel.textColor = [UIColor grayColor];
    
    self.extendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.extendButton setTitle:@"展开" forState:UIControlStateNormal];
    self.extendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.extendButton addTarget:self action:@selector(extendAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.introLabel];
    [self.contentView addSubview:self.titleLabel];
    
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.introLabel.backgroundColor = [UIColor yellowColor];
    
    [self.titleLabel release];
}

-(void)createDescSubViews{
    self.descTitle = [[UILabel alloc]initWithFrame:CGRectMake(WP_DETAIL_CELL_INSET,
                                                              WP_DETAIL_CELL_INSET,
                                                              sWidth - WP_DETAIL_CELL_INSET*2,
                                                              WP_CELL_HEIGHT/2)];
    self.descContent = [[UILabel alloc]initWithFrame:CGRectMake(self.descTitle.frame.origin.x,
                                                                self.descTitle.frame.origin.y + self.descTitle.frame.size.height,
                                                                self.descTitle.frame.size.width,
                                                                self.descTitle.frame.size.height)];
    
    self.descTitle.textAlignment = NSTextAlignmentLeft;
    self.descContent.textAlignment = NSTextAlignmentLeft;
    self.descTitle.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE];
    self.descContent.font = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
    self.descContent.numberOfLines = 0;
    self.descContent.textColor = [UIColor grayColor];
    
    [self.contentView addSubview:self.descTitle];
    [self.contentView addSubview:self.descContent];
    [self.descContent release];
    [self.descTitle release];
}


-(void)extendAction{
    [self.myDelegate extendCell];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
