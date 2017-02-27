//
//  PopView.m
//  name
//
//  Created by 百纬健康 on 2017/2/21.
//  Copyright © 2017年 百纬健康. All rights reserved.
//

#import "PopView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PopView ()

@property(nonatomic,strong)UIView *backGView;

@end

@implementation PopView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    
    return self;
}

-(void)initUI
{
    self.frame = [UIScreen mainScreen].bounds;
    self.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.3;
    
}



-(void)popViewShow
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addSubview:self.backGView];
    
    //1.改变大小动画
    //[self addScaleAnimation:self.backGView];
    
    //2.基本动画：按路径移动（默认返回原位置）
    //[self addMoveAnimation:self.backGView];
    
    //3.基本动画：按路径移动（不返回原位置）
    //[self addMoveAnimationTwo:self.backGView];
    
    //4.基本动画：旋转
    //[self addRotationAnimation:self.backGView];
    
    //5.关键帧动画：按方型路径移动
    //[self keyPathAnimation:self.backGView];
    
    //6.关键帧动画：抖动
    [self keyPathRotationAnimation:self.backGView];
    
    [self performSelector:@selector(popViewDisMiss) withObject:nil afterDelay:6.0];
}

-(void)popViewDisMiss
{
    [self removeFromSuperview];
}

//1.关键帧动画：改变大小动画
-(void)addScaleAnimation:(UIView *)animationView
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@0.3,@1.0,@0.7,@1.0];
    animation.duration = 0.6;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [animationView.layer addAnimation:animation forKey:@"frame"];
}

//2.基本动画：按路径移动（默认返回原位置）
-(void)addMoveAnimation:(UIView *)animationView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = @(100);
    animation.toValue = @(-100);
    animation.duration = 2.0;
    [animationView.layer addAnimation:animation forKey:nil];
}

//3.基本动画：按路径移动（不返回原位置）
-(void)addMoveAnimationTwo:(UIView *)animationView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.fromValue = @(100);
    animation.toValue = @(-100);
    animation.duration = 2.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [animationView.layer addAnimation:animation forKey:nil];
}

//4.基本动画：旋转
-(void)addRotationAnimation:(UIView *)animationView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = @(M_PI*2);
    animation.duration = 3.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = CGFLOAT_MAX;
    [animationView.layer addAnimation:animation forKey:nil];
}

//5.关键帧动画：按方型路径移动
-(void)keyPathAnimation:(UIView *)animationView
{
    //设置keyPath 为：position
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //设置5个值
    NSValue * v1 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    NSValue * v2 = [NSValue valueWithCGPoint:CGPointMake(100, 400)];
    NSValue * v3 =[NSValue valueWithCGPoint:CGPointMake(300, 400)];
    NSValue * v4 = [NSValue valueWithCGPoint:CGPointMake(300, 200)];
    NSValue * v5 = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    
    //加入“值”数组
    animation.values=@[v1,v2,v3,v4,v5];
    animation.duration=2;
    animation.repeatCount=CGFLOAT_MAX;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    [animationView.layer addAnimation:animation forKey:nil];
}

//6.关键帧动画：抖动
-(void)keyPathRotationAnimation:(UIView *)animationView
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    NSNumber *n1 = @(-M_PI_4/3);
    NSNumber *n2 = @(M_PI_4/3);
    animation.values = @[n1,n2,n1];
    animation.repeatCount = CGFLOAT_MAX;
    animation.duration = 0.5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [animationView.layer addAnimation:animation forKey:nil];
}


-(UIView *)backGView
{
    if (!_backGView) {
        _backGView = [[UIView alloc] init];
        _backGView.frame = CGRectMake(0, 0, 200, 150);
        _backGView.center = self.center;
        _backGView.backgroundColor = [UIColor whiteColor];
    }
    return _backGView;
}

@end
