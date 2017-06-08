//
//  ToolUntil.m
//  Recipe_iPhoneV4
//
//  Created by GaoFei on 14-4-16.
//  Copyright (c) 2014年 Haodou. All rights reserved.
//

#import "ToolUntil.h"
#import "FileTools.h"
#import "UIView+FrameAddition.h"
#import <CoreLocation/CLLocationManager.h>
#import "UIImage+Scale.h"

//#import "MBProgressHUD.h"
//#import "RSAObject.h"

#define IMAGE_MAX_SIZE 1800000  // 2mb

@implementation ToolUntil
static UIAlertView* sAlert = nil;
static MBProgressHUD* HUD = nil;
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the nib
 */
+ (UIViewController *)loadFromNib:(NSString *)nibName withClass:className
{
	UIViewController* newController = [[NSClassFromString(className) alloc]
									   initWithNibName:nibName bundle:nil];
	//[newController autorelease];
	
	return newController;
}

+ (UIViewController*)loadFromNavWithNib:(NSString*)className {
    UIViewController* temp = [ToolUntil loadFromNib:className];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:temp];
    return nav;
}

+ (UIViewController*)loadFromNavWithVc:(NSString*)className {
    UIViewController *temp  =[ToolUntil loadFromVC:className] ;
    return [[UINavigationController alloc] initWithRootViewController:temp];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the the nib with the same name as the
 * class
 */
+ (UIViewController *)loadFromNib:(NSString *)className
{
	return [ToolUntil loadFromNib:className withClass:className];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller by name
 */
+ (UIViewController *)loadFromVC:(NSString *)className
{
	UIViewController * newController = [[ NSClassFromString(className) alloc] init];
	//[newController autorelease];
	return newController;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+(NSString *)documentDirectory
{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+(NSString *)createDirectoryInDocumentDirectory:(NSString *)pathName
{
    NSString *doc = [ToolUntil documentDirectory];
	NSFileManager *fileHandle = [NSFileManager defaultManager];
	NSString *path = [doc stringByAppendingPathComponent:pathName];
	if(![fileHandle fileExistsAtPath:path]) {
        NSError *error;
		if([fileHandle createDirectoryAtPath:path withIntermediateDirectories:false attributes:nil error:&error]) {
            
        }
        else {
            return nil;
        }
	}
	return path;
}

+(NSString *)createFileInDocumentDirectory:(NSString *)fileName
{
	
	NSString *doc = [ToolUntil documentDirectory];
	NSFileManager *fileHandle = [NSFileManager defaultManager];
	NSString *path = [doc stringByAppendingPathComponent:fileName];
	if(![fileHandle fileExistsAtPath:path]) {
		if([fileHandle createFileAtPath:path contents:nil attributes:nil]) {
            
        }
        else {
            return nil;
        }
	}
	return path;
}

+ (float)getLabelWith:(NSString *)str withFont:(UIFont *)font
{
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100000, 0)];
    [tempLabel setText:str];
    tempLabel.font = font;
    [tempLabel sizeToFit];
    
    return tempLabel.size.width;
}


+ (CGFloat)adjustmentLabelWidth:(CGFloat)width font:(UIFont*)font text:(NSString*)labelText
{
    
//    NSMutableAttributedString * _attribute = [[NSMutableAttributedString alloc] initWithString:labelText];
//    [_attribute addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, labelText.length)];
    
    UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    temp.font = font;
    temp.numberOfLines = 0;
    temp.text = labelText;
    [temp sizeToFit];
    temp.width = width;
    CGSize size = temp.frame.size;
    return ceilf(size.height);
}

+ (void)alert:(NSString*)title message:(NSString*)message
{
    if (sAlert) return;

    sAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title, @"")
                                        message:NSLocalizedString(message, @"")
                                       delegate:self
                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                              otherButtonTitles:nil];
    [sAlert show];
    //[sAlert release];
        sAlert = nil;
}

