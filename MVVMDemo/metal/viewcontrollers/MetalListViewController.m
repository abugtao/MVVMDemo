//
//  MetalListViewController.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/15.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "MetalListViewController.h"
#import "MetalListViewModel.h"
#import "MetalCollectionViewCell.h"
#import "Metal.h"
#import "HTResponse.h"
@interface MetalListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) MetalListViewModel * viewModel;
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) NSInteger  page;
@end

@implementation MetalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    self.dataArray = [NSMutableArray array];
    [self initViews];
    [self requstDataWithIndex:self.page];
    [self.collectionView.pullToRefreshView startAnimating];
    
}

- (void)initViews{
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WDITH, SCREEN_HEIGTH - 64) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[MetalCollectionViewCell class] forCellWithReuseIdentifier:@"metalcell"];
    
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    layout.itemSize = CGSizeMake((SCREEN_WDITH - 40)/2, (SCREEN_WDITH - 40)/2 + 50);
    
    @weakify(self)
    [self.collectionView addPullToRefreshWithActionHandler:^{
        @strongify(self)
        self.page = 1;
        [self requstDataWithIndex:self.page];
    }];
    
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        @strongify(self)
        self.page ++;
        [self requstDataWithIndex:self.page];
    }];
}



- (void)requstDataWithIndex:(NSInteger)page{
    @weakify(self)
    [[self.viewModel.requestMetalListCommand execute:[NSNumber numberWithInteger:self.page]] subscribeNext:^(HTResponse * response) {
        @strongify(self)
        if (self.page==1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:response.object];
        
        [self.collectionView reloadData];
        
        
        self.collectionView.showsInfiniteScrolling = response.totalCount>self.dataArray.count;



        [self.collectionView.pullToRefreshView stopAnimating];
        [self.collectionView.infiniteScrollingView stopAnimating];
    }];
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MetalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"metalcell" forIndexPath:indexPath];
    [cell.cellSubject sendNext:self.dataArray[indexPath.row]];
    return cell;
}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    [self.itemSubject sendNext:self.dataArray[indexPath.row]];
//}


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
-(void)dealloc{
    NSLog(@"metal dealloc");
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
