//
//  EncoderDecoder.h
//  归档
//
//  Created by 张海涛 on 2017/4/1.
//  Copyright © 2017年 张海涛. All rights reserved.
//

#define encodeRuntime(A) -(void)encodeWithCoder:(NSCoder *)aCoder{\
    unsigned int count = 0;\
    Ivar *ivars = class_copyIvarList([A class], &count);\
    for (int i = 0; i<count; i++) {\
        Ivar ivar = ivars[i];\
        const char *name = ivar_getName(ivar);\
        NSString *key = [NSString stringWithUTF8String:name];\
        id value = [self valueForKey:key];\
        [aCoder encodeObject:value forKey:key];\
    }\
    free(ivars);\
}


#define initCoderRuntime(A) -(instancetype)initWithCoder:(NSCoder *)aDecoder{\
    if (self = [super init]) {\
        unsigned int count = 0;\
        Ivar *ivars = class_copyIvarList([A class], &count);\
        for (int i = 0; i<count; i++) {\
            Ivar ivar = ivars[i];\
            const char *name = ivar_getName(ivar);\
            NSString *key = [NSString stringWithUTF8String:name];\
            id value = [aDecoder decodeObjectForKey:key];\
            [self setValue:value forKey:key];\
        }\
        free(ivars);\
    }\
    return self;\
}
