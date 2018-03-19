//
//  UseDataManager.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/19.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "UseDataManager.h"

@implementation UseDataManager
singleM(UseDataManager)

-(instancetype)init{
    self = [super init];
    if (self) {
        [self creatTable];
    }
    return self;
}

- (void)creatTable{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"userData.sqlite"];
    FMDatabase* GPWDdb = [FMDatabase databaseWithPath:dbpath];
    
    if (![GPWDdb open]) {
        NSLog(@"open GPWDdb failed!");
        return;
    }
    
    
    NSString *creatStringSql = @"CREATE TABLE UserList (name text, pwd text)";
    BOOL b =  [GPWDdb executeUpdate:creatStringSql];
    if (b) {
        NSLog(@"creat GPWDlist success!");
    }else{
        NSLog(@"creat GPWDlist fail!");
    }
    
    
    [GPWDdb close];
}


- (void)addGPWDwithName:(NSString *)name withPWD:(NSString *)pwd{
    
    
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"userData.sqlite"];
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbpath];
    
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = [db executeUpdate:@"insert into UserList (name,pwd) values (?,?)",name,pwd];
        if (result) {
            NSLog(@" 插入成功 - %@", [NSThread currentThread]);
        }
        
//        FMResultSet *rs = [db executeQuery:@"SELECT * FROM UserList WHERE name = ?",name];
//        if ([rs next]) {
//            BOOL result = [db executeUpdate:@"update UserList set pwd = ? where name = ?",pwd,name];
//
//
//            if (result) {
//                NSLog(@"修改成功");
//            }else{
//                NSLog(@"修改失败%@",[db lastErrorMessage]);
//            }
//        }else{
//
//            BOOL result = [db executeUpdate:@"insert into UserList (name,pwd) values (?,?)",name,pwd];
//
//            if (result) {
//                NSLog(@"插入成功");
//            }else{
//                NSLog(@"插入失败");
//            }
//        }
    }];
    
    
    
//    FMDatabase* GPWDdb = [FMDatabase databaseWithPath:dbpath];
//
//    if (![GPWDdb open]) {
//        NSLog(@"open GPWDdb failed!");
//        return;
//    }
//    FMResultSet *rs = [GPWDdb executeQuery:@"SELECT * FROM UserList WHERE name = ?",name];
//    if ([rs next]) {
//        BOOL result = [GPWDdb executeUpdate:@"update UserList set pwd = ? where name = ?",pwd,name];
//
//
//        if (result) {
//            NSLog(@"修改成功");
//        }else{
//            NSLog(@"修改失败%@",[GPWDdb lastErrorMessage]);
//        }
//    }else{
//
//        BOOL result = [GPWDdb executeUpdate:@"insert into UserList (name,pwd) values (?,?)",name,pwd];
//
//        if (result) {
//            NSLog(@"插入成功");
//        }else{
//            NSLog(@"插入失败");
//        }
//    }
//
//    [GPWDdb close];
}
@end
