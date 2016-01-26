//
//  WorkViewController.m
//  MyProject
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "WorkViewController.h"
#import "PersonPageViewController.h"
#import "workPageModel.h"
#import "ADVModel.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "ThirdTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ADVDetailViewController.h"
#import "WorkCategoryPage.h"
#import "CompanyInfo.h"

//Tag值
#define SCROLL_VIEW_TAG 10
#define PAGE_CONTROLLER_TAG 100
@interface WorkViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView * _topScrollView;//上面的新闻Scroll
    UIPageControl * _pageController;
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArry;//TableView的数据数组
@property(nonatomic,strong)NSMutableArray * secPageArr;
@property(nonatomic,strong)NSMutableArray * ADVDataArr;
@property(nonatomic,strong)UIView * backgroundView;//加载前的视图
@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD dismiss];
    self.view.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self creatTopScrollView];
 //   [self customNaviBarButton];
    [self CreatTableView];
    [self requestData];
    [self publicNoticData];
}

//懒加载
-(NSMutableArray *)dataArry
{
    if (_dataArry==nil) {
        _dataArry=@[].mutableCopy;
    }
    return _dataArry;
}
-(NSMutableArray *)secPageArr
{
    if (_secPageArr==nil) {
        _secPageArr=@[].mutableCopy;
    }
    return _secPageArr;
}

-(NSMutableArray *)ADVDataArr
{
    if (_ADVDataArr == nil) {
        _ADVDataArr = @[].mutableCopy;
    }
    return _ADVDataArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatTopScrollView
{
    _topScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, ([[UIApplication sharedApplication]statusBarFrame].size.height +self.navigationController.navigationBar.frame.size.height), screenSize.width, screenSize.height/4)];
    [self.view addSubview:_topScrollView];
  //  _topScrollView.backgroundColor=[UIColor orangeColor];
    _topScrollView.pagingEnabled = YES;
    _topScrollView.delegate = self;
    _topScrollView.bounces = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.userInteractionEnabled = YES;
    for (int index=0; index<self.ADVDataArr.count; index++) {
        UIImageView * ADVimage = [[UIImageView alloc]initWithFrame:CGRectMake(index*(CGRectGetWidth(_topScrollView.frame)), 0, CGRectGetWidth(_topScrollView.frame), CGRectGetHeight(_topScrollView.frame))];
        [_topScrollView addSubview:ADVimage];
        ADVimage.userInteractionEnabled = YES;
        ADVModel * model = self.ADVDataArr[index];
        [ADVimage sd_setImageWithURL:[NSURL URLWithString:model.img_src]];
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToADVDetailPage:)];
        [ADVimage addGestureRecognizer:tapGesture];
        ADVimage.tag = model.ID;
        
    }
    _topScrollView.contentSize = CGSizeMake(screenSize.width*self.ADVDataArr.count, 0);
    _topScrollView.tag = SCROLL_VIEW_TAG;
    
  _pageController= [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetWidth(_topScrollView.frame)/2, CGRectGetHeight(_topScrollView.frame)+([[UIApplication sharedApplication]statusBarFrame].size.height +self.navigationController.navigationBar.frame.size.height)-40, 100, 30)];
    [self.view addSubview:_pageController];
    _pageController.numberOfPages = self.ADVDataArr.count;
    _pageController.currentPage = 0;
    _pageController.pageIndicatorTintColor = [UIColor grayColor];
    _pageController.currentPageIndicatorTintColor = [UIColor orangeColor];
}
#pragma mark - 广告页面点击
-(void)ToADVDetailPage:(UITapGestureRecognizer *)sender
{
    UIView * tempView = [sender view];
    NSInteger tempIndex = tempView.tag;
    for (int index=0; index<self.dataArry.count; index++) {
        ADVModel * model = self.ADVDataArr[index];
        if (tempIndex==model.ID) {
            NSLog(@"传值吧");
            ADVDetailViewController * ADVVC = [[ADVDetailViewController alloc]init];
            ADVVC.hidesBottomBarWhenPushed = YES;
            ADVVC.title = @"广告详情";
            ADVVC.model = model ;
            [self.navigationController pushViewController:ADVVC animated:YES];
      //      ADVVC.model = model ;

            break;
        }
    }
    
    
    NSLog(@"%ld",tempIndex);
}
#pragma mark - scrollView
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageController.currentPage = currentPage;
}
//共告数据加载
-(void)publicNoticData
{
    [SVProgressHUD showWithStatus:@"正在加载"];
    //task请求
    //Session
    NSURLSession * urlSession = [NSURLSession sharedSession];
    //创建请求
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:ADCLIST]];
    NSURLSessionDataTask * task = [urlSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary * datadict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //    NSLog(@"datadict----%@",datadict);
            NSArray * dataArr = datadict[@"data"];
       //     NSLog(@"dataArr==%@",dataArr);
            
            for (NSDictionary * dict in dataArr) {
                ADVModel * model = [[ADVModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.ADVDataArr addObject:model];
            }
//            NSData * data = [NSJSONSerialization dataWithJSONObject:datadict options:NSJSONWritingPrettyPrinted error:nil];
//            NSString * str  =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            NSLog(@"str===%@",str);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self creatTopScrollView];
                
                [self.backgroundView removeFromSuperview];
                [SVProgressHUD showSuccessWithStatus:@"加载成功"];
            });
        }
    }];
    [task resume];
}



