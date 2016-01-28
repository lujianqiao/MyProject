//
//  LoginViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/25.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "LoginViewController.h"
#import <JSAnimatedImagesView.h>
#import "RegisterViewController.h"
#import "RootViewController.h"

@interface LoginViewController ()<JSAnimatedImagesViewDataSource>

@property(nonatomic,strong)NSMutableArray * imgs;

@property (weak, nonatomic) IBOutlet JSAnimatedImagesView *crView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];
   // self.view.backgroundColor = [UIColor orangeColor];
    //[self.view addSubview:self.crView];
    self.crView.dataSource = self;
    [self.crView startAnimating];
    self.loginButton.layer.cornerRadius = 15;
    // Do any additional setup after loading the view.
    
    BmobObject * obj = [[BmobObject alloc]initWithClassName:@"job"];
  //  [obj setObject:@"haha" forKey:@"name"];
    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
    }];
    
    //进入页面先自动登陆
    NSUserDefaults * userDefa = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [userDefa objectForKey:@"userinfo"];
    
    self.userNameTF.text = [dict objectForKey:@"userName"];
    self.userPWTF.text = [dict objectForKey:@"userPW"];
    if (dict) {
        [SVProgressHUD showWithStatus:@"login...."];
        [BmobUser loginWithUsernameInBackground:[dict objectForKey:@"userName"] password:[dict objectForKey:@"userPW"] block:^(BmobUser *user, NSError *error) {
        if (user) {
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            RootViewController * root = [[RootViewController alloc]init];
            [self presentViewController:root animated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"登陆失败"];
        }
    }];
    }
}

-(NSMutableArray *)imgs
{
    
    if (_imgs == nil) {
        _imgs = @[].mutableCopy;
        for (int index = 11; index < 14; index++) {
            NSString * names = [NSString stringWithFormat:@"%d@2x.jpg",index];
            UIImage * img  =[UIImage imageNamed:names];
            [_imgs addObject:img];
        }
    }
    return _imgs;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressedButtonLogin:(UIButton *)sender {
    [SVProgressHUD showWithStatus:@"login....."];
    [BmobUser loginWithUsernameInBackground:self.userNameTF.text password:self.userPWTF.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            RootViewController * root = [[RootViewController alloc]init];
            [self presentViewController:root animated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"登陆失败"];
        }
    }];
}

- (IBAction)pressedRegisterButton:(UIButton *)sender {
    RegisterViewController * registerh = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:registerh animated:YES completion:nil];
}

-(NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView
{
    
    return self.imgs.count;
}

-(UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return self.imgs[index];
}
@end
