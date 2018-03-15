//
//  LoginHandler.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "LoginHandler.h"
#import "ProductionModel.h"
#import "Metal.h"
@implementation LoginHandler
//消息列表
- (HTResponse *)handleMessageCenterListInfo:(HTResponse *)response{
//        if ([response.status isEqualToString:@"10000"]) {
//            NSMutableArray *mArray = [NSMutableArray array];
//            NSDictionary *resultDic = response.object;
//
//            NSArray *array = [[resultDic objectForKey:@"data"] objectForKey:@"items"];
//
//
//            for (NSDictionary *dic in array) {
//                MessageCenterListModel *model = [MessageCenterListModel objectFromDict:dic];
//                [mArray addObject:model];
//            }
//            //        [mArray removeAllObjects];
//            response.object = mArray;
//            response.totalPage = [[[resultDic objectForKey:@"data"] objectForKey:@"pageNum"] integerValue];
//            response.boolArg = mArray.count>=10;
//
//        }
    
    return response;
}

//产品列表
- (HTResponse *)handleProductionListInfo:(HTResponse *)response{
    if ([response.status integerValue]==10000) {
        NSArray *items = [response.object objectForKey:@"items"];
        NSMutableArray *mArray = [NSMutableArray array];
        
        for (NSDictionary *dic in items) {
            ProductionModel *insuranceModel = [ProductionModel mj_objectWithKeyValues:dic];
            [mArray addObject:insuranceModel];
           
        }
        
        response.totalCount = [[response.object objectForKey:@"totalCount"] integerValue];
     
        response.object = mArray;
        
        
        
    }
    
    return response;
}


//贵金属产品列表
- (HTResponse *)handleMetalProductionListInfo:(HTResponse *)response{
    if ([response.status integerValue]==10000) {
        NSArray *items = [response.object objectForKey:@"items"];
        NSMutableArray *mArray = [NSMutableArray array];
        
        for (NSDictionary *dic in items) {
            Metal *metal = [Metal mj_objectWithKeyValues:dic];
            [mArray addObject:metal];
            
        }
        
        response.totalCount = [[response.object objectForKey:@"totalCount"] integerValue];
        response.object = mArray;
        
        
        
    }
    
    return response;
}
@end
