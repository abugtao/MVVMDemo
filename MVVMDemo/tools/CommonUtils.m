//
//  CommonUtils.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils
+ (NSString *)base64StringFormText:(NSString *)text{
    if ([text isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (text&&![text isEqualToString:@""]) {
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        return [data base64Encoding];
    }else{
        return @"";
    }
}

+ (NSString *)textFormbase64String:(NSString *)base64{
    if (base64&&![base64 isEqualToString:@""]) {
        //        NSData *data = [base64 ]
        NSData *data = [[NSData alloc] initWithBase64Encoding:base64];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
    }else{
        return @"";
    }
}

+(void)alertWithErrorMessage:(NSString *)message
{
    if (message == nil) {
        return ;
    }
    UIView * myView = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD * hud =[[MBProgressHUD alloc] initWithView:myView];
    hud.mode = MBProgressHUDModeText;
    [myView addSubview:hud];
    hud.bezelView.color = UIColorFromRGB(0x000000);
    hud.detailsLabel.text = message;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    //    hud.yOffset = 0;
    [hud showAnimated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}
@end
