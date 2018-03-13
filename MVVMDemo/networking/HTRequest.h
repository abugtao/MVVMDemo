//
//  HTRequest.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTResponse.h"
@interface HTRequest : NSObject
@property (nonatomic,strong) AFHTTPSessionManager * manager;

- (void)postRequestWithUrl:(NSString *)url
                    params:(NSDictionary *)params
           successCallback:(void(^)(HTResponse *response))successcallback
              failCallback:(void(^)(HTResponse *response))failcallback;



- (void)getRequestWithUrl:(NSString *)url
                    params:(NSDictionary *)params
           successCallback:(void(^)(HTResponse *response))successcallback
              failCallback:(void(^)(HTResponse *response))failcallback;


- (void)cancelRequest;
@end
