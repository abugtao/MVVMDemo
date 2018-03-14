//
//  HTRequest.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "HTRequest.h"
#import "RSA.h"

@implementation HTRequest


- (void)postRequestWithUrl:(NSString *)url
                    params:(NSDictionary *)params
           successCallback:(void(^)(HTResponse *response))successcallback
              failCallback:(void(^)(HTResponse *response))failcallback{
    
    NSDictionary *postParams = [self dealParams:params];
    TLog(@"-url--%@%@",API_BASE_URL,url);
    TLog(@"params---%@---",params);
    TLog(@"doneParams ----%@----",postParams);
    
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
    
    [self.manager POST:url parameters:postParams progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HTResponse *response = [[HTResponse alloc]init];
        response.object = responseObject[@"data"];
        response.message = [responseObject objectForKey:@"message"];
        response.status = responseObject[@"status"];
        response.url = url;
        if ([[[responseObject objectForKey:@"status"] stringValue] isEqualToString:@"10000"]) {
            TLog(@"done---url--%@%@-->%@",API_BASE_URL,url,response.status);
            TLog(@"response---%@",responseObject);
            if(successcallback != nil)
                successcallback(response);
            
        }else{
            TLog(@"done---url--%@%@-->%@",API_BASE_URL,url,responseObject[@"status"]);
            TLog(@"error---%@",responseObject);
            if(failcallback != nil)
                failcallback(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HTResponse *response = [[HTResponse alloc]init];
        response.url = url ;
        response.object = nil;
        
        response.error = error;
        if (error.code==-1001) {
            [CommonUtils alertWithErrorMessage:@"网络不给力，请稍后再试"];
            response.status = @"-10001";
        }
        if (error.code==-1009||error.code == -1003||error.code == -1005) {
            [CommonUtils alertWithErrorMessage:@"您的网络未连接，请检查网络设置"];
            response.status = @"-1009";
        }
        TLog(@"done---url--%@%@-->%@",API_BASE_URL,url,response.status);
        TLog(@"fail---%@",error);
        if (failcallback != nil)
            failcallback(response);
    }];
    
}
- (void)getRequestWithUrl:(NSString *)url
                   params:(NSDictionary *)params
          successCallback:(void(^)(HTResponse *response))successcallback
             failCallback:(void(^)(HTResponse *response))failcallback{
    NSDictionary *postParams = [self dealParams:params];
    TLog(@"-url--%@%@",API_BASE_URL,url);
    TLog(@"params---%@---",params);
    TLog(@"doneParams ----%@----",postParams);
    
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:API_BASE_URL]];
    
    [self.manager GET:url parameters:postParams progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        HTResponse *response = [[HTResponse alloc]init];
        response.object = responseObject;
        response.message = [responseObject objectForKey:@"message"];
        if ([[[responseObject objectForKey:@"status"] stringValue] isEqualToString:@"10000"]) {
            TLog(@"done---url--%@%@-->%@",API_BASE_URL,url,response.status);
            TLog(@"response---%@",responseObject);
            if(successcallback != nil)
                successcallback(response);
            
        }else{
            TLog(@"done---url--%@%@-->%@",API_BASE_URL,url,responseObject[@"status"]);
            TLog(@"error---%@",responseObject);
            response.status = responseObject[@"status"];
            if(failcallback != nil)
                failcallback(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        HTResponse *response = [[HTResponse alloc]init];
        response.url = url ;
        response.object = nil;
        
        response.error = error;
        if (error.code==-1001) {
            [CommonUtils alertWithErrorMessage:@"网络不给力，请稍后再试"];
            response.status = @"-10001";
        }
        if (error.code==-1009||error.code == -1003||error.code == -1005) {
            [CommonUtils alertWithErrorMessage:@"您的网络未连接，请检查网络设置"];
            response.status = @"-1009";
        }
        TLog(@"done---url--%@%@-->%@",API_BASE_URL,url,response.status);
        TLog(@"fail---%@",error);
        if (failcallback != nil)
            failcallback(response);
    }];
}

- (void)cancelRequest{
    [self.manager.operationQueue cancelAllOperations];
}


- (NSDictionary *)dealParams:(NSDictionary *)params{
    if (params == nil) {
        return  params;
    }
    NSArray * values = [params allValues];
    NSArray * keys = [params allKeys];
    NSMutableDictionary * mutDict = [[NSMutableDictionary alloc]init];
    for (int i =0 ; i < [values count] ; i ++ ) {
        NSString * value = [values objectAtIndex:i];
        NSString * key = [keys objectAtIndex:i];
        
        if ([value isKindOfClass:[NSArray class]]||[value isKindOfClass:[NSDictionary class]]) {
            [mutDict setObject:value forKey:key];
            continue;
        }
        NSString *str =  [RSA encryptString:value publicKey:PUBKEY];
        if (str == nil) {
            [mutDict setObject:value forKey:key];
            continue ;
        }
        [mutDict setObject:str forKey:key];
    }
    
    NSDictionary *postParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                mutDict, @"params",[CommonUtils textFormbase64String:[[NSUserDefaults standardUserDefaults] objectForKey:SESSION_ID]], @"session_id",
                                nil];
    return  postParams;
}
@end
