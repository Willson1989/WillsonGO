//
//  AppDelegate.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)dealloc{
    //    [_window  release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIColor * barColor = SELECT_COLOR;
    [[UINavigationBar appearance] setBarTintColor:barColor];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    CGRectGetWidth([[UIScreen mainScreen]bounds]);
    CGRectGetHeight([[UIScreen mainScreen]bounds]);
    //抽屉
    RightViewController *rightViewController=[[RightViewController alloc]initWithNibName:nil bundle:nil];
    MainTabBarController * mainTabBarC = [[MainTabBarController alloc]init];
    [SideViewController shareDataHandle].rootViewController = mainTabBarC;
    [SideViewController shareDataHandle].rightViewController = rightViewController;
    [SideViewController shareDataHandle].leftViewShowWidth = 200;
    [SideViewController shareDataHandle].needSwipeShowMenu = true;//默认开启的可滑动展示
    self.window.rootViewController = [SideViewController shareDataHandle];
    
    [self.window makeKeyAndVisible];
    
    
    //视频播放器
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];// 播放器即将播放通知
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(videoFinished:) name:@"UIMoviePlayerControllerDidExitFullscreenNotification"object:nil];// 播放器即将退出通知
    
    
    //数据库
    [[SQLDataHandle shareDataHandle] openSqlite];//打开数据库
    
    [[SQLDataHandle shareDataHandle] creatFeatureDollectList];//创建当地特色收藏表
    
    //启动页停留时间
    [NSThread sleepForTimeInterval:3];
    
    //引导页
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"intro_screen_viewed"] == nil) {//判断是否第一次运行该APP
        self.introView = [[ABCIntroView alloc] initWithFrame:self.window.frame];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor greenColor];
        [self.window addSubview:self.introView];
    
    }

    return YES;
}

-(void)onDoneButtonPressed{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
    [defaults synchronize];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
}
-(void)videoStarted:(NSNotification *)notification{ //开始播放的通知执行的方法
    
    //    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.isFull = YES;
}
-(void)videoFinished:(NSNotification *)notification{//完成播放的通知执行的方法
    
    //    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.isFull = NO;
}

-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    //是否全屏逻辑
    if(self.isFull == YES) {
        
        return UIInterfaceOrientationMaskAll;
    }else
        
        return UIInterfaceOrientationMaskPortrait;
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
