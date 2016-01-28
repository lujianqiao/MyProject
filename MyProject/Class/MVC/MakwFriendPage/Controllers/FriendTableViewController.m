//
//  FriendTableViewController.m
//  MyProject
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "FriendTableViewController.h"
#import "FriendPageModel.h"
#import "FriendTableViewCell.h"
#import "LIstDetailViewController.h"

@interface FriendTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)UIView * backgorundview;

@end

@implementation FriendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];
    [self customNaviBarButton];
    [self requestData];
  //  self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
   self.backgorundview = [[UIView alloc]initWithFrame:self.view.bounds];
    self.backgorundview.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:self.backgorundview];
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataArr
{
    if (_dataArr==nil) {
        _dataArr = @[].mutableCopy;
    }
    return _dataArr;
}


//定制导航栏按钮
-(void)customNaviBarButton
{
    //获取视图控制器的UINavigationItem
    UINavigationItem * naviItem = self.navigationItem;
//    //左边按钮
//    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:nil action:nil];
//    naviItem.leftBarButtonItem = leftButtonItem;
    //右边按钮
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发帖" style:UIBarButtonItemStylePlain target:nil action:nil];
    naviItem.rightBarButtonItem = rightButtonItem;
}

-(void)requestData
{
   [SVProgressHUD showWithStatus:@"正在加载"];
    AFHTTPRequestOperationManager * requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    requestManager.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"application/json"];
    
    [requestManager.requestSerializer setValue:@"JSESSIONID=C4DB20F2D22566A7079D894A53FCF3F0" forHTTPHeaderField:@"Cookie"];
    
  //  NSString * url=@"http://121.43.121.176/BlueCollar/services/posts/list";
    [requestManager POST:LISTURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //参数一：AFN http请求操作
        //参数二：
        
        NSDictionary * Dict = responseObject[@"data"];
        NSArray * modelArr = Dict[@"Postses"];
        
        for (NSDictionary * modelDict in modelArr) {
            FriendPageModel * model = [[FriendPageModel alloc]init];
            [model setValuesForKeysWithDictionary:modelDict];
            [self.dataArr addObject:model];
            
        }
        
        NSData *d = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        
        NSString *s = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
        NSLog(@"responseObject====%@",s);

        //创建模型对象
       ;
        //-------------------------刷新UITableView，在主线程中刷新
        dispatch_async(dispatch_get_main_queue(),^
                       {
                           [self.tableView reloadData];
                           [SVProgressHUD showSuccessWithStatus:@"加载成功"];
                           
                           [UIView animateWithDuration:1 animations:^{
                        [self.backgorundview removeFromSuperview]; 
                           }];
         
                           [SVProgressHUD dismiss];
                       });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        //
        NSLog(@"%@",error.localizedDescription);
    }];
    
}


#pragma mark - Tableviewdatasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"cellID";
    
    FriendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    
//    if (cell==nil) {
//        cell = [[FriendTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
//    }
    
    FriendPageModel * model = self.dataArr[indexPath.row];
    cell.model = model;
    cell.layer.cornerRadius = 10;
    return cell;

      
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LIstDetailViewController * listVC = [[LIstDetailViewController alloc]init];
    listVC.hidesBottomBarWhenPushed = YES;
    listVC.model = self.dataArr[indexPath.row];
    listVC.title = @"帖子";
    [self.navigationController pushViewController:listVC animated:YES];
}

@end