+ (NSArray*)createNavItem {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = @[ @"btn_header_share", @"btn_header_comment", @"btn_header_favorite" ];
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image = [UIImage imageNamed:obj];
        btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
        [btn setImage:image forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return  items;
}

+ (NSArray*)createNavItemWithTarget:(id)target action:(SEL)action numText:(NSString*)numText {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = @[ @"btn_header_share", @"btn_header_comment", @"btn_header_favorite" ];
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        if (idx==1) {
            UIControl *c = [[UIControl alloc] initWithFrame:CGRectMake(0, 0,  image.size.width+10,image.size.height+10)];
            [c addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            c.tag = idx;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(5, 5,  image.size.width,image.size.height);
            [c addSubview:imageView];
            UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 10, 21)];
            [c addSubview:num];
            num.numberOfLines = 1;
            num.text = numText;
            num.font = [UIFont systemFontOfSize:9];
            num.textColor = [UIColor whiteColor];
            num.backgroundColor = [UIColor redColor];
            num.layer.cornerRadius = 7;
            num.layer.masksToBounds = YES;
            [num sizeToFit];
            num.width+=7;
            num.height+=2;
            num.textAlignment = NSTextAlignmentCenter;
            num.left = c.width-num.width-3;
            item = [[UIBarButtonItem alloc] initWithCustomView:c];
        }else{
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = idx;
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return  items;
}

+ (NSArray*)createNavItemExWithTarget:(id)target
                              actions:(NSArray *)actions
                          withImgArry:(NSArray*)imageArray
                      andMessageCount:(NSString*)messageCount
                    effectByTintColor:(BOOL)effect {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = imageArray;
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        NSString * actionString = actions[idx];
        SEL action = NSSelectorFromString(actionString);
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        if (!effect) {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } else {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        if ([obj isEqualToString:@"top_shopping_cart_white"] ||
            [obj isEqualToString:@"list_shopping_cart_gray"] ||
            [obj isEqualToString:@"btn_header_shoppingcart_orange"]) {

            UIControl* c = [[UIControl alloc]
                            initWithFrame:CGRectMake(0, 0, image.size.width + 10, image.size.height + 10)];
            [c addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            c.tag = idx;
            
            UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(5, 5, image.size.width, image.size.height);
            [c addSubview:imageView];
            if ([messageCount integerValue] > 0) {
                UILabel* num = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 10, 21)];
                [c addSubview:num];
                num.numberOfLines = 1;
                num.text = messageCount;
                num.font = [UIFont systemFontOfSize:9];
                num.textColor = [UIColor whiteColor];
                num.backgroundColor = [UIColor redColor];
                num.layer.cornerRadius = 7;
                num.layer.masksToBounds = YES;
                [num sizeToFit];
                num.width += 7;
                num.height += 2;
                num.textAlignment = NSTextAlignmentCenter;
                num.left = c.width - num.width - 3;
            }
            item = [[UIBarButtonItem alloc] initWithCustomView:c];
        } else {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (idx == 3) {
                btn.frame = CGRectMake(0, 0, image.size.width + 10, image.size.height + 10);
            } else {
                btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            }
            //            [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
            //                 forState:UIControlStateNormal];
            [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                 forState:UIControlStateNormal];
            btn.tag = idx;
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
        
        UIBarButtonItem* negativeSpacer =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    
    return items;
}


+(NSArray*)createNavItemWithTarget:(id)target isFave:(NSNumber*)isFave
                            action:(SEL)action
{
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = @[ @"btn_header_share", @"btn_header_comment", @"btn_header_favorite" ];
    if ([isFave intValue] == 1) {
        images = @[ @"btn_header_share", @"btn_header_comment", @"btn_header_favorite_on" ];
    }
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage *image  = [UIImage imageNamed:obj];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
        [btn setImage:image forState:UIControlStateNormal];
        btn.tag = idx;
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return  items;
}

+ (NSArray*)createNavItemWithTarget:(id)target
                             isFave:(NSNumber*)isFave
                            numText:(NSString*)numText
                             action:(SEL)action {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = @[ @"btn_header_share", @"btn_header_comment", @"btn_header_favorite" ];
    if ([isFave intValue] == 1) {
        images = @[ @"btn_header_share", @"btn_header_comment", @"btn_header_favorite_on" ];
    }
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage *image  = [UIImage imageNamed:obj];
        if (idx==1) {
            UIControl *c = [[UIControl alloc] initWithFrame:CGRectMake(0, 0,  image.size.width+10,image.size.height+10)];
            [c addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            c.tag = idx;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(5, 5,  image.size.width,image.size.height);
            [c addSubview:imageView];
            UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 10, 21)];
            [c addSubview:num];
            num.numberOfLines = 1;
            num.text = numText;
            num.font = [UIFont systemFontOfSize:9];
            num.textColor = [UIColor whiteColor];
            num.backgroundColor = [UIColor redColor];
            num.layer.cornerRadius = 7;
            num.layer.masksToBounds = YES;
            [num sizeToFit];
            num.width+=7;
            num.height+=2;
            num.textAlignment = NSTextAlignmentCenter;
            num.left = c.width-num.width-3;
            item = [[UIBarButtonItem alloc] initWithCustomView:c];
        }else{
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = idx;
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return  items;
}

//TODO ADD
+ (NSArray*)createNavItemWithTarget:(id)target numText:(NSString*)numText action:(SEL)action {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = @[
        @"btn_header_share",
        @"btn_header_comment"
    ];  //@[@"btn_top_setting",@"btn_top_message"]
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        if (idx==1) {
            UIControl *c = [[UIControl alloc] initWithFrame:CGRectMake(0, 0,  image.size.width+10,image.size.height+10)];
            [c addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            c.tag = idx;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(5, 5,  image.size.width,image.size.height);
            [c addSubview:imageView];
            if([numText intValue] != 0) {
                UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 10, 21)];
                [c addSubview:num];
                num.numberOfLines = 1;
                num.text = numText;
                num.font = [UIFont systemFontOfSize:9];
                num.textColor = [UIColor whiteColor];
                num.backgroundColor = [UIColor redColor];
                num.layer.cornerRadius = 7;
                num.layer.masksToBounds = YES;
                [num sizeToFit];
                num.width+=7;
                num.height+=2;
                num.textAlignment = NSTextAlignmentCenter;
                num.left = c.width-num.width-3;
            }
            item = [[UIBarButtonItem alloc] initWithCustomView:c];
        }else{
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = idx;
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return  items;
}

+ (NSArray*)createNavItemExWithTarget:(id)target
                               action:(SEL)action
                              numText:(NSString*)numText
                          downloadImg:(NSString*)downloadImg {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images =
        @[ @"btn_header_share", @"btn_header_comment", downloadImg, @"btn_header_favorite" ];
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        if (idx==1) {
            UIControl *c = [[UIControl alloc] initWithFrame:CGRectMake(0, 0,  image.size.width+10,image.size.height+10)];
            [c addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            c.tag = idx;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(5, 5,  image.size.width,image.size.height);
            [c addSubview:imageView];
            UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 10, 21)];
            [c addSubview:num];
            num.numberOfLines = 1;
            num.text = numText;
            num.font = [UIFont systemFontOfSize:9];
            num.textColor = [UIColor whiteColor];
            num.backgroundColor = [UIColor redColor];
            num.layer.cornerRadius = 7;
            num.layer.masksToBounds = YES;
            [num sizeToFit];
            num.width+=7;
            num.height+=2;
            num.textAlignment = NSTextAlignmentCenter;
            num.left = c.width-num.width-3;
            item = [[UIBarButtonItem alloc] initWithCustomView:c];
        }else{
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (idx == 3) {
                btn.frame = CGRectMake(0, 0,  image.size.width+10,image.size.height+10);
            } else {
                btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
            }
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = idx;
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return  items;
}

+ (NSArray*)createVideoNavItemExWithTarget:(id)target action:(SEL)action {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = @[ @"btn_header_share", @"btn_header_favorite" ];
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
        [btn setImage:image forState:UIControlStateNormal];
        btn.tag = idx;
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return  items;
}

+ (NSArray*)createNavItemExWithTarget:(id)target
                               action:(SEL)action
                          downloadImg:(NSString*)downloadImg {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images =
        @[ @"btn_header_share", @"btn_header_comment", downloadImg, @"btn_header_favorite" ];
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0,  image.size.width,image.size.height);
        [btn setImage:image forState:UIControlStateNormal];
        btn.tag = idx;
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return items;
}

+ (NSArray*)createNavItemExWithTarget:(id)target
                               action:(SEL)action
                           andImgArry:(NSArray*)imageArray {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = imageArray;
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [btn setImage:image forState:UIControlStateNormal];
        btn.tag = idx;
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        UIBarButtonItem* negativeSpacer =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                          target:nil
                                                          action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];
    return items;
}

