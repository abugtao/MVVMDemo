//
//  LoginService.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "HTRequest.h"

@interface LoginService : HTRequest
//登录
- (void)requestLoginWithParam:(NSDictionary *)params succCallback:(void (^)(HTResponse * response))succcallback failCallback:(void(^)(HTResponse *response))failcallback;
@end