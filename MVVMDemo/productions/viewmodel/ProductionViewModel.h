//
//  ProductionViewModel.h
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductionViewModel : NSObject
@property (nonatomic,strong) RACCommand * productionListCommand;

@property (nonatomic,strong) RACSubject * itemSubject;


- (void)bindViewToViewModel:(UIView *)view;
@end