+ (NSArray*)createNavItemExWithTarget:(id)target
                               action:(SEL)action
                          withImgArry:(NSArray*)imageArray
                      andMessageCount:(NSString*)messageCount
                    effectByTintColor:(BOOL)effect {
    CGFloat offset = isiOS7 ? -10 : 0;
    NSMutableArray* items = [NSMutableArray array];
    NSArray* images = imageArray;
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
        UIBarButtonItem* item;
        UIImage* image = [UIImage imageNamed:obj];
        if (!effect) {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } else {
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        if ([obj isEqualToString:@"top_shopping_cart_white"]  ||
            [obj isEqualToString:@"list_shopping_cart_gray"]  ||
            [obj isEqualToString:@"btn_header_shoppingcart_orange"] ||
            [obj isEqualToString:@"btn_top_message_gray"]) {
            UIControl* c = [[UIControl alloc]
                initWithFrame:CGRectMake(0, 0, image.size.width + 10, image.size.height + 10)];
            [c addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            c.tag = idx;

            UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = CGRectMake(5, 5, image.size.width, image.size.height);
            [c addSubview:imageView];
            if ([messageCount integerValue] > 0) {
                UILabel* num = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 10, 21)];
                [c addSubview:num];
                num.numberOfLines = 1;
                num.text = messageCount;
                num.font = [UIFont systemFontOfSize:9];
                num.textColor = [UIColor whiteColor];
                num.backgroundColor = [UIColor redColor];
                //num.layer.cornerRadius = 7;
                num.textAlignment = NSTextAlignmentCenter;
                num.layer.masksToBounds = YES;
                [num sizeToFit];
                if (num.width < num.height) {
                    num.width = num.height;
                }
                num.width += 4;
                num.height += 4;
                num.layer.cornerRadius = num.height/2;
                num.left = c.width - num.width - 3;
            }
            item = [[UIBarButtonItem alloc] initWithCustomView:c];
        } else {
            UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (idx == 3) {
                btn.frame = CGRectMake(0, 0, image.size.width + 10, image.size.height + 10);
            } else {
                btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            }
//            [btn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
//                 forState:UIControlStateNormal];
            [btn setImage:image forState:UIControlStateNormal];
            btn.tag = idx;
            [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        }

        UIBarButtonItem* negativeSpacer =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                          target:nil
                                                          action:nil];
        negativeSpacer.width = offset;
        [items addObject:negativeSpacer];
        [items addObject:item];
    }];

    return items;
}

