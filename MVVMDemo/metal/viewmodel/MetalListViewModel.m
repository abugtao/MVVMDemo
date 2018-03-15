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

@property (nonatomic,strong) UICollectionView  * collectionView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger  page;
@end
@implementation MetalListViewModel


-(instancetype)init{
    self = [super init];
    if (self) {
        self.dataArray = [NSMutableArray array];
        self.itemSubject = [RACSubject subject];
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
                if ([number integerValue]==1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:response.object];
                [self.collectionView reloadData];
                
                self.collectionView.showsInfiniteScrolling = response.totalCount>self.dataArray.count;
                
                [self.collectionView.pullToRefreshView stopAnimating];
                [self.collectionView.infiniteScrollingView stopAnimating];
                
                
            } failCallback:^(HTResponse *response) {
                [subscriber sendNext:response];
                [subscriber sendCompleted];
                
                [self.collectionView.pullToRefreshView stopAnimating];
                [self.collectionView.infiniteScrollingView stopAnimating];
            }];
            
            return nil;
        }];
        
        return requstSignal;
    }];
}


- (void)bindViewModelWithView:(UIView *)view{
    self.collectionView = (UICollectionView *)view;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MetalCollectionViewCell class] forCellWithReuseIdentifier:@"metalcell"];
    
    @weakify(self)
    [self.collectionView addPullToRefreshWithActionHandler:^{
        @strongify(self)
        self.page = 1;
        [self.requestMetalListCommand execute:[NSNumber numberWithInteger:self.page]];
    }];
    
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        self.page++;
        [self.requestMetalListCommand execute:[NSNumber numberWithInteger:self.page]];
    }];
    
    [self.collectionView.pullToRefreshView startAnimating];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MetalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"metalcell" forIndexPath:indexPath];
    [cell.cellSubject sendNext:self.dataArray[indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.itemSubject sendNext:self.dataArray[indexPath.row]];
}

@end
