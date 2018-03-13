//
//  LoginHandler.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "LoginHandler.h"

@implementation LoginHandler
//消息列表
- (HTResponse *)handleMessageCenterListInfo:(NSDictionary *)resultDic{
    
    HTResponse *response = [self preParseWithDic:resultDic];
    
    //    if ([response.status isEqualToString:@"10000"]) {
    //        NSMutableArray *mArray = [NSMutableArray array];
    //        NSDictionary *resultDic = response.object;
    //
    //        NSArray *array = [[resultDic objectForKey:@"data"] objectForKey:@"items"];
    //
    //
    //        for (NSDictionary *dic in array) {
    //            MessageCenterListModel *model = [MessageCenterListModel objectFromDict:dic];
    //            [mArray addObject:model];
    //        }
    //        //        [mArray removeAllObjects];
    //        response.object = mArray;
    //        response.totalPage = [[[resultDic objectForKey:@"data"] objectForKey:@"pageNum"] integerValue];
    //        response.boolArg = mArray.count>=10;
    //
    //    }
    
    return response;
}
@end