//+ (void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset {
//    if (HUD) {
//        [HUD hide:YES];
//    }
//    HUD = [[MBProgressHUD alloc] initWithWindow:kAppDelegate.window];
//    HUD.delegate = kAppDelegate;
//    HUD.animationType = MBProgressHUDAnimationZoom;
//    // [kCurNavController.view addSubview:HUD];
//    //[[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
//    [kAppDelegate.window addSubview:HUD];
//    HUD.labelText = labelText;
//        HUD.yOffset = [yOffset floatValue];
//	[HUD show:YES];
//}


//+(void)HUDShowNv:(NSString*)labelText yOffset:(NSString*)yOffset
//{
//    if (HUD) {
//        [HUD hide:YES];
//    }
//    HUD = [[MBProgressHUD alloc] initWithView:kCurNavController.view];
//    HUD.delegate = kAppDelegate;
//    HUD.animationType = MBProgressHUDAnimationZoom;
//    [kCurNavController.view addSubview:HUD];
//    // [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
//    HUD.labelText = labelText;
//    HUD.yOffset = [yOffset floatValue];
//    [HUD show:YES];
//}

//+ (void)showHUDErroTip:(NSString*)labelText {
//    if (HUD) {
//        [HUD hide:YES];
//    }
//    // TT_RELEASE_SAFELY(HUD);
//    HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
//
//    HUD.yOffset = -45.0f;
//
//    [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
//    // The sample image is based on the work by http://www.pixelpressicons.com,
//    // http://creativecommons.org/licenses/by/2.5/ca/
//    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in
//    // progress indicators)
//    HUD.delegate = kAppDelegate;
//    // Set custom view mode
//    HUD.mode = MBProgressHUDModeText;
//    HUD.detailsLabelText = labelText;
//    HUD.labelFont = kFontSize_Pt30;
//    HUD.detailsLabelFont = kFontSize_Pt30;
//    [HUD show:YES];
//    [HUD hide:YES afterDelay:5];
//    //	[HUD performSelector:@selector(setMode:)
//    //              withObject:MBProgressHUDModeIndeterminate
//    //              afterDelay:1.6];
//}

