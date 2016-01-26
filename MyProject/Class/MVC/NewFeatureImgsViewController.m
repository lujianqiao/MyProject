//
//  NewFeatureImgsViewController.m
//  MyProject
//
//  Created by 千锋 on 16/1/25.
//  Copyright © 2016年 abc. All rights reserved.
//

#import "NewFeatureImgsViewController.h"
#import "RootViewController.h"
#import "LoginViewController.h"

@interface NewFeatureImgsViewController ()

@end

@implementation NewFeatureImgsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatFeaturePage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatFeaturePage
{
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    for (int index = 1; index<3; index++) {
        UIImageView * imageView= [[UIImageView alloc]initWithFrame:CGRectMake(screenSize.width*(index-1), 0, screenSize.width, screenSize.height)];
        [scrollView addSubview:imageView];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",index]];
        if(index == 2)
        {
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToRootPage)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
        }
    }
    scrollView.contentSize =CGSizeMake(screenSize.width*2, 0);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator= NO;
}
-(void)ToRootPage
{
    //判断是否启动过引导页面
    NSString * feature = @"feature";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:feature forKey:@"feature"];
    
    
    LoginViewController * root = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    UIView * shotView= [self.view snapshotViewAfterScreenUpdates:YES];
    [root.view addSubview:shotView];
    
    self.view.window.rootViewController = root;
    //用动画将截屏图片透明度改为0 最后移除
    [UIView animateWithDuration:2.f animations:^{
        shotView.transform = CGAffineTransformScale(shotView.transform, 1.2, 1.2);
        shotView.alpha = 0;
    } completion:^(BOOL finished) {
        [shotView removeFromSuperview];
    }];

}

@end
