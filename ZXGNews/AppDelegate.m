//
//  AppDelegate.m
//  ZXGNews
//
//  Created by xiaogang.zhang on 2017/11/30.
//  Copyright © 2017年 Raiing Medical. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "FriendTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    
    UITabBarController *tabbarController = [[UITabBarController alloc]init];
    [self setupTabbarControllec:tabbarController];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)setupTabbarControllec:(UITabBarController *)tabbarController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"news"];
    FriendTableViewController *friendVC = [storyBoard instantiateViewControllerWithIdentifier:@"friend"];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    UINavigationController *friendNav = [[UINavigationController alloc]initWithRootViewController:friendVC];
    tabbarController.viewControllers = @[friendNav,homeNav];
    friendNav.tabBarItem.title  = @"朋友圈";
    UIImage *image1 = [UIImage imageNamed:@"tabBar_home_click"];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image2 = [UIImage imageNamed:@"tabBar_me_click"];
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.title  = @"新闻频道";
    friendNav.tabBarItem.image = image2;
    homeNav.tabBarItem.image = image1;
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [homeNav.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [friendNav.tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor purpleColor];
    [homeNav.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [friendNav.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
