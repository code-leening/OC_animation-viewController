//
//  HomeViewController.m
//  name
//
//  Created by 百纬健康 on 2017/2/21.
//  Copyright © 2017年 百纬健康. All rights reserved.
//

#import "HomeViewController.h"
#import "SecondViewController.h"
#import "AppDelegate.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];

    [self setCustomTitle:@"首页"];
    [self creatRightButton];
    
    [self performSelector:@selector(timeActionTo) withObject:nil afterDelay:10.0];
}

-(void)timeActionTo
{
    [[AppDelegate sharedApplication] timeAction];
}

-(void)setCustomTitle:(NSString *)title
{
    UILabel *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    customLabel.textAlignment = NSTextAlignmentCenter;
    customLabel.textColor = [UIColor whiteColor];
    customLabel.font = [UIFont systemFontOfSize:16];
    customLabel.text = title;
    self.navigationItem.titleView = customLabel;
}

-(void)creatRightButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"push" style:UIBarButtonItemStylePlain target:self action:@selector(pushViewController)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)pushViewController
{
    SecondViewController *VC = [[SecondViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];
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
