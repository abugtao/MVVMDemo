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


@end


@implementation ProductionViewModel


-(instancetype)init{
    self = [super init];
    if (self) {
        [self initCommand];
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)bindViewToViewModel:(UIView *)view{
    self.tableView = (UITableView *)view;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[ProductionListTableViewCell class] forCellReuseIdentifier:@"productioncell"];
}


- (void)initCommand{
    _productionListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requstSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            
            [params setObject:@"1" forKey:@"page"];
            [params setObject:@"999" forKey:@"page_size"];
            [params setObject:@"ZTBT" forKey:@"institutionId"];
            [params setObject:@"" forKey:@"insuranceTypes"];
            [[[LoginService alloc] init] requestProductionListWithParam:params succCallback:^(HTResponse *response) {
                [subscriber sendNext:response];
                [self.dataArray addObjectsFromArray:response.object];
                [self.tableView reloadData];
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



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductionListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productioncell" forIndexPath:indexPath];
    [cell.cellSubject sendNext:self.dataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
