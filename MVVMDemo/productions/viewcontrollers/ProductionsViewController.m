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
#import "MetalListViewController.h"
@interface ProductionsViewController ()

@property (nonatomic,strong) ProductionViewModel * viewmodel;

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ProductionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initViews];
    [self setupViewModel];
    [self requstData];
    
}

- (void)initViews{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WDITH, SCREEN_HEIGTH - 64) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

- (void)setupViewModel{
    [self.viewmodel bindViewToViewModel:self.tableView];
    @weakify(self)
    [self.viewmodel.itemSubject subscribeNext:^(ProductionViewModel *model) {
        @strongify(self)
//        MetalListViewController *listVC = [[MetalListViewController alloc] init];
//        [self.navigationController pushViewController:listVC animated:YES];


        [VCControlCenter gotoMetalVCNeedLogin:YES formVC:self withinfo:NULL];
    }];
}

- (void)requstData{
    
    [self.viewmodel.productionListCommand execute:@1];
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
-(void)dealloc{
    NSLog(@"production dealloc");
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
