//
//  ADVDetailViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "ADVDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface ADVDetailViewController ()

@end

@implementation ADVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  //  NSLog(@"%@",self.model.detail_url);
    [self creatView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatView
{
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.model.detail_url]];
    [webView loadRequest:request];
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    [SVProgressHUD dismiss];
    
}
@end
