//
//  RegisterViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/25.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "RegisterViewController.h"
#import <JSAnimatedImagesView.h>
#import "LoginViewController.h"
@interface RegisterViewController ()<JSAnimatedImagesViewDataSource>
@property (weak, nonatomic) IBOutlet JSAnimatedImagesView *crView;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPW;
@property (weak, nonatomic) IBOutlet UITextField *confirmPW;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property(nonatomic,strong)NSMutableArray * imgs;

@end

@implementation RegisterViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];
    self.crView.dataSource = self;
    [self.crView startAnimating];
    self.registerButton.layer.cornerRadius = 15;
    [self check];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)userName:(UITextField *)sender {
    [self check];
}
- (IBAction)userPW:(UITextField *)sender {
    [self check];
}
- (IBAction)userPWS:(UITextField *)sender {
    [self check];
}

- (IBAction)backToLoginPage:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//检查
-(void)check
{
    if (self.userName.text.length>0&&self.userPW.text.length>0&&self.confirmPW.text.length) {
        self.registerButton.enabled = YES;
    }
    else
    {
        self.registerButton.enabled = NO;
    }
    
    
}

//注册点击实现
- (IBAction)registerButtonPressed:(UIButton *)sender {
    [self check];
    [SVProgressHUD showWithStatus:@"正在注册"];
    BmobUser * user = [[BmobUser alloc]init];
    user.username = self.userName.text;
    user.password = self.userPW.text;
    
    //先判断是否是手机号
    //检查是否是手机号
       NSString *mobileReg = @"^1[34578][0-9]\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileReg];
    
    BOOL isMatch = [pred evaluateWithObject:self.userName.text];
    
    if (isMatch) {
    
    if ([self.userPW.text isEqualToString:self.confirmPW.text]) {
        
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
       
        if (isSuccessful) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            
            LoginViewController * login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            NSDictionary * dict = @{@"userName":self.userName.text,@"userPW":self.userPW.text};
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:dict forKey:@"userinfo"];
            
            [self dismissViewControllerAnimated:login completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
        }
    }];
    }
        
    else
    {
        [SVProgressHUD showErrorWithStatus:@"密码不一致"];
    }
    
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请输入号码"];
    }
}

//背景地图的实现
-(NSUInteger)animatedImagesNumberOfImages:(JSAnimatedImagesView *)animatedImagesView
{
    return self.imgs.count;
}

-(UIImage *)animatedImagesView:(JSAnimatedImagesView *)animatedImagesView imageAtIndex:(NSUInteger)index
{
    return self.imgs[index];
}
@end
