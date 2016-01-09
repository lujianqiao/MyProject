//
//  FriendTableViewController.m
//  MyProject
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "FriendTableViewController.h"

@interface FriendTableViewController ()

@end

@implementation FriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNaviBarButton];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//定制导航栏按钮
-(void)customNaviBarButton
{
    //获取视图控制器的UINavigationItem
    UINavigationItem * naviItem = self.navigationItem;
    //左边按钮
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:nil action:nil];
    naviItem.leftBarButtonItem = leftButtonItem;
    //右边按钮
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发帖" style:UIBarButtonItemStylePlain target:nil action:nil];
    naviItem.rightBarButtonItem = rightButtonItem;
}

-(void)requestData
{
    AFHTTPRequestOperationManager * requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    requestManager.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"application/json"];
    
    [requestManager.requestSerializer setValue:@"JSESSIONID=87BA40E293A70E7B784D70AE7E78F610" forHTTPHeaderField:@"Cookie"];
    
    NSString * url=@"http://121.43.121.176/BlueCollar/services/posts/list";
    [requestManager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //参数一：AFN http请求操作
        //参数二：
        NSLog(@"responseObject====%@",responseObject);

        
        NSData *d = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
        //创建模型对象
       ;
        //-------------------------刷新UITableView，在主线程中刷新
        dispatch_async(dispatch_get_main_queue(),^
                       {
                       });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        //
        NSLog(@"%@",error.localizedDescription);
    }];

    
    
//    NSURLSession * urlSession=[NSURLSession sharedSession];
//    //URL地址
//    NSString * url=@"http://121.43.121.176/BlueCollar/services/posts/list";
//    //创建请求
//    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//
//    NSURLSessionDataTask * task=[urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        if (!error)
//        {
//            NSDictionary * dataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            
//            //   NSLog(@"请求数据位===%@",dataDict);
//            NSLog(@"dataDict=====%@",dataDict);
//            //取出数据
//          
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//            });
//            
//        }
//    }];
//    [task resume];
    

    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

@end
