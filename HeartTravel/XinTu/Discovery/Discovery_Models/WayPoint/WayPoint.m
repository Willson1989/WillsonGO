//
//  WayPoint.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WayPoint.h"

@implementation WayPoint

@synthesize cate_name,cateid,chinesename,englishname,city_id,
            firstname,secnodname,pointID,introduction,localname,
            site,updatetime,wayto,price,phone,opentime,address;

@synthesize commentcounts,img_count,beentocounts,mapstatus,recommendnumber;
@synthesize comment_list,mguides;
@synthesize duration,lat,lng;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.pointID = value;
    }
}


@end
