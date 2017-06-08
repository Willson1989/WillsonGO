//
//  FunctionCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_INSET        10
#define FUNC_CELL_HEIGHT  100
#define FUNC_CELL_WIDTH   [[UIScreen mainScreen]bounds].size.width
#define BUTTON_HEIGHT     ((FUNC_CELL_HEIGHT - CELL_INSET * 3)/2)

@protocol functionCellDelegate <NSObject>

-(void)gotoPracticalInfoPage;
-(void)gotoRecomRoutePage;

@end

@interface FunctionCell : UITableViewCell

@property (retain,nonatomic) UIButton * practicalInfoButton;
@property (retain,nonatomic) UIButton * recomRouteButton;
@property (assign,nonatomic) id <functionCellDelegate> myDelegate;


@end
