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
#import "PersonPageViewController.h"
#import "PublicNoticeTableViewController.h"
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
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendTableViewController * fController= [sb instantiateViewControllerWithIdentifier:@"FriendTableViewController"];
    
    WorkViewController * wController=[[WorkViewController alloc]init];
    
    PersonPageViewController * pController = [sb instantiateViewControllerWithIdentifier:@"PersonPageViewController"];
    PublicNoticeTableViewController * publicController = [[PublicNoticeTableViewController alloc]init];
    
    UINavigationController * worknavi=[[UINavigationController alloc]initWithRootViewController:wController];
    UINavigationController * frendnavi=[[UINavigationController alloc]initWithRootViewController:fController];
    UINavigationController * personvi = [[UINavigationController alloc]initWithRootViewController:pController];
    UINavigationController * publicvi = [[UINavigationController alloc]initWithRootViewController:publicController];
    
    //添加对应的子视图
    [self addChildViewController:worknavi];
    [self addChildViewController:frendnavi];
    [self addChildViewController:publicvi];
    [self addChildViewController:personvi];
    //设置子视图的相应属性
    fController.title=@"交友";
    wController.title=@"工作";
    publicController.title = @"公告";
    //定制UITabBarItem
    UITabBarItem * workTabbarItem = [[UITabBarItem alloc]initWithTitle:@"工作" image:[UIImage imageNamed:@"tab_0"] selectedImage:[UIImage imageNamed:@"tab_c0"]];
    wController.tabBarItem = workTabbarItem;
    
    UITabBarItem * friendTabbarItem = [[UITabBarItem alloc]initWithTitle:@"交友" image:[UIImage imageNamed:@"icon_friend"] selectedImage:[UIImage imageNamed:@"icon_friend"]];
    fController.tabBarItem = friendTabbarItem;
    
    UITabBarItem * personTabbarItem = [[UITabBarItem alloc]initWithTitle:@"个人" image:[UIImage imageNamed:@"top_navigation_menuicon"] selectedImage:[UIImage imageNamed:@"top_navigation_menuicon"]];
    pController.tabBarItem = personTabbarItem;
    
    UITabBarItem * publicTabbarItem = [[UITabBarItem alloc]initWithTitle:@"公告" image:[UIImage imageNamed:@"btn_reply"] selectedImage:[UIImage imageNamed:@"btn_reply"]];
    publicController.tabBarItem = publicTabbarItem;
    
//    NSDictionary * wAttribute=@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blueColor]};
//    NSDictionary * fAttribute=@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blueColor]};
//    [wController.tabBarItem setTitleTextAttributes:wAttribute forState:UIControlStateNormal];
//    [fController.tabBarItem setTitleTextAttributes:fAttribute forState:UIControlStateNormal];
}

@end
