//
//  define.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#ifndef define_h
#define define_h
#define SESSION_ID @"session_id"



//函数
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorWithRGBA(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#ifdef DEBUG
#define TLog(format, ...) printf("%s\n\n",[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define TLog(format, ...)
#endif












//常量
#define SCREEN_WDITH [[UIScreen mainScreen] bounds].size.width

#define SCREEN_HEIGTH [[UIScreen mainScreen] bounds].size.height

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define APPCURRENTVERSION [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]

#define PUBKEY  @"-----BEGIN PUBLIC KEY-----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDa3sN08RZ88CnuBbG0ow6pgHjBAh0LeuoP/qurfmfm0d0jM9w/7CRlwWqvAUZqV2xokJzkWKWFhFPthbE1CmsFmknBk4WVQACiPBmCbT8J1tuwYb3B7rn/ducIAuIMl1PmQzzPSch6FTgJ/jKQDVSH4AQzCcNDvffcLvtNW3PJvQIDAQAB-----END PUBLIC KEY-----"





#endif /* define_h */
