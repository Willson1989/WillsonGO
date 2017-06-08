//
//  GetWifiInfoViewController.m
//  Audio_Demo
//
//  Created by ZhengYi on 16/9/28.
//  Copyright © 2016年 ZhengYi. All rights reserved.
//

#import "GetWifiInfoViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>

//
@interface GetWifiInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wifiNameLabel;

@end

@implementation GetWifiInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    id info = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifName  in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifName);
        NSString *ssid = info[@"SSID"];
        NSString *bssid = info[@"BSSID"];
        NSString *ssiddata = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
        NSLog(@"ssid : %@ \nbssid : %@\nssiddata : %@",ssid,bssid,ssiddata);
        self.wifiNameLabel.text = ssid;
    }
}


@end
