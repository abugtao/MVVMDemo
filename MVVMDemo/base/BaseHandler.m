//
//  BaseHandler.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "BaseHandler.h"

@implementation BaseHandler
- (HTResponse *)preParseWithDic:(NSDictionary *)dic{
    HTResponse *response = [[HTResponse alloc] init];
    //    if (dic.count==0) {
    //        return response;
    //    }
    response.status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
    response.object = dic;
    return response;
}
@end
