//
//  ProductionViewModel.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/14.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "ProductionViewModel.h"
#import "ProductionListTableViewCell.h"
#import "LoginService.h"



@interface ProductionViewModel()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,assign) NSInteger  page;


@end


@implementation ProductionViewModel


-(instancetype)init{
    self = [super init];
    if (self) {
        [self initCommand];
        self.itemSubject = [RACSubject subject];
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)bindViewToViewModel:(UIView *)view{
    self.tableView = (UITableView *)view;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ProductionListTableViewCell class] forCellReuseIdentifier:@"productioncell"];
    
    
    @weakify(self)
    [self.tableView addPullToRefreshWithActionHandler:^{
        @strongify(self)
        self.page = 1;
        [self.productionListCommand execute:[NSNumber numberWithInteger:self.page]];
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        self.page++;
        [self.productionListCommand execute:[NSNumber numberWithInteger:self.page]];
    }];
    
}


- (void)initCommand{
    
    @weakify(self)
    _productionListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *number) {
        RACSignal *requstSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:[NSString stringWithFormat:@"%@",number] forKey:@"page"];
            [params setObject:@"3" forKey:@"page_size"];
            [params setObject:@"ZTBT" forKey:@"institutionId"];
            [params setObject:@"" forKey:@"insuranceTypes"];
            [[[LoginService alloc] init] requestProductionListWithParam:params succCallback:^(HTResponse *response) {
                @strongify(self)
                [subscriber sendNext:response];
                if ([number integerValue]==1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:response.object];
                self.tableView.showsInfiniteScrolling = response.totalCount>self.dataArray.count;
                [self.tableView reloadData];
                [subscriber sendCompleted];
                
                [self.tableView.pullToRefreshView stopAnimating];
                [self.tableView.infiniteScrollingView stopAnimating];
            } failCallback:^(HTResponse *response) {
                @strongify(self)
                [subscriber sendNext:response];
                [subscriber sendCompleted];
                
                [self.tableView.pullToRefreshView stopAnimating];
                [self.tableView.infiniteScrollingView stopAnimating];
            }];
            
            return nil;
        }];
        return requstSignal;
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productioncell" forIndexPath:indexPath];
    [cell.cellSubject sendNext:self.dataArray[indexPath.row]];
    
    [cell.collectSubject subscribeNext:^(ProductionViewModel * model) {
        
    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.itemSubject sendNext:self.dataArray[indexPath.row]];
}
@end