//+ (void)showHUDTip:(NSString*)labelText {
//    if (HUD) {
//        [HUD hide:YES];
//    }
//	//TT_RELEASE_SAFELY(HUD);
//    HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
//    
//    HUD.yOffset = -45.0f;
//    
//    [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
//	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
//	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
//	HUD.delegate = kAppDelegate;
//    // Set custom view mode
//    HUD.mode = MBProgressHUDModeText;
//    HUD.detailsLabelText = labelText;
//    HUD.labelFont = kFontSize_Pt30;
//	HUD.detailsLabelFont = kFontSize_Pt30;
//    [HUD show:YES];
//	[HUD hide:YES afterDelay:2];
//    //	[HUD performSelector:@selector(setMode:)
//    //              withObject:MBProgressHUDModeIndeterminate
//    //              afterDelay:1.6];
//}
//
//+ (MBProgressHUD*)showWithLabelDeterminate:(NSString*)labelText
//{
//    if (HUD) {
//        [HUD hide:YES];
//    }
//    //TT_RELEASE_SAFELY(HUD);
//    HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
//
//    [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
//    HUD.delegate = kAppDelegate;
//    // Set custom view mode
//    HUD.mode = MBProgressHUDModeDeterminate;
//    HUD.detailsLabelText = labelText;
//    HUD.labelFont = kFontSize_Pt30;
//    HUD.detailsLabelFont = kFontSize_Pt30;
//   // [HUD show:YES];
//    return HUD;
//}
//
//+ (void)showWithCustomView:(NSString*)labelText
//{
//	//TT_RELEASE_SAFELY(HUD);
//    HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:HUD];
//	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
//	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
//	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
//	HUD.delegate = kAppDelegate;
//    // Set custom view mode
//    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.labelText = labelText;
//    HUD.labelFont = kFontSize_Pt30;
//	
//    [HUD show:YES];
//	[HUD hide:YES afterDelay:2];
//    //	[HUD performSelector:@selector(setMode:)
//    //              withObject:MBProgressHUDModeIndeterminate
//    //              afterDelay:1.6];
//}

//+ (void)HUDHide {
//    if (HUD) {
//        [HUD hide:YES];
//        HUD = nil;
//    }
//}

//+ (NSString*)JSONFromArray:(NSArray*)array {
//    NSMutableString *json = [NSMutableString stringWithString:@"["];
//    NSMutableArray *temps = [NSMutableArray array];
//    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[MTLJSONAdapter JSONDictionaryFromModel:obj] options:NSJSONWritingPrettyPrinted error:nil];
//        // [json appendString:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
//        [temps addObject:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
//    }];
//    [json appendString:[temps componentsJoinedByString:@","]];
//    [json appendString:@"]"];
//    return json;
//}

//+ (NSString*)captchaURL
//{
//    return  [[kRequestClient requestWithMethod:@"GET" path:@"info.getCaptcha" parameters:@{@"t":@([[NSDate date] timeIntervalSince1970])} cachePolicy:NSURLRequestUseProtocolCachePolicy].URL absoluteString];
//}

//+(NSString*)validCaptchaURL {
//    return  [[kRequestClient requestWithMethod:@"GET" path:@"Passport.getCaptcha" parameters:@{@"t":@([[NSDate date] timeIntervalSince1970])} cachePolicy:NSURLRequestUseProtocolCachePolicy].URL absoluteString];
//}

//+ (UploadFoodMoudle*)getFromDrafts:(NSString*)foodID
//{
//    NSString *filePath = [kAppConfig createRecipeDirectionOnUserDirection:kUserMoudle.user_uid withRID:foodID];
//    filePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",foodID]];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    UploadFoodMoudle *ufm = nil;
//    if(data) {
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        ufm = [unarchiver decodeObjectForKey:kSaveArchiverKey];
//        [unarchiver finishDecoding];
//    }
//    return ufm;
//}


