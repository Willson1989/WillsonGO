//
//  DetailPageCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailCellDelegate <NSObject>

-(void)gotoAllListPageByClickedButton:(UIButton *)button;

@end

@interface DetailPageCell : UITableViewCell

@property (retain,nonatomic) UILabel * hotTitleLabel;
@property (retain,nonatomic) UIButton * allListButton;
@property (assign,nonatomic) id <DetailCellDelegate> myDelegate;


@end
