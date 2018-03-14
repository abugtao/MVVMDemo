//
//  LoginViewController.m
//  MVVMDemo
//
//  Created by EGO on 2018/3/13.
//  Copyright © 2018年 zhanghaitao. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginService.h"
#import "ProductionsViewController.h"
@interface LoginViewController ()
@property (nonatomic,strong) UITextField * nameTextField;

@property (nonatomic,strong) UITextField * pwdTextField;

@property (nonatomic,strong) UIButton * loginBtn;


@property (nonatomic,strong) LoginViewModel * viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self initViews];
    
    [self setupViewModel];
    
}

- (void)initViews{
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.nameTextField.placeholder = @"name";
    self.nameTextField.center = CGPointMake(SCREEN_WDITH/2, 100);
    [self.view addSubview:self.nameTextField];
    
    
    self.pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.pwdTextField.placeholder = @"pwd";
    self.pwdTextField.center = CGPointMake(SCREEN_WDITH/2, 200);
    [self.view addSubview:self.pwdTextField];
    
    
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [self.loginBtn setTitle:@"login" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.loginBtn.center = CGPointMake(SCREEN_WDITH/2, 300);
    [self.view addSubview:self.loginBtn];
    
    
    @weakify(self)
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        //
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        [params setObject:self.nameTextField.text forKey:@"username"];
//        [params setObject:self.pwdTextField.text forKey:@"password"];
//        [params setObject:@"IOS" forKey:@"device"];
//        [params setObject:@"" forKey:@"token"];
//        [[[LoginService alloc] init] requestLoginWithParam:params succCallback:^(HTResponse *response) {
//
//        } failCallback:^(HTResponse *response) {
//
//        }];
        @weakify(self)
        [[self.viewModel.loginCommand execute:nil] subscribeNext:^(HTResponse *response) {
            @strongify(self)
            if ([response.status integerValue]==10000) {
                AccountModel *model = [AccountModel mj_objectWithKeyValues:response.object];
                NSLog(@"%@",model);
                model.name = self.nameTextField.text;
                model.pwd = self.pwdTextField.text;
                [CommonDataUtils saveUserInfo:model];
                
                
                ProductionsViewController *listVC = [[ProductionsViewController alloc] init];
                [self.navigationController pushViewController:listVC animated:YES];
                
                
            }
            
            
        }];
    }];
    
    
}

- (void)setupViewModel{
    RAC(self.viewModel.accountModel,name) = _nameTextField.rac_textSignal;
    RAC(self.viewModel.accountModel,pwd) = _pwdTextField.rac_textSignal;
    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[RACObserve(self.viewModel.accountModel, name),RACObserve(self.viewModel.accountModel, pwd)] reduce:^id(NSString *name,NSString *pwd){
        return @(name.length>3&&pwd.length>3);
    }];
    
    
}

-(LoginViewModel *)viewModel{
    if (_viewModel==nil) {
        _viewModel = [[LoginViewModel alloc] init];
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
