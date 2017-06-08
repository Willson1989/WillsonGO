//
//  ViewController.m
//  短息_Demo
//
//  Created by WillHelen on 15/7/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMessageComposeViewControllerDelegate>
- (IBAction)innerSend:(id)sender;
- (IBAction)outterSend:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//内部调用短信功能
- (IBAction)innerSend:(id)sender {
    BOOL canSeneMS = [MFMessageComposeViewController canSendText];
    if (canSeneMS) {
        //创建短信视图控制器
        MFMessageComposeViewController * messageVC = [[MFMessageComposeViewController alloc]init];
        //设置代理
        messageVC.messageComposeDelegate = self;
        
        //设置短信内容
        messageVC.body = @"你好,这是一条app内部发出的短信";
        
        //设置目标电话
        messageVC.recipients = [NSArray arrayWithObjects:@"13840418048", nil];
        
        //修改短信界面标题
        [[[[messageVC viewControllers] lastObject] navigationItem] setTitle:@"自定义的短信标题"];
        
        //打开短信页面(模态)
        [self presentViewController:messageVC animated:YES completion:nil];
    }
    else{
        NSLog(@"不能发送短信");
    }
}


//外部调用,但是不会再回到app中
- (IBAction)outterSend:(id)sender {
    NSURL * numberUrl = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",@"13840418048"]];
    
    if ([[UIApplication sharedApplication] canOpenURL:numberUrl]) {
        [[UIApplication sharedApplication] openURL:numberUrl];
    }
    else{
        NSLog(@"无法打开短信功能");
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
//用来监听短信的发送状态
//点击了发送 或者 是取消按钮 都会调用这个方法
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
//    enum MessageComposeResult {
//        MessageComposeResultCancelled,
//        MessageComposeResultSent,
//        MessageComposeResultFailed
//    };
//    typedef enum MessageComposeResult MessageComposeResult;
    
    if (result == MessageComposeResultCancelled) {
        NSLog(@"取消发送短信");
    }
    if (result == MessageComposeResultFailed) {
        NSLog(@"短信发送失败");
    }
    if (result == MessageComposeResultSent) {
        NSLog(@"短信发送chengg");
    }
    [self dismissViewControllerAnimated:controller completion:nil];

}
@end