//TbaleView的数据加载
-(void)requestData
{
    [SVProgressHUD showWithStatus:@"正在加载"];
    AFHTTPRequestOperationManager * requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.requestSerializer  = [AFJSONRequestSerializer serializer];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
   // [requestManager.requestSerializer setValue:@"JSESSIONID=20D5866CAA24F0A8C8FA002EFA616701" forHTTPHeaderField:@"Cookie"];
      [requestManager.requestSerializer setValue:@"JSESSIONID=1F79A574B813A89651BA4BB652E2676C01" forHTTPHeaderField:@"Cookie"];
    NSString * url = @"http://www.xnljl.com/BlueCollar/services/job/getlist";
    NSDictionary * dict = @{@"pageSize":@40,@"pageOffset":@40};
   [requestManager POST:url parameters:dict success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
       
   //    NSLog(@"1111responseObject=%@",responseObject);
       NSArray * dictArr = responseObject[@"data"];
       for (NSDictionary * modelDict in dictArr) {
           workPageModel * model = [[workPageModel alloc]init];
           [model setValuesForKeysWithDictionary:modelDict];
           
           NSString * detailArr = modelDict[@"istop"];
           NSLog(@"istop====%@",detailArr);
           
           if ([detailArr integerValue] == 1) {
               [self.secPageArr addObject:model];
           }
           else
           {
               [self.dataArry addObject:model];
           }
       }
       NSData * data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
       NSString * str  =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       NSLog(@"1111responseObject=%@",str);
       
       //公司详情的监听
       for (int index=0; index<self.secPageArr.count; index++) {
           
           workPageModel * model = self.secPageArr[index];
           [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ToCompanyInfo:) name:[NSString stringWithFormat:@"%@",model.ID] object:nil];
       }

       dispatch_async(dispatch_get_main_queue(), ^{
           [self.tableView reloadData];
           [SVProgressHUD showWithStatus:@"加载成功"];
           if (self.backgroundView) {
               [self.backgroundView removeFromSuperview];
           }
           [SVProgressHUD dismiss];
       });
       
   } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
       
   }];
}


#pragma mark -tableView
-(void)CreatTableView
{
    //创建工作页面的TableView
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_topScrollView.frame), screenSize.width-10, screenSize.height)];
    [self.view addSubview:_tableView];
    _tableView.userInteractionEnabled = YES;
    _tableView.delegate=self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    
    //加载前的视图创建
    self.backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.backgroundView];
    self.backgroundView.backgroundColor =[UIColor whiteColor];
    //监听工种 , 工种地点，选择的响应事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeToWCPage) name:@"workcategory" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeToWPPage) name:@"workplace" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeToWWPage) name:@"workwage" object:nil];
    //公司详情的监听
//    for (int index=0; index<self.secPageArr.count; index++) {
//        
//        workPageModel * model = self.secPageArr[index];
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ToCompanyInfo:) name:[NSString stringWithFormat:@"%@",model.detailUrl] object:nil];
//    }
}
//监听响应事件
-(void)changeToWCPage
{
    NSLog(@"接收到了监听");
    WorkCategoryPage * wcPage = [[WorkCategoryPage alloc]init];
    wcPage.hidesBottomBarWhenPushed = YES;
    wcPage.title = @"选择工种";
    [self.navigationController pushViewController:wcPage animated:YES];
}

-(void)changeToWPPage
{
    WorkCategoryPage * wcPage = [[WorkCategoryPage alloc]init];
    wcPage.hidesBottomBarWhenPushed = YES;
    wcPage.title = @"选择省份";
    [self.navigationController pushViewController:wcPage animated:YES];

}
-(void)changeToWWPage
{
    WorkCategoryPage * wcPage = [[WorkCategoryPage alloc]init];
    wcPage.hidesBottomBarWhenPushed = YES;
    wcPage.title = @"选择薪资";
    [self.navigationController pushViewController:wcPage animated:YES];
}

-(void)ToCompanyInfo:(NSNotification *)noti
{
    NSLog(@"-=-=-=-=-=.....%@",noti.object);
    CompanyInfo * company = [[CompanyInfo alloc]init];
    company.model = noti.object;
    company.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:company animated:YES];
}

#pragma mark-UITableViewDataSourse
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return (self.dataArry.count+2);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FirstTableViewCell"];
        if (cell==nil) {
            cell=[[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FirstTableViewCell"];
            cell.layer.cornerRadius  = 5;
        }
        return cell;

    }
    else if (indexPath.row==1){
        SecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SecondTableViewCell"];
        if (cell==nil) {
            cell=[[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecondTableViewCell"];
            
            cell.dataArray = self.secPageArr;
            cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
            cell.layer.cornerRadius = 5;
            NSLog(@"cell.dataArray[indexPath.row]===%@",cell.dataArray);
        }
      
        return cell;
    }
    else{
        ThirdTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ThirdTableViewCell"];
        if (cell==nil) {
            cell = [[ThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ThirdTableViewCell"];
            cell.model = self.dataArry[indexPath.row];
            cell.layer.cornerRadius = 5;
        }
        return cell;

    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return screenSize.height/20;
    }
    else if (indexPath.row==1){
        return screenSize.height/5;
    }
    else {
        return screenSize.height/7;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.row==0) {
        return;
        
    }
    else
    {
    CompanyInfo * company = [[CompanyInfo alloc]init];
    workPageModel * model = self.dataArry[indexPath.row];
    company.model = model;
    
    company.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:company animated:YES];
    }
    
}
@end
