//
//  CrashTool.m
//  MVVMDemo
//
//  Created by user on 2018/4/11.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "CrashTool.h"

@implementation CrashTool

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    
    NSString *crashInfo = [NSString stringWithFormat:@"exception time :%@ \n exception type : %@ \n crash reason : %@ \n call stack info : %@", dateStr,name, reason, arr];
    
    NSLog(@"%@",crashInfo);
    
    
    NSString *pathfile = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"OCCrash.txt"];
    BOOL success = [crashInfo writeToFile:pathfile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (success) {
        
        NSLog(@"sava success! %@",pathfile);
    }
}


+ (void)initCrashTool{
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"OCCrash.txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
        [CrashTool upLoadCrashFileWithData:data withFilePath:filePath];
    }
}


//上传
+ (void)upLoadCrashFileWithData:(NSData *)data withFilePath:(NSString *)filePath{
    
    //上传
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5.0f;
    //告诉AFN，支持接受 text/xml 的数据
    [AFJSONResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString *urlString = @"后台地址";
    
    
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"OCCrash.txt" mimeType:@"txt"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 删除文件
        NSFileManager *fileManger = [NSFileManager defaultManager];
        [fileManger removeItemAtPath:filePath error:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
@end
