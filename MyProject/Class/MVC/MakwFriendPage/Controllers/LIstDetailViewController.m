//
//  LIstDetailViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/21.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "LIstDetailViewController.h"

@interface LIstDetailViewController ()<UIWebViewDelegate>

@end

@implementation LIstDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setModel:(FriendPageModel *)model
{
    UIWebView * webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [self.view addSubview:webview];
    NSString * url = model.detailUrl;
    webview.delegate = self;
  //  NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request addValue:@"JSESSIONID=10E49800BBE60D6F0F7F56E5DA75CB03; JSESSIONID=1138AAA4536FF512E7C0A684FB0F6426" forHTTPHeaderField:@"Cookie"];
    [webview loadRequest:request];
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
