//
//  LoginViewModel.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginService.h"
@implementation LoginViewModel


-(instancetype)init{
    self = [super init];
    if (self) {
        [self initCommand];
    }
    return self;
}


- (void)initCommand{
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:self.accountModel.name forKey:@"username"];
            [params setObject:self.accountModel.pwd forKey:@"password"];
            [params setObject:@"IOS" forKey:@"device"];
            [params setObject:@"" forKey:@"token"];
            TLog(@"开始请求");
            [[[LoginService alloc] init] requestLoginWithParam:params succCallback:^(HTResponse *response) {
                [subscriber sendNext:response];
                TLog(@"请求完成");
                [subscriber sendCompleted];
            } failCallback:^(HTResponse *response) {
                
                [subscriber sendNext:response];
                TLog(@"请求完成");
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        
        
        
        
        return requestSignal;
    }];
}

-(AccountModel *)accountModel{
    if (_accountModel==nil) {
        _accountModel = [[AccountModel alloc] init];
        
    }
    return _accountModel;
}


@end
