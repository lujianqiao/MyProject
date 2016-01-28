//
//  CompanyInfo.m
//  MyProject
//
//  Created by 千锋 on 16/1/19.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "CompanyInfo.h"

@interface CompanyInfo () <UIWebViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation CompanyInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //进入页面先加载职位信息页面
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [self.view addSubview:_webView];
    //NSString * url = [NSString stringWithFormat:@"http://www.xnljl.com/BlueCollar/services/company/detail?company_id=%@",self.model.company_id];
    //     NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.model.detailUrl]];
    
    [request addValue:Mutable_Cookie forHTTPHeaderField:@"Cookie"];
    
    [_webView loadRequest:request];
    
    _webView.delegate = self;

    [self creatUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)setModel:(workPageModel *)model
//{
   // NSLog(@"%@",model.detailUrl);
  //  [self creatUI];
//    NSArray * segmentedData = [[NSArray alloc]initWithObjects:@"职位信息",@"公司信息", nil];
//    UISegmentedControl * segmentedController= [[UISegmentedControl alloc]initWithItems:segmentedData];
//    segmentedController.frame = CGRectMake(100, 150, 100, 40);
//    segmentedController.tintColor = [UIColor colorWithRed:0.09 green:0.53 blue:0.95 alpha:1];
//    segmentedController.selectedSegmentIndex = 0;
//    [segmentedController addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventValueChanged];
//    segmentedController.backgroundColor =[UIColor orangeColor];
//    [self.view addSubview:segmentedController];
//    
    
    
    
//    //UIWebView加载
//    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:webView];
//    NSString * url = [NSString stringWithFormat:@"http://www.xnljl.com/BlueCollar/services/company/detail?company_id=%@",model.company_id];
////    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:model.detailUrl]];
//    [request addValue:@"JSESSIONID=8D10B900654D6C470693B13368E5E797; JSESSIONID=1138AAA4536FF512E7C0A684FB0F6426" forHTTPHeaderField:@"Cookie"];
//    
//    [webView loadRequest:request];
//    
//    webView.delegate = self;
    
//}

-(void)doSomething:(UISegmentedControl *)sender
{
    
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:{
            //workPageModel * model= [[workPageModel alloc]init];
            //UIWebView加载
            _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:_webView];
            //NSString * url = [NSString stringWithFormat:@"http://www.xnljl.com/BlueCollar/services/company/detail?company_id=%@",self.model.company_id];
           //     NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.model.detailUrl]];
            
            [request addValue:@"JSESSIONID=01D796D3F94A1BD794D659D2E4824734" forHTTPHeaderField:@"Cookie"];
            
            [_webView loadRequest:request];
            
            _webView.delegate = self;

        }
            
            break;
            
        case 1:{
            
            //UIWebView加载
            _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
            [self.view addSubview:_webView];
            NSString * url = [NSString stringWithFormat:@"http://www.xnljl.com/BlueCollar/services/company/detail?company_id=%@",self.model.company_id];
            NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            //
         //   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.model.detailUrl]];
            
          //  [request addValue:@"JSESSIONID=8D10B900654D6C470693B13368E5E797; JSESSIONID=1138AAA4536FF512E7C0A684FB0F6426" forHTTPHeaderField:@"Cookie"];
            
            [_webView loadRequest:request];
            
            _webView.delegate = self;
            
        }
            
            
            break;
            
        default:
            break;
    }
}
//裁剪Navigation上面的选择器
-(void)creatUI
{
    NSLog(@"--=-=-=-=-=-=-======%@",self.model.detailUrl);
    UINavigationItem * navigationItem = self.navigationItem;
    
    NSArray * segmentedData = [[NSArray alloc]initWithObjects:@"职位信息",@"公司信息", nil];
        UISegmentedControl * segmentedController= [[UISegmentedControl alloc]initWithItems:segmentedData];
        segmentedController.frame = CGRectMake(100, 150, 100, 30);
        segmentedController.tintColor = [UIColor colorWithRed:0.09 green:0.53 blue:0.95 alpha:1];
        segmentedController.selectedSegmentIndex = 0;
        [segmentedController addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventValueChanged];
        segmentedController.backgroundColor =[UIColor whiteColor];
    segmentedController.layer.cornerRadius = 10;
    navigationItem.titleView = segmentedController;

}

#pragma mark - WebViewDelegate 
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

@end
