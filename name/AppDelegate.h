//
//  AppDelegate.h
//  name
//
//  Created by 百纬健康 on 2017/2/15.
//  Copyright © 2017年 百纬健康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate *)sharedApplication;

-(void)timeAction;


@end

