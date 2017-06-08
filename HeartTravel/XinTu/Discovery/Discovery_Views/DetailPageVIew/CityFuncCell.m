//
//  CityFuncCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CityFuncCell.h"

@implementation CityFuncCell

-(void)dealloc{
    
    [self.foodButton release];
    [self.foodLabel release];
    [self.viewSightButton release];
    [self.viewSightLabel release];
    [self.activityButton release];
    [self.activityLabel release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)createSubViews{
    self.viewSightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.viewSightButton.frame = CGRectMake(SPACE_BETWEEN_BUTTONS,
                                            BUTTON_UP_INSET,
                                            CITY_FUNC_BUTTON_WIDTH,
                                            CITY_FUNC_BUTTON_WIDTH);
    self.viewSightButton.backgroundColor = [PublicFunction getColorWithRed:252.0 Green:66.0 Blue:81.0];
    self.viewSightButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    self.viewSightLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.viewSightButton.frame.origin.x,
                                                                   self.viewSightButton.frame.origin.y + self.viewSightButton.frame.size.height,
                                                                   CITY_FUNC_LABEL_WIDTH,
                                                                   CITY_FUNC_LABEL_HEIGHT)];
    self.viewSightLabel.text = @"景点";
    self.viewSightLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.viewSightLabel.textColor = [UIColor grayColor];
    
    //---------------------
    
    self.foodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.foodButton.frame = CGRectMake(SPACE_BETWEEN_BUTTONS * 2 + CITY_FUNC_BUTTON_WIDTH,
                                       BUTTON_UP_INSET,
                                       CITY_FUNC_BUTTON_WIDTH,
                                       CITY_FUNC_BUTTON_WIDTH);
    self.foodButton.backgroundColor = [PublicFunction getColorWithRed:60.0 Green:204.0 Blue:95.0];
    self.foodButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    self.foodLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.foodButton.frame.origin.x,
                                                              self.foodButton.frame.origin.y + self.foodButton.frame.size.height,
                                                              CITY_FUNC_LABEL_WIDTH,
                                                              CITY_FUNC_LABEL_HEIGHT)];
    self.foodLabel.text = @"美食";
    self.foodLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.foodLabel.textColor = [UIColor grayColor];
    //---------------------
    
    self.activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.activityButton.frame = CGRectMake(SPACE_BETWEEN_BUTTONS * 3 + CITY_FUNC_BUTTON_WIDTH * 2,
                                           BUTTON_UP_INSET,
                                           CITY_FUNC_BUTTON_WIDTH,
                                           CITY_FUNC_BUTTON_WIDTH);
    self.activityButton.backgroundColor = [PublicFunction getColorWithRed:63.0 Green:171.0 Blue:245.0];
    self.activityButton.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    self.activityLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.activityButton.frame.origin.x,
                                                                  self.activityButton.frame.origin.y + self.foodButton.frame.size.height,
                                                                  CITY_FUNC_LABEL_WIDTH,
                                                                  CITY_FUNC_LABEL_HEIGHT)];
    self.activityLabel.text = @"找玩的";
    self.activityLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.activityLabel.textColor = [UIColor grayColor];
    
    [self.foodButton setTitle:@"美食" forState:UIControlStateNormal];
    [self.activityButton setTitle:@"活动" forState:UIControlStateNormal];
    [self.viewSightButton setTitle:@"景点" forState:UIControlStateNormal];
    
    [self.foodButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.activityButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.viewSightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.foodButton.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.activityButton.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    self.viewSightButton.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 5];
    
    self.activityLabel.textAlignment = NSTextAlignmentCenter;
    self.foodLabel.textAlignment = NSTextAlignmentCenter;
    self.viewSightLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.viewSightButton addTarget:self action:@selector(viewSightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.activityButton addTarget:self action:@selector(activeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.foodButton addTarget:self action:@selector(foodButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //    [self.contentView addSubview:self.viewSightLabel];
    //    [self.contentView addSubview:self.foodLabel];
    //    [self.contentView addSubview:self.activityLabel];
    [self.contentView addSubview:self.viewSightButton];
    [self.contentView addSubview:self.foodButton];
    [self.contentView addSubview:self.activityButton];
    
    [self.viewSightButton release];
    [self.viewSightLabel release];
    [self.foodButton release];
    [self.foodLabel release];
    [self.activityButton release];
    [self.activityLabel release];
    
}

-(void)viewSightButtonAction{
    [self.myDelegate gotoWayPointListPageWithCategoryID:32];
}

-(void)activeButtonAction{
    [self.myDelegate gotoWayPointListPageWithCategoryID:148];
}

-(void)foodButtonAction{
    [self.myDelegate gotoWayPointListPageWithCategoryID:78];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
