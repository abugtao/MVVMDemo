//
//  AccountModel.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject<NSCoding>
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * pwd;

@property (nonatomic,copy) NSString * session_id;

@property (nonatomic,copy) NSString * username;
@end
