//
//  RootViewController.m
//  MyProject
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "RootViewController.h"
#import "FriendTableViewController.h"
#import "WorkViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViewController];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addViewController
{
    FriendTableViewController * fController=[[FriendTableViewController alloc]init];
    WorkViewController * wController=[[WorkViewController alloc]init];
    UINavigationController * worknavi=[[UINavigationController alloc]initWithRootViewController:wController];
    UINavigationController * frendnavi=[[UINavigationController alloc]initWithRootViewController:fController];
    //添加对应的子视图
    [self addChildViewController:worknavi];
    [self addChildViewController:frendnavi];
    //设置子视图的相应属性
    fController.title=@"交友";
    wController.title=@"工作";
    //定制UITabBarItem
    UITabBarItem * workTabbarItem = [[UITabBarItem alloc]initWithTitle:@"工作" image:[UIImage imageNamed:@"tab_0"] selectedImage:[UIImage imageNamed:@"tab_c0"]];
    wController.tabBarItem = workTabbarItem;
    
    UITabBarItem * friendTabbarItem = [[UITabBarItem alloc]initWithTitle:@"交友" image:[UIImage imageNamed:@"icon_friend"] selectedImage:[UIImage imageNamed:@"icon_friend"]];
    fController.tabBarItem = friendTabbarItem;
    
//    NSDictionary * wAttribute=@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blueColor]};
//    NSDictionary * fAttribute=@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blueColor]};
//    [wController.tabBarItem setTitleTextAttributes:wAttribute forState:UIControlStateNormal];
//    [fController.tabBarItem setTitleTextAttributes:fAttribute forState:UIControlStateNormal];
}

@end
