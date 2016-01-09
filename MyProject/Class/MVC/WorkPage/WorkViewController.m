//
//  WorkViewController.m
//  MyProject
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "WorkViewController.h"
#import "PersonPageViewController.h"

@interface WorkViewController ()
{
    UIScrollView * _topScrollView;
}

@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTopScrollView];
    [self customNaviBarButton];
    self.view.backgroundColor=[UIColor whiteColor];
     
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatTopScrollView
{
    _topScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, 200)];
    [self.view addSubview:_topScrollView];
    _topScrollView.backgroundColor=[UIColor redColor];
    
    
}

//定制导航栏按钮
-(void)customNaviBarButton
{
    //获取视图控制器的UINavigationItem
    UINavigationItem * naviItem = self.navigationItem;
    //左边按钮
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"top_navigation_menuicon"] style:UIBarButtonItemStylePlain target:self action:@selector(personPage)];
    naviItem.leftBarButtonItem = leftButtonItem;
   
}

-(void)personPage
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonPageViewController * perVC=[sb instantiateViewControllerWithIdentifier:@"PersonPageViewController"];
    [perVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:perVC animated:YES];
}
@end
