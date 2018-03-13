//
//  LoginViewModel.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel




-(AccountModel *)accountModel{
    if (_accountModel==nil) {
        _accountModel = [[AccountModel alloc] init];
        
    }
    return _accountModel;
}


@end
