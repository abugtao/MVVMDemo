//
//  VCControlCenter.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/21.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "VCControlCenter.h"
#import "MetalListViewController.h"
#import "LoginViewController.h"
@implementation VCControlCenter


//不知道去那个vc 根据herf判断去那个vc
+(void)gotoVCNeddLogin:(BOOL)need formVC:(UIViewController *)formVC withHerf:(NSString *)herf withinfo:(NSDictionary *)params{
    if(need&&1){
        //需要且没有登录
        [[self class] dealLoginWithLoginSuccessBlock:^{
            if([herf isEqualToString:@"1"]){
                [[self class] gotoMetalVCNeedLogin:NO formVC:formVC withinfo:params];
            }
        }];
    }else{
        if([herf isEqualToString:@"1"]){
            [[self class] gotoMetalVCNeedLogin:NO formVC:formVC withinfo:params];
        }
    }
}

+(void)gotoMetalVCNeedLogin:(BOOL)need  formVC:(UIViewController *)formVC withinfo:(NSDictionary *)params{
    if(need&&1){
        //需要且没有登录
        [[self class] dealLoginWithLoginSuccessBlock:^{
            UINavigationController *nav = [UIApplication sharedApplication].keyWindow.rootViewController;
            MetalListViewController *listVC = [[MetalListViewController alloc] init];
            [nav pushViewController:listVC animated:YES];
        }];
        
    }else{
        UINavigationController *nav = [UIApplication sharedApplication].keyWindow.rootViewController;
        MetalListViewController *listVC = [[MetalListViewController alloc] init];
        [nav pushViewController:listVC animated:YES];
    }
    
    
}



+ (void)dealLoginWithLoginSuccessBlock:(void(^)(void))loginSuceessBlock{
    UINavigationController *nav = [UIApplication sharedApplication].keyWindow.rootViewController;
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    @weakify(loginVC)
    loginVC.loginSuccessBlock = ^{
        @strongify(loginVC)
        [loginVC dismissViewControllerAnimated:YES completion:^{
            loginSuceessBlock();
        }];
    };
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [nav presentViewController:loginNav animated:YES completion:NULL];
}

@end