//
//+ (UploadTopicPhotoModel*)getTopicPhotoFromDrafts:(NSString*)workID {
//    NSString* filePath =
//    [kAppConfig createTopicDirectionOnUserDirection:kUserMoudle.user_uid withRID:workID];
//    filePath =
//    [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive", workID]];
//    NSData* data = [NSData dataWithContentsOfFile:filePath];
//    UploadTopicPhotoModel* ufm = nil;
//    if (data) {
//        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        ufm = [unarchiver decodeObjectForKey:kSaveArchiverKey];
//        [unarchiver finishDecoding];
//    }
//    return ufm;
//}
//
//+ (UploadWorkPhotoModel*)getWorkPhotoFromDrafts:(NSString*)workID {
//    NSString* filePath =
//        [kAppConfig createWorkDirectionOnUserDirection:kUserMoudle.user_uid withRID:workID];
//    filePath =
//        [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive", workID]];
//    NSData* data = [NSData dataWithContentsOfFile:filePath];
//    UploadWorkPhotoModel* ufm = nil;
//    if (data) {
//        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//        ufm = [unarchiver decodeObjectForKey:kSaveArchiverKey];
//        [unarchiver finishDecoding];
//    }
//    return ufm;
//}

//+ (void)deleteWorkDrafts:(NSString*)workID {
//    NSString* filePath =
//        [kAppConfig createWorkDirectionOnUserDirection:kUserMoudle.user_uid withRID:workID];
//    deleteFileAboutPath(filePath);
//}
//
//
//+ (void)deleteTopicDrafts:(NSString*)workID {
//    NSString* filePath =
//    [kAppConfig createTopicDirectionOnUserDirection:kUserMoudle.user_uid withRID:workID];
//    deleteFileAboutPath(filePath);
//}
//
//+ (void)deleteFoodDrafts:(NSString*)foodID {
//    NSString* filePath =
//        [kAppConfig createRecipeDirectionOnUserDirection:kUserMoudle.user_uid withRID:foodID];
//    deleteFileAboutPath(filePath);
//}

//+ (NSArray*)allUploadWorks {
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    NSError* error;
//    NSString* path = [kAppConfig createUserDirectionOnSaveWorkDirection:kUserMoudle.user_uid];
//    NSArray* directoryContent =
//        [fileManager contentsOfDirectoryAtURL:[NSURL fileURLWithPath:path]
//                   includingPropertiesForKeys:@[ NSURLContentModificationDateKey ]
//                                      options:NSDirectoryEnumerationSkipsHiddenFiles
//                                        error:&error];
//
//    NSArray* sortedContent =
//        [directoryContent sortedArrayUsingComparator:^(NSURL* file1, NSURL* file2) {
//            // compare
//            NSDate* file1Date;
//            [file1 getResourceValue:&file1Date forKey:NSURLContentModificationDateKey error:nil];
//
//            NSDate* file2Date;
//            [file2 getResourceValue:&file2Date forKey:NSURLContentModificationDateKey error:nil];
//
//            // Ascending:
//            // return [file1Date compare: file2Date];
//            // Descending:
//            return [file2Date compare:file1Date];
//        }];
//
//    NSMutableArray* allUfms = [NSMutableArray array];
//    [sortedContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
//        NSArray* temp = [((NSURL*)obj).absoluteString componentsSeparatedByString:@"/"];
//        if (temp.count >= 2) {
//            NSString* rid = temp[temp.count - 2];
//            DDLogDebug(@"WORK %@", rid);
//            UploadWorkPhotoModel* photo = [ToolUntil getWorkPhotoFromDrafts:rid];
//            if (photo != nil) {
//                [allUfms addObject:photo];
//            }
//        }
//    }];
//
//    return allUfms;
//}

