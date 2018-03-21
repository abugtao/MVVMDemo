//
//  VCControlCenter.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/21.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCControlCenter : NSObject

//不知道去那个vc 根据herf判断去那个vc params下个vc需要的参数
+(void)gotoVCNeddLogin:(BOOL)need formVC:(UIViewController *)formVC withHerf:(NSString *)herf withinfo:(NSDictionary *)params;

//知道去那个vc  params下个vc需要的参数
+(void)gotoMetalVCNeedLogin:(BOOL)need formVC:(UIViewController *)formVC withinfo:(NSDictionary *)params;




@end
