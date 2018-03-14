//
//  UILabel+Helper.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "UILabel+Helper.h"

@implementation UILabel (Helper)
+ (id)labelWithTextColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)alignment text:(NSString *)text{
    UILabel *label = [[[self class] alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.font = font;
    label.textAlignment = alignment;
    label.text = text;
    [label sizeToFit];
    return label;
}
@end
