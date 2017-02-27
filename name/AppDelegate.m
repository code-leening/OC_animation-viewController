//
//  AppDelegate.m
//  name
//
//  Created by 百纬健康 on 2017/2/15.
//  Copyright © 2017年 百纬健康. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
//#import <RongIMKit/RongIMKit.h>
#import "YYDTabbarControler.h"
#import "SecondViewController.h"

@interface AppDelegate ()
{
    YYDTabbarControler *_tab;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //动画演示
    //[self animationViewController];
    
    //控制器的切换操作
    [self initTabBarController];
    
    
    return YES;
}


/*
 *1.打开bundle图片
 *2.添加日历时间
 *3.输入框抖动
 *4.各种动画
 */
-(void)animationViewController
{
    ViewController *VC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}



/*
 *控制器的切换
 */
-(void)initTabBarController
{
    _tab = [[YYDTabbarControler alloc] init];
    self.window.rootViewController = _tab;
    [self.window makeKeyAndVisible];
    //模拟演示在tabbar完成之后切换控制器
    [self performSelector:@selector(timeAction) withObject:nil afterDelay:10.0];
}

-(void)timeAction
{
    NSLog(@"-------时间到跳转控制器--------");
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.hidesBottomBarWhenPushed = YES;
    _tab = (YYDTabbarControler *)self.window.rootViewController;
    [_tab.selectedViewController pushViewController:secondVC animated:YES];
    
}

+(AppDelegate *)sharedApplication
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
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
