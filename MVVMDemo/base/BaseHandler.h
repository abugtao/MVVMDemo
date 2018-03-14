//
//  BaseHandler.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTResponse.h"
@interface BaseHandler : NSObject
- (HTResponse *)preParseWithDic:(HTResponse *)response;
@end
