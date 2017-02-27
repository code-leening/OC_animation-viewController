//
//  YYDTabbarControler.m
//  name
//
//  Created by 百纬健康 on 2017/2/21.
//  Copyright © 2017年 百纬健康. All rights reserved.
//

#import "YYDTabbarControler.h"
#import "MyViewController.h"
#import "HomeViewController.h"

@interface YYDTabbarControler ()
{
    MyViewController *_myVC;
    HomeViewController *_homeVC;
}

@end

@implementation YYDTabbarControler

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViewControllers];
}

-(void)initViewControllers
{
    _myVC = [[MyViewController alloc] init];
    _myVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[UIImage new] selectedImage:[UIImage new] ];
    UINavigationController *navMyVC = [[UINavigationController alloc] initWithRootViewController:_myVC];
    
    
    _homeVC = [[HomeViewController alloc] init];
    _homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage new] selectedImage:[UIImage new] ];
    UINavigationController *navHomeVC = [[UINavigationController alloc] initWithRootViewController:_homeVC];
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[navHomeVC,navMyVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
