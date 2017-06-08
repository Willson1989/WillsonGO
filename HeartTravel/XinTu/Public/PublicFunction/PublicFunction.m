//
//  PublicFunction.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PublicFunction.h"

@implementation PublicFunction

+(PublicFunction *)shareFunction{
    
    static PublicFunction *function = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        function = [[PublicFunction alloc] init];
    });
    return function;
}
+(void)getDataByAFNetWorkingWithURL:(NSString*)urlStr Success:(AFNBlock)block{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:ACCEPTABLE_TYPES, nil];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败");
        
    }];
}

+(void)getDataByAFNetWorkingWithURL:(NSString*)urlStr Success:(AFNBlock)block failure:(AFNFailureBlock)blockf{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:ACCEPTABLE_TYPES, nil];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"网络请求失败");
        blockf();
    }];
}


//共有,UIAlertView创建
+(void)showAlertViewWithTitle:(NSString*)title andMessage:(NSString*)msg forViewController:(UIViewController*)viewController cancelButtonTitle:(NSString*)cancelTitle{
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:viewController cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    [alertView show];
    [alertView release];
}

#pragma mark 根据内容计算子控件高度的方法
+(CGFloat)heightForSubView:(NSString *)content andWidth:(CGFloat)width andFontOfSize:(CGFloat)fontSize{
    /*
     参数一：
     (NSString *)content:子控件的文字内容
     参数二：
     Width:(CGFloat)width:子控件的宽度
     参数三：
     FontOfSize:(CGFloat)fontSize:子控件的文字大小
     该方法的思路：
     1.将文字的属性放入一个字典中，为下一步判断高度时使用
     2.根据内容、内容的文字属性和子控件的宽度，来计算该子控件的高度
     3.返回值为该子控件的高度
     
     *****注意***** 使用该方法的前提时，子控件的两个属性（行数为无限行，换行模式修改）要设置完成
     */
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:fontSize] forKey:NSFontAttributeName];//[UIFont systemFontOfSize:fontSize]为更改字体大小的方法，可以根据实际情况更改
    // NSFontAttributeName为文字属性
    
    CGRect frame = [content boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictionary context:nil];
    // 该方法返回值为一个CGRect类型的数据，即frame
    // 该方法思路为，根据内容和包含内容文字属性的字典来判断frame中的height属性的值
    // NSStringDrawingUsesLineFragmentOrigin 表示用系统当前设定的文字属性来计算高度
    
    return frame.size.height;
}

#pragma mark tableView上方的大图UIImageView的frame变化的方法(写在scrollViewDidScroll代理方法中)
//头部图放大 第三步
+(void)ChangeFrameOfTopImageView:(UIImageView *)topImageView andTableView:(UIScrollView *)tableView{
    if (tableView.contentOffset.y < -IMAGE_HEIGHT) {
        
        CGRect tempFrame = topImageView.frame;
        
        tempFrame.origin.y = tableView.contentOffset.y;
        
        tempFrame.origin.x =(IMAGE_HEIGHT +tableView.contentOffset.y) / 2;
        
        tempFrame.size.width = MYWIDTH - (IMAGE_HEIGHT +tableView.contentOffset.y);
        
        tempFrame.size.height = -(tableView.contentOffset.y) - 15;
        
        topImageView.frame = tempFrame;
    }
}


+(void)ChangeFrameOfTopImageView1:(UIImageView *)topImageView andTableView:(UIScrollView *)tableView{
    CGFloat height = IMAGE_HEIGHT - 20;
    if (tableView.contentOffset.y < -height) {
        
        CGRect tempFrame = topImageView.frame;
        
        tempFrame.origin.y = tableView.contentOffset.y;
        
        tempFrame.origin.x =(height +tableView.contentOffset.y) / 2;
        
        tempFrame.size.width = MYWIDTH - (height +tableView.contentOffset.y);
        
        tempFrame.size.height = -(tableView.contentOffset.y);
        
        topImageView.frame = tempFrame;
    }
}


#pragma mark 将各大洲的名称添加到一个字典中
+(NSMutableDictionary*) ContinentDictionary{
    static NSMutableDictionary * continentDic = nil;
    if (continentDic == nil) {
        continentDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"亚洲",@"Asia",
                                                                         @"欧洲",@"Europe",
                                                                         @"北美洲",@"North America",
                                                                         @"南美洲",@"South America",
                                                                         @"大洋洲",@"Oceania",
                                                                         @"非洲",@"Africa",
                                                                         @"南极洲",@"Antarctica", nil];
    }
    return continentDic;
}

+(UIColor *)getColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue{
    UIColor * color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return color;
}

//自定义风格导航栏
+(void)setupNavigationBarforViewController:(UIViewController *)viewController{
    
    [[PublicFunction shareFunction] creatMoreButton];
    UIColor * barTintColor = SELECT_COLOR;
    UIImage * bkImage = [[UIImage imageNamed:BACK_IMAGE] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:bkImage style:UIBarButtonItemStylePlain target:viewController action:@selector(backAction)];

    
}

//同步get网络请求图片
+(UIImage *)requestImageWithURL:(NSString*)urlStr{
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * imageRequest = [NSMutableURLRequest requestWithURL:url];
    imageRequest.HTTPMethod = @"GET";
    NSURLResponse * imageResponse = nil;
    NSData * imageData = [NSURLConnection sendSynchronousRequest:imageRequest returningResponse:&imageResponse error:nil];
    UIImage * image = [UIImage imageWithData:imageData];
    return image;
}

-(void)creatMoreButton{
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.moreButton.frame = CGRectMake(0, 0, 50, 50);
    
    self.moreButton.backgroundColor = [UIColor clearColor];
    
    [self.moreButton setTitle:@"more" forState:UIControlStateNormal];
    
    [self.moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [self.moreButton addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

+(void)NetReachableforViewController:(UIViewController*)viewController{
    AFNetworkReachabilityManager * reachManager = [AFNetworkReachabilityManager sharedManager];
    [reachManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"没有网络" forViewController:viewController cancelButtonTitle:nil];
        }
        if (status == AFNetworkReachabilityStatusUnknown) {
            [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"未知网络" forViewController:viewController cancelButtonTitle:nil];
        }
        if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            [PublicFunction showAlertViewWithTitle:@"提示" andMessage:@"正在使用蜂窝数据" forViewController:viewController cancelButtonTitle:nil];
        }
    }];
}



-(void)moreButtonAction:(UIButton *)button{
    
    [[SideViewController shareDataHandle] showRightViewController:YES];
}

+(NSString *) getCachePath{
    NSArray * pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * docPath = [pathArray objectAtIndex:0];
    NSString * cachePath = [docPath stringByAppendingPathComponent:Cache_Path];
    return cachePath;
}

@end
