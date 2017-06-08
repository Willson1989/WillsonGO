//
//  RadioListRootViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RadioListRootViewController.h"

@implementation RadioListRootViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];;
    
    [self creatSubVC];
    
    [self creatSegment];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, 20, 20, 20);
    
    
    [self.backButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIImage * image = [UIImage imageNamed:@"auth_back_button_image.png"];
    image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.backButton setBackgroundImage:image forState:UIControlStateNormal];
    self.backButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft; //button居左
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:self.backButton] autorelease];
    
}


-(void)leftButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)creatSubVC{
    
    self.hotVC = [[HotRadioViewController alloc] init];
    
    self.hotVC.urlId = self.urlId;
    self.hotVC.delegate = self;
    
    [self addChildViewController:self.hotVC];
    [self.view addSubview:self.hotVC.view];
    
    [_hotVC release];

    self.classicalVC = [[ClassicalRadioViewController alloc] init];
    
    self.classicalVC.urlId = self.urlId;
    self.classicalVC.delegate = self;

    
    [self addChildViewController:self.classicalVC];
    [self.view addSubview:self.classicalVC.view];
    
    [_classicalVC release];
    
    
    self.myNewVC = [[NewRadioViewController alloc] init];
    self.myNewVC.delegate = self;
    self.myNewVC.urlId = self.urlId;
 
    
    [self addChildViewController:self.myNewVC];
    [self.view addSubview:self.myNewVC.view];
    
    [_myNewVC release];

    
}

-(void)creatSegment{
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"热门", @"经典", @"最新", nil];
    
    self.radioSegment = [[UISegmentedControl alloc] initWithItems:titleArray];

    self.radioSegment.frame = CGRectMake(0,
                                 0,
                                 self.view.frame.size.width,
                                 TOP_BAR_HEIGHT);
    self.radioSegment.backgroundColor = [UIColor whiteColor];
    self.radioSegment.selectedSegmentIndex = 0;
    self.radioSegment.tintColor = SELECT_COLOR;
    
    [self.radioSegment addTarget:self action:@selector(radioSegmentAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.radioSegment];
    [_radioSegment release];

}

-(void)radioSegmentAction:(UISegmentedControl *)segment{
    
    if (segment.selectedSegmentIndex == 0) {
        
        [self.view bringSubviewToFront:self.hotVC.view];
        [self.view bringSubviewToFront:self.radioSegment];
        
        
    }else if (segment.selectedSegmentIndex == 1) {
        
        [self.view bringSubviewToFront:self.classicalVC.view];
         [self.view bringSubviewToFront:self.radioSegment];
        
    }else if (segment.selectedSegmentIndex == 2) {
        
        [self.view bringSubviewToFront:self.myNewVC.view];
        [self.view bringSubviewToFront:self.radioSegment];
        
    }
}


-(void)dealloc{
    [_classicalVC release];
    [_myNewVC release];
    [_hotVC release];
    [_radioSegment release];
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = self.name;
    
    [self.view bringSubviewToFront:self.hotVC.view];
    [self.view bringSubviewToFront:self.radioSegment];

}
-(void)pushPlayListVC:(UIViewController *)playListVC{
    
    [self.navigationController pushViewController:playListVC animated:YES];
}









@end
