//
//  LoginHandler.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "BaseHandler.h"

@interface LoginHandler : BaseHandler
//消息列表
- (HTResponse *)handleMessageCenterListInfo:(NSDictionary *)resultDic;

@end
