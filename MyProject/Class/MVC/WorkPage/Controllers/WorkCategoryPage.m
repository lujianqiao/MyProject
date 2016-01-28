//
//  WorkCategoryPage.m
//  MyProject
//
//  Created by 千锋 on 16/1/19.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "WorkCategoryPage.h"
#import "WorkTypeModel.h"
#import "WorkPlaceModel.h"
#import "WorkPlaceDetailModel.h"
#import "MoneyModel.h"
#import "WorkViewController.h"

@interface WorkCategoryPage ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * dataArray1;
@property(nonatomic,strong)NSArray * dataArray2;
@property(nonatomic,strong)NSArray * dataArray3;
@property(nonatomic,strong)UIView * backgroundView;//加载前的视图
@property(nonatomic,copy)NSString * url;
@end

@implementation WorkCategoryPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    [self request];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)dataArrar
{
    if (_dataArray==nil) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
//懒加载
-(NSMutableArray *)dataArray1
{
    if (_dataArray1==nil) {
        _dataArray1 = @[].mutableCopy;
    }
    return _dataArray1;
}

//创建tableView
-(void)creatTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backgroundView];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
}

//请求数据
-(void)request
{
    [SVProgressHUD showWithStatus:@"正在加载"];
    if ([self.title isEqualToString:@"选择工种"]) {
        self.url = WORKTYPE;
    }
    else if ([self.title isEqualToString:@"选择省份"])
    {
        self.url = WORKPLACE;
    }
    else if ([self.title isEqualToString:@"选择薪资"])
    {
        self.url = WAGELIST;
    }
  //  NSString * url= WORKPLACE;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:self.url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray * workTypeArr = responseObject[@"data"];
        for (NSDictionary * dict in workTypeArr) {
            WorkTypeModel * model = [[WorkTypeModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            NSLog(@"ID----%@",model.ID);
            [self.dataArray1 addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
            [self.backgroundView removeFromSuperview];
            [self.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray1.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[[UITableViewCell alloc]init];
    WorkTypeModel * model = self.dataArray1[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.title isEqualToString:@"选择工种"]) {
        WorkTypeModel * model = [self.dataArray1 objectAtIndex:indexPath.row];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"type" object:model.name];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        NSLog(@"%@",model.name);
    }
    else if ([self.title isEqualToString:@"选择省份"])
    {
        WorkPlaceModel * model = [self.dataArray1 objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"place" object:model.name];
        [self.navigationController popViewControllerAnimated:YES];

        NSLog(@"%@",model.name);

    }
    else if ([self.title isEqualToString:@"选择薪资"])
    {
        MoneyModel * model = [self.dataArray1 objectAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"money" object:model.name];
        [self.navigationController popViewControllerAnimated:YES];

        NSLog(@"%@",model.name);

    }
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
