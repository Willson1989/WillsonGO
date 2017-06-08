//
//  PublicFunction.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MONActivityIndicatorView;

typedef void (^AFNBlock)(id data);
typedef void (^AFNFailureBlock)();

@interface PublicFunction : NSObject

+(PublicFunction *)shareFunction;

+(void)getDataByAFNetWorkingWithURL:(NSString*)urlStr Success:(AFNBlock)block;
+(void)getDataByAFNetWorkingWithURL:(NSString*)urlStr Success:(AFNBlock)block failure:(AFNFailureBlock)blockf;

+(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)msg forViewController:(UIViewController*)viewController cancelButtonTitle:(NSString*)cancelTitle;

+(CGFloat)heightForSubView:(NSString *)content andWidth:(CGFloat)width andFontOfSize:(CGFloat)fontSize;
+(void)ChangeFrameOfTopImageView1:(UIImageView *)topImageView andTableView:(UIScrollView *)tableView;


+(void)ChangeFrameOfTopImageView:(UIImageView *)topImageView andTableView:(UIScrollView *)tableView;

+(UIImage *)requestImageWithURL:(NSString*)urlStr;

+(NSMutableDictionary*) ContinentDictionary;

+(UIColor *)getColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;

+(void)setupNavigationBarforViewController:(UIViewController *)viewController;

+(void)NetReachableforViewController:(UIViewController*)viewController;

+(NSString *) getCachePath;

+(void)showMONA:(MONActivityIndicatorView *)MONAView forViewController:(UIViewController*)VC;

+(void)stopMONA:(MONActivityIndicatorView *)MONAView;

@property (nonatomic, retain) UIButton *moreButton;

@end
