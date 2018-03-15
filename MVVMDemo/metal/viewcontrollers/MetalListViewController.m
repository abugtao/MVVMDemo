//
//  MetalListViewController.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/15.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "MetalListViewController.h"
#import "MetalListViewModel.h"
#import "Metal.h"
@interface MetalListViewController ()
@property (nonatomic,strong) MetalListViewModel * viewModel;
@property (nonatomic,strong) UICollectionView * collectionView;
@end

@implementation MetalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initViews];
    [self setUpViewModel];
    [self requstData];
    
}

- (void)initViews{
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WDITH, SCREEN_HEIGTH - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.itemSize = CGSizeMake((SCREEN_WDITH - 40)/2, (SCREEN_WDITH - 40)/2 + 50);
}

- (void)setUpViewModel{
    
    [self.viewModel bindViewModelWithView:self.collectionView];
    [self.viewModel.itemSubject subscribeNext:^(Metal * metal) {
        
    }];
}

- (void)requstData{
     [self.viewModel.requestMetalListCommand execute:@1];
}

-(MetalListViewModel *)viewModel{
    if (_viewModel==nil) {
        _viewModel = [[MetalListViewModel alloc] init];
    }
    return _viewModel;
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
