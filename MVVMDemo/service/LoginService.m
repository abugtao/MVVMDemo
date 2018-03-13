//
//  LoginService.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService
//登录
- (void)requestLoginWithParam:(NSDictionary *)params succCallback:(void (^)(HTResponse * response))succcallback failCallback:(void(^)(HTResponse *response))failcallback{
    [self postRequestWithUrl:API_COSTOMER_LOGIN params:params successCallback:^(HTResponse *response) {
        if (succcallback!=nil) {
            succcallback(response);
        }
    } failCallback:^(HTResponse *response) {
        if(failcallback != nil){
            failcallback(response);
        }
    }];
}
@end
