//
//  ViewController.m
//  name
//
//  Created by 百纬健康 on 2017/2/15.
//  Copyright © 2017年 百纬健康. All rights reserved.
//

#import "ViewController.h"
#import <EventKit/EventKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#include "PopView.h"
#import "SecondViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePickerController;
    PopView *popView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /*
     *1.打开bundle图片
     *2.添加日历时间
     *3.输入框抖动
     *4.各种动画
     *5.控制器的切换
     */
    //[self getBundleSouce];//打开bundle图片
    //[self calance];//添加日历时间
    //[self addVideo];
    
    //[self animationTextField];//输入框抖动
    [self addPopView];//各种动画
    //[self creatRightButton];
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




-(void)addPopView
{
    popView = [[PopView alloc] init];
    [popView popViewShow];
}


/*
 *密码错误抖动
 */
-(void)animationTextField
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(100, 100, 200, 30);
    textField.placeholder = @"请输入密码";
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:textField];
    
    [self performSelector:@selector(shakeAnimationForView:) withObject:textField afterDelay:3.0];
    //[self shakeAnimationForView:textField];
    
}
#pragma mark 抖动动画
- (void)shakeAnimationForView:(UIView *) view
{
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 5, position.y);
    CGPoint y = CGPointMake(position.x - 5, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
    
}




/*
 *打开相册
 */
-(void)addVideo
{
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];

}

//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
}



/*
 *打开日历编写
 */
-(void)calance
{
    /*
     **********日历时间编写**********
     如果要选择特定的某一天的话（默认是当前日期），calshow:后面加时间戳格式，也就是NSTimeInterval
     注意这里计算时间戳调用的方法是-NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSinceReferenceDate];
     timeIntervalSinceReferenceDate的参考时间是2000年1月1日，[NSDate date]是你希望跳到的日期。
     */
    NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSinceReferenceDate];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"calshow:%f",nowTimestamp]] options:@{@"":@""} completionHandler:^(BOOL success) {
        
    }];
    [self addAction];
}

-(void)addAction
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    //错误细心
                }else if (!granted){
                    //被用户拒绝，不允许访问日历
                }else{
                    //事件保存到日历
                    //创建事件
                    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                    event.title = @"周杰伦演唱会";
                    event.location = @"上海陆家嘴";
                    
                    NSDateFormatter *formeatter = [[NSDateFormatter alloc] init];
                    [formeatter setDateFormat:@"yyyy.MM.dd H:mm"];
                    
                    
                    event.startDate = [[NSDate alloc]init ];
                    event.endDate   = [[NSDate alloc]init ];
                    event.allDay = YES;
                    
                    //添加提醒
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -60.0f * 24]];
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
                    
                    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"创建日历"
                                          message:@"是!?"
                                          delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
                    [alert show];
                    
                    NSLog(@"保存成功");
                }
            });
        }];
        
    }
}




/*
 *打开bundle图片
 */
-(void)getBundleSouce
{
    NSString *path = [[[NSBundle mainBundle] pathForResource:@"photoBundle" ofType:@"bundle"] stringByAppendingPathComponent:@"images"];
    NSArray *pngs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSLog(@"无排序：%@",pngs);
    // 排序
    NSArray *arr = [pngs sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSNumber *num1 = [NSNumber numberWithInt:[obj1 substringWithRange:NSMakeRange(0,obj1.length-4)].intValue];
        NSNumber *num2 = [NSNumber numberWithInt:[obj2 substringWithRange:NSMakeRange(0,obj2.length-4)].intValue];
        NSComparisonResult result = [num1 compare:num2];
        return result == NSOrderedDescending;
    }];
    
    NSLog(@"排序后：%@",arr);
    
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        [mutableArr addObject:[UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:arr[i]]]];
    }
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = [UIScreen mainScreen].bounds;
    imageV.animationImages = mutableArr;
    imageV.animationDuration = 5.0;
    imageV.animationRepeatCount = 0;
    [self.view addSubview:imageV];
    [imageV startAnimating];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
