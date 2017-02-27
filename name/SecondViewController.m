//
//  SecondViewController.m
//  name
//
//  Created by 百纬健康 on 2017/2/21.
//  Copyright © 2017年 百纬健康. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"pushNav";
    [self creatLeftButton];
}

-(void)creatLeftButton
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)leftAction{
    //if (self.navigationController ) {
        [self.navigationController popViewControllerAnimated:YES];
    //}else
    [self dismissViewControllerAnimated:YES completion:nil];
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
