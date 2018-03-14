//
//  LoginViewModel.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
@interface LoginViewModel : NSObject

@property (nonatomic,strong) RACCommand * loginCommand;

@property (nonatomic,strong) AccountModel * accountModel;





@end