//+ (NSArray*)allUploadTopics {
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    NSError* error;
//    NSString* path = [kAppConfig createUserDirectionOnSaveTopicDirection:kUserMoudle.user_uid];
//    NSArray* directoryContent =
//    [fileManager contentsOfDirectoryAtURL:[NSURL fileURLWithPath:path]
//               includingPropertiesForKeys:@[ NSURLContentModificationDateKey ]
//                                  options:NSDirectoryEnumerationSkipsHiddenFiles
//                                    error:&error];
//    
//    NSArray* sortedContent =
//    [directoryContent sortedArrayUsingComparator:^(NSURL* file1, NSURL* file2) {
//        // compare
//        NSDate* file1Date;
//        [file1 getResourceValue:&file1Date forKey:NSURLContentModificationDateKey error:nil];
//        
//        NSDate* file2Date;
//        [file2 getResourceValue:&file2Date forKey:NSURLContentModificationDateKey error:nil];
//        
//        // Ascending:
//        // return [file1Date compare: file2Date];
//        // Descending:
//        return [file2Date compare:file1Date];
//    }];
//    
//    NSMutableArray* allUfms = [NSMutableArray array];
//    [sortedContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL* stop) {
//        NSArray* temp = [((NSURL*)obj).absoluteString componentsSeparatedByString:@"/"];
//        if (temp.count >= 2) {
//            NSString* rid = temp[temp.count - 2];
//            DDLogDebug(@"WORK %@", rid);
//            UploadTopicPhotoModel* photo = [ToolUntil getTopicPhotoFromDrafts:rid];
//            if (photo != nil) {
//                [allUfms addObject:photo];
//            }
//        }
//    }];
//    
//    return allUfms;
//}

//+ (NSArray*)allUploadFoods {
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    NSError *error;
//    NSString *path = [kAppConfig createUserDirectionOnSaveDirection:kUserMoudle.user_uid];
//    NSArray *directoryContent =  [fileManager
//                                  contentsOfDirectoryAtURL:[NSURL fileURLWithPath:path]includingPropertiesForKeys:@[NSURLContentModificationDateKey]
//                                  options:NSDirectoryEnumerationSkipsHiddenFiles
//                                  error:&error];
//    
//    NSArray *sortedContent = [directoryContent sortedArrayUsingComparator:
//                              ^(NSURL *file1, NSURL *file2)
//                              {
//                                  // compare
//                                  NSDate *file1Date;
//                                  [file1 getResourceValue:&file1Date forKey:NSURLContentModificationDateKey error:nil];
//                                  
//                                  NSDate *file2Date;
//                                  [file2 getResourceValue:&file2Date forKey:NSURLContentModificationDateKey error:nil];
//                                  
//                                  // Ascending:
//                                  //return [file1Date compare: file2Date];
//                                  // Descending:
//                                  return [file2Date compare: file1Date];
//                              }];
//    
//    NSMutableArray *allUfms = [NSMutableArray array];
//    [sortedContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSArray *temp = [((NSURL*)obj).absoluteString componentsSeparatedByString:@"/"];
//        if (temp.count>=2) {
//            NSString *rid = temp[temp.count-2];
//            DDLogDebug(@"FOODID %@",rid);
//            UploadFoodMoudle *food = [ToolUntil getFromDrafts:rid];
//            if (food!=nil) {
//                [allUfms addObject:food];
//            }
//        }
//    }];
//    
//    return allUfms;
//}

//从request 中得到 参数
+ (NSDictionary*)parmFromRequest:(NSURLRequest*)request
{
    NSMutableDictionary * parms = [NSMutableDictionary dictionary];
    [[[NSString stringWithUTF8String:(char*)[[request HTTPBody] bytes]] componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray *temps = [obj componentsSeparatedByString:@"="];
        if ([temps count]==2) {
            [parms setObject:temps[1] forKey:temps[0]];
        }
    }];
    return parms;
}

+ (NSString*)getDeviceVersion
{
    size_t size;
    //sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    //sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+(void)logImageErro:(NSString *)url startTime:(NSTimeInterval)startTime error:(NSError *)error
{
    if (IsEmpty(url)) {
        return;
    }
    NSTimeInterval endTime = [[NSDate date] timeIntervalSince1970];
    NSString *log = [NSString stringWithFormat:@"{\"url\":\"%@\",\"errorMsg\":\"%@\",\"requestTime\":%f,\"startTime\":%.0f,\"errorCode\":%d}",url,error.localizedDescription,(endTime-startTime),startTime,error.code];
}

+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}



