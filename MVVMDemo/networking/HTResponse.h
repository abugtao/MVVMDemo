//
//  HTResponse.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTResponse : NSObject

@property (nonatomic,copy) NSString * url;


@property (nonatomic,strong) NSError * error;


@property (nonatomic,copy) NSString * status;
@property (nonatomic,strong) id object;
@property (nonatomic,copy) NSString * message;

@end
