//
//  CommonDataUtils.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "CommonDataUtils.h"

@implementation CommonDataUtils

+ (void)saveUserInfo:(AccountModel *)accountModel{
    NSData * charData = [NSKeyedArchiver archivedDataWithRootObject:accountModel];
    [[NSUserDefaults standardUserDefaults]setObject:charData forKey:@"CUSTOMERINFO"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (AccountModel *)getUserInfo{
    NSData * decharData = [[NSUserDefaults standardUserDefaults]objectForKey:@"CUSTOMERINFO"];
    AccountModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:decharData];
    return model;
}

+ (void)removeUserInfo{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"CUSTOMERINFO"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
