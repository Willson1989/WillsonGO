//
//  RecomTravelListCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RecomTravelListCell.h"

@implementation RecomTravelListCell

-(void)dealloc{
    [self.travelImage release];
    [self.travelTitle release];
    [self.routeLabel release];
    [super dealloc];
}

-(void)setMyTravel:(RecomTravel *)myTravel{
    if (_myTravel != myTravel) {
        [_myTravel release];
        _myTravel = [myTravel retain];
    }
    [self.travelImage sd_setImageWithURL:[NSURL URLWithString:myTravel.photo] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    self.travelTitle.text = myTravel.subject;
    NSString * countStr = [NSString stringWithFormat:@"%li天    ",myTravel.day_count];
    NSString * subStr   = [countStr substringWithRange:NSMakeRange(0, 4)];
    NSString * tempString = [NSString stringWithFormat:@"%@%@",subStr,myTravel.route];
    NSMutableAttributedString * attributeStr = [[NSMutableAttributedString alloc]initWithString:tempString];
    UIColor * dayCountColor = [PublicFunction getColorWithRed:41.0 Green:228.0 Blue:139.0];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:dayCountColor range:NSMakeRange(0, 4)];
    self.routeLabel.attributedText = attributeStr;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)createSubViews{
    CGFloat screeenWidth = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    self.travelImage = [[UIImageView alloc]initWithFrame:CGRectMake(TRAVEL_CELL_INSET,
                                                                    TRAVEL_CELL_INSET,
                                                                    TRAVEL_LIST_HEIGHT-TRAVEL_CELL_INSET*2,
                                                                    TRAVEL_LIST_HEIGHT-TRAVEL_CELL_INSET*2)];
    
    self.travelTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.travelImage.frame.origin.x + self.travelImage.frame.size.width + 13,
                                                                TRAVEL_CELL_INSET,
                                                                screeenWidth - self.travelImage.frame.size.width - TRAVEL_CELL_INSET*3,
                                                                TRAVEL_CELL_INSET + 2)];
    self.travelTitle.textAlignment = NSTextAlignmentLeft;
    self.travelTitle.textColor = [UIColor blackColor];
    self.travelTitle.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 3];
    
    self.routeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.travelTitle.frame.origin.x,
                                                               self.travelTitle.frame.origin.y + self.travelTitle.frame.size.height,
                                                               self.travelTitle.frame.size.width,
                                                               self.travelImage.frame.size.height - self.travelTitle.frame.size.height)];
    self.routeLabel.numberOfLines = 0;
    self.routeLabel.textAlignment = NSTextAlignmentLeft;
    self.routeLabel.textColor = [UIColor grayColor];
    self.routeLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 6];
    
    [self.contentView addSubview:self.travelTitle];
    [self.contentView addSubview:self.routeLabel];
    [self.contentView addSubview:self.travelImage];
    
    [self.travelTitle release];
    [self.routeLabel release];
    [self.travelImage release];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