#pragma mark - Static Function
//+ (void)setCookieAndUserAgent
//{
//    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//    NSString* userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//    if ([userAgent rangeOfString:@"HAODOU_IOS_RECIPE"].location == NSNotFound) {
//        userAgent =  [NSString stringWithFormat:@"%@ HAODOU_IOS_RECIPE %@ %@ %@",userAgent, VERSION_CODE, (kHDDevice.bWWAN?@"3G":@"WIFI"), kHDDevice.uuid];
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userAgent, @"UserAgent", nil];
//        [USER_DEFAULT registerDefaults:dictionary];
//    }
//    
//    UserMoudle *um = [UserMoudle sharedUser];
//    if (![um userHasLogin]) {
//        [ToolUntil deleteCookie];
//        return;
//    }
//    
//    NSString *strSign = [RSAObject getRSAEncryptString:NON(um.user_sign)];
//    NSMutableDictionary *cookiePropertiesUser = [NSMutableDictionary dictionary];
//    [cookiePropertiesUser setObject:@"uid" forKey:NSHTTPCookieName];
//    [cookiePropertiesUser setObject:NON(um.user_uid) forKey:NSHTTPCookieValue];
//    [cookiePropertiesUser setObject:@".haodou.com" forKey:NSHTTPCookieDomain];
//    [cookiePropertiesUser setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookiePropertiesUser setObject:@"0" forKey:NSHTTPCookieVersion];
//    
//    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
//    
//    cookiePropertiesUser = [NSMutableDictionary dictionary];
//    [cookiePropertiesUser setObject:@"sign" forKey:NSHTTPCookieName];
//    [cookiePropertiesUser setObject:[strSign URLEncodedString] forKey:NSHTTPCookieValue];
//    [cookiePropertiesUser setObject:@".haodou.com" forKey:NSHTTPCookieDomain];
//    [cookiePropertiesUser setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookiePropertiesUser setObject:@"0" forKey:NSHTTPCookieVersion];
//    
//    cookieuser = [NSHTTPCookie cookieWithProperties:cookiePropertiesUser];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
//}
//
//+ (void)deleteCookie{
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *cookieAry = [cookieJar cookies];//[cookieJar cookiesForURL: [NSURL URLWithString:@"api.haodou.com"]];
//    for (cookie in cookieAry) {
//        if ([cookie.domain isEqualToString:@".haodou.com"]) {
//            if ([[cookie name] isEqualToString:@"uid"] || [[cookie name] isEqualToString:@"sign"])
//            {
//                [cookieJar deleteCookie: cookie];
//            }
//        }
//    }
//}


+ (void)processUpImage:(UIImage *)image completed:(ImageComplectionHandler)completed
{
    ImageComplectionHandler handler = [completed copy];
    @autoreleasepool {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage* originalImage = image;
            NSData* imageData = UIImageJPEGRepresentation(originalImage, 1);
            originalImage = [UIImage imageWithData:imageData];
            //图片大于制定的最大尺寸的时候进行等比缩放
            if (imageData.length > IMAGE_MAX_SIZE) {
                CGFloat scaleFactor = (float)IMAGE_MAX_SIZE / imageData.length;
                CGSize scaledSize = CGSizeMake(originalImage.size.width * scaleFactor,
                                               originalImage.size.height * scaleFactor);
                originalImage = [originalImage scaledCopyOfSizeMin:scaledSize];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) {
                    handler(originalImage);
                }
            });
        });
    }
}


+(NSString*)checkLAuthorizationStatus{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    NSString *str;
    if (status==kCLAuthorizationStatusNotDetermined) {
        str = @"Not Determined";
    }
    
    if (status==kCLAuthorizationStatusDenied) {
        str = @"Denied";
    }
    
    if (status==kCLAuthorizationStatusRestricted) {
        str = @"Restricted";
    }
    
    if (status==kCLAuthorizationStatusAuthorizedAlways) {
        str = @"Allowed";
    }
    
    if (status==kCLAuthorizationStatusAuthorizedWhenInUse) {
        str = @"Allowed";
    }
    return str;
}


//+ (void)jumpURLWithString:(NSString *)urlString{
//    NSString* url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    if ([url hasPrefix:@"http://"]) {
//        NSString* urlStr =
//        [NSString stringWithFormat:@"haodourecipe://haodou.com/openurl/?url=%@", url];
//        [kAppDelegate applicationOpenURL:[NSURL URLWithString:urlStr]];
//    } else {
//        [kAppDelegate applicationOpenURL:[NSURL URLWithString:url]];
//    }
//}

@end
