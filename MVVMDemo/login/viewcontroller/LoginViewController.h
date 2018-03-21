//
//  LoginViewController.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <UIKit/UIKit.h>
//typeof (void)(^LoginSuccessBlock)(void);
@interface LoginViewController : UIViewController


@property (nonatomic,copy) void(^loginSuccessBlock)(void);

@end
