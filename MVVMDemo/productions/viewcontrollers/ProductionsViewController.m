//
//  ProductionsViewController.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "ProductionsViewController.h"
#import "ProductionViewModel.h"
#import "HTResponse.h"
@interface ProductionsViewController ()

@property (nonatomic,strong) ProductionViewModel * viewmodel;

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ProductionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViewModel];
    [self requstData];
    
}
- (void)requstData{
    [[self.viewmodel.productionListCommand execute:nil] subscribeNext:^(HTResponse * resonse) {
        
    }];
}

- (void)setupViewModel{
    [self.viewmodel bindViewToViewModel:self.tableView];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WDITH, SCREEN_HEIGTH - 64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}
-(ProductionViewModel *)viewmodel{
    if (_viewmodel==nil) {
        _viewmodel = [[ProductionViewModel alloc] init];
        
    }
    return _viewmodel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
