//
//  RadioListRootViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRadioViewController.h"
#import "NewRadioViewController.h"
#import "ClassicalRadioViewController.h"

@interface RadioListRootViewController : UIViewController<HotRadioViewControllerDelegate, ClassicalRadioViewControllerDelegate, NewRadioViewControllerDelegate>

@property (nonatomic ,copy) NSString *urlId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, retain) UISegmentedControl *radioSegment;

@property (nonatomic, retain) HotRadioViewController *hotVC;

@property (nonatomic, retain) NewRadioViewController *myNewVC;

@property (nonatomic, retain) ClassicalRadioViewController *classicalVC;

@property (nonatomic, retain) UIButton *backButton;


@end
