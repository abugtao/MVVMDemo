//
//  CommonDataUtils.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
@interface CommonDataUtils : NSObject


+ (void)saveUserInfo:(AccountModel *)accountModel;

+ (AccountModel *)getUserInfo;

+ (void)removeUserInfo;
@end
