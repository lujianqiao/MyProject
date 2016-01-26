//
//  AppDelegate.m
//  MyProject
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 abc. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "UMSocial.h"
#import "NewFeatureImgsViewController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMSocialData setAppKey:@"56a088b567e58e8baa0001d6"];
    [Bmob registerWithAppKey:@"39da7ef344e21bb0b078af2e2aa5db15"];

    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController * root = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    NewFeatureImgsViewController * new = [[NewFeatureImgsViewController alloc]init];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * toWhere = [user objectForKey:@"feature"];
    if ([toWhere isEqualToString:@"feature"]) {
        
        self.window.rootViewController=root;

    }
    else
    {
        self.window.rootViewController = new;
    }
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
