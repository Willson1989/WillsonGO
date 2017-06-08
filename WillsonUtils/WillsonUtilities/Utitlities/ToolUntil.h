//
//  ToolUntil.h
//  Recipe_iPhoneV4
//
//  Created by GaoFei on 14-4-16.
//  Copyright (c) 2014年 Haodou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void(^ImageComplectionHandler)(UIImage *image);
@class MBProgressHUD;
static inline BOOL IsEmpty(id thing) {
    if ([thing isKindOfClass:[NSString class]]) {
        thing = [thing stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return ((NSString*)thing).length==0;
    }
    return thing == nil|| [thing isMemberOfClass:[NSNull class]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

@class UploadFoodMoudle;
@interface ToolUntil : NSObject
+ (UIViewController*)loadFromNib:(NSString *)className;
+ (UIViewController *)loadFromVC:(NSString *)className;
+ (UIViewController*)loadFromNavWithNib:(NSString *)className;
+ (UIViewController*)loadFromNavWithVc:(NSString *)className;

+ (void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset;
+(void)HUDShowNv:(NSString*)labelText yOffset:(NSString*)yOffset;
+ (void)HUDHide;
+ (void)showWithCustomView:(NSString*)labelText;


+ (void)alert:(NSString*)title message:(NSString*)message;
//File
+ (NSString *)documentDirectory;

+ (NSString *)createDirectoryInDocumentDirectory:(NSString *)pathName;

+ (NSString *)createFileInDocumentDirectory:(NSString *)fileName;

//+ (NSMutableAttributedString *)createAttributedString:(CGFloat)lineSpacing text:(NSString *)text;

+ (CGFloat)adjustmentLabelWidth:(CGFloat)width font:(UIFont *)font text:(NSString *)labelText;

+ (float)getLabelWith:(NSString *)str withFont:(UIFont *)font;
+ (NSArray*)createNavItem;

+ (NSArray*)createNavItemWithTarget:(id)target isFave:(NSNumber*)isFave
                            action:(SEL)action;

+ (NSArray*)createNavItemWithTarget:(id)target isFave:(NSNumber*)isFave
                             numText:(NSString*)numText action:(SEL)action;

+(NSArray *)createNavItemWithTarget:(id)target
                            numText:(NSString*)numText
                             action:(SEL)action;

+ (NSArray*)createNavItemExWithTarget:(id)target
                               action:(SEL)action
                          downloadImg:(NSString*)downloadImg;

+ (NSArray*)createNavItemExWithTarget:(id)target action:(SEL)action andImgArry:(NSArray*)imageArray;

+ (NSArray*)createNavItemExWithTarget:(id)target
                               action:(SEL)action
                              numText:(NSString*)numText
                          downloadImg:(NSString*)downloadImg;

+ (NSArray*)createVideoNavItemExWithTarget:(id)target action:(SEL)action;

//+ (BOOL)cookHasSaveInDatabase:(NSString *)recipeID;
+ (void)showHUDErroTip:(NSString*)labelText;
+ (void)showHUDTip:(NSString*)labelText;

+ (NSString*)JSONFromArray:(NSArray*)array;

+ (NSString*)captchaURL;
+(NSString*)validCaptchaURL;
+ (UploadFoodMoudle*)getFromDrafts:(NSString*)foodID;

+ (void)deleteWorkDrafts:(NSString*)workID;
+ (void)deleteFoodDrafts:(NSString*)foodID;
+ (void)deleteTopicDrafts:(NSString*)workID;
+ (NSArray*)allUploadWorks;
+ (NSArray*)allUploadFoods;
+ (NSArray*)allUploadTopics;

+ (NSDictionary*)parmFromRequest:(NSURLRequest*)request;

+ (NSString*)getDeviceVersion;

+ (void)logImageErro:(NSString*)url startTime:(NSTimeInterval)startTime  error:(NSError*)error;

+ (void)upLogFileFromPath:(NSString*)path;

//获得统一遮罩层
+ (UIControl*)getMaskControl;

+ (NSArray *)createNavItemWithTarget:(id)target action:(SEL)action numText:(NSString *)numText;

+ (MBProgressHUD*)showWithLabelDeterminate:(NSString*)labelText;

+ (ALAssetsLibrary *)defaultAssetsLibrary;

+ (void)setCookieAndUserAgent;

+ (void)deleteCookie;

+ (BOOL)storeStatusIsOk;

+ (void)storeHasQRCodeWithID:(NSString*)storeID;

+ (BOOL)goodOfficalStatusIsOk:(NSInteger)officalStatus;

+ (NSArray*)createNavItemExWithTarget:(id)target
                               action:(SEL)action
                          withImgArry:(NSArray*)imageArray
                      andMessageCount:(NSString*)messageCount
                    effectByTintColor:(BOOL)effect;

+ (NSArray*)createNavItemExWithTarget:(id)target
                              actions:(NSArray *)actions
                          withImgArry:(NSArray*)imageArray
                      andMessageCount:(NSString*)messageCount
                    effectByTintColor:(BOOL)effect;

+ (void)processUpImage:(UIImage *)image completed:(ImageComplectionHandler)completed;
+(NSString*)checkLAuthorizationStatus;

//用于用户端我的订单 列表和详情 取得订单类型
+ (NSInteger)orderDetailTypeWithStatus:(NSInteger)orderStatus;
+ (NSInteger)orderListTypeWithStatus:(NSInteger)orderStatus;
+ (void)jumpURLWithString:(NSString *)urlString;

@end
