//
//  MetalListViewModel.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/15.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "MetalListViewModel.h"
#import "MetalCollectionViewCell.h"
#import "LoginService.h"
@interface MetalListViewModel()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) NSMutableArray * dataArray;
@end
@implementation MetalListViewModel


-(instancetype)init{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        [self initCommand];
    }
    return self;
}


- (void)initCommand{
    _requestMetalListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *number) {
        RACSignal *requstSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:@"1605" forKey:@"networkId"];
            [params setObject:[NSString stringWithFormat:@"%@",number] forKey:@"page"];
            [params setObject:@"10" forKey:@"page_size"];
            [params setObject:@"ZTBT" forKey:@"proxyId"];
            [[[LoginService alloc] init] requestMetalProductionListWithParam:params succCallback:^(HTResponse *response) {
                
                
    
                
                [subscriber sendNext:response];
                [subscriber sendCompleted];
                
                

                
                
            } failCallback:^(HTResponse *response) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
                

            }];
            
            return nil;
        }];
        
        return requstSignal;
    }];
}






@end
