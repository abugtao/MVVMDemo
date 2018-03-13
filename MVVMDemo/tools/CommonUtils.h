//
//  CommonUtils.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject
//base64加密
+ (NSString *)base64StringFormText:(NSString *)text;
//base64解密
+ (NSString *)textFormbase64String:(NSString *)base64;

+(void)alertWithErrorMessage:(NSString *)message;
@end
