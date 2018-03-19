//
//  MetalListViewModel.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/15.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetalListViewModel : NSObject


@property (nonatomic,strong) RACCommand * requestMetalListCommand;



- (void)bindViewModelWithView:(UIView *)view;

@end
