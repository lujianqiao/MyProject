//
//  PublicNoticeTableViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/18.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "PublicNoticeTableViewController.h"
#import "PublicNoticeModel.h"
#import "PublicNoticeTableViewCell.h"
@interface PublicNoticeTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIView * backgroundView;
@end

@implementation PublicNoticeTableViewController

//懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self creatTableView];
    [self requestData];
    
}

-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(5, 5, screenSize.width-10, screenSize.height)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.tableView setScrollEnabled:NO];
    [self.tableView registerNib:[UINib nibWithNibName:@"PublicNoticeTableViewCell" bundle:nil] forCellReuseIdentifier:@"PublicNoticeTableViewCell"];
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backgroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//请求数据
-(void)requestData
{
    [SVProgressHUD showWithStatus:@"正在加载"];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:PUBLICNOTIC parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"responseObject======%@",responseObject);
        NSArray * allArr = responseObject[@"data"];
        for (NSDictionary * dict in allArr) {
            PublicNoticeModel * model = [[PublicNoticeModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }
        
        __weak typeof(self) weakSelf = self;
       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
           
           [UIView animateWithDuration:5 animations:^{
               [weakSelf.backgroundView removeFromSuperview];
           }];
           [SVProgressHUD showSuccessWithStatus:@"加载成功"];

       });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PublicNoticeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PublicNoticeTableViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 10;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.row==0) {
        return screenSize.height/5;
    }
//    else if (indexPath.row==1)
//    {
//        return screenSize.height/5;
//    }
    else if (indexPath.row)
    {
        return screenSize.height/5;
    }
    else
        return 0;
}

@end
