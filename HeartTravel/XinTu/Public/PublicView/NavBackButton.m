//
//  NavBackButton.m
//  XinTu
//
//  Created by WillHelen on 15/7/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NavBackButton.h"

@implementation NavBackButton

+(instancetype)NavBackButtonWithTarget:(id)target Action:(SEL)sel{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    NavBackButton * nb = [[NavBackButton alloc]initWithCustomView:button];
    nb.style = UIBarButtonItemStylePlain;
//    button.backgroundColor = [UIColor yellowColor];
    [button setBackgroundImage:[UIImage imageNamed:@"QYNavBack"] forState:UIControlStateNormal];
    [button addTarget:nb action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    nb.myTarget = target;
    nb.myAction = sel;
    
    return nb;
}

-(void)buttonAction{
    [self.myTarget performSelector:self.myAction];
}



@end
