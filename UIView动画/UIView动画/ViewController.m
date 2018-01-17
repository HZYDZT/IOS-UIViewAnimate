//
//  ViewController.m
//  UIView动画
//
//  Created by Godlike on 2018/1/16.
//  Copyright © 2018年 不愿透露姓名的洪先生. All rights reserved.
//

#import "ViewController.h"
#define Controller_Not_Allow_Run 0
#define Controller_Allow_Run 1

@interface ViewController ()
@property (nonatomic, strong) UIView *animateView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.animateView];
#if 0
    /* UIView(UIViewAnimation) */
    [self setAnimateNormal];
#endif
    [self setAnimateWithBlock];
}

- (void)setAnimateWithBlock{
    //block动画 参数: 时间间隔 和 动画回调
#if Controller_Not_Allow_Run
    [UIView animateWithDuration:3.f animations:^{
        self.animateView.frame = CGRectMake(100, 400, 100, 100);
        self.animateView.alpha = 0;
    }];
#endif
    //比上一个方法多一个结束回调
    [UIView animateWithDuration:3.f animations:^{
        self.animateView.frame = CGRectMake(100, 400, 100, 100);
        self.animateView.alpha = 0;
    } completion:^(BOOL finished) {
        self.animateView.alpha = 1;
    }];
    
     // UIViewAnimationOptionLayoutSubviews 子控件随父控件一起动画
     // UIViewAnimationOptionAllowUserInteraction 动画时允许用户触摸操作 允许交互
     // UIViewAnimationOptionBeginFromCurrentState 从当前状态开始动画
     // UIViewAnimationOptionRepeat   一直重复动画
     // UIViewAnimationOptionAutoreverse    动画结束后反向执行动画
     // UIViewAnimationOptionOverrideInheritedDuration
     // UIViewAnimationOptionOverrideInheritedCurve
     // UIViewAnimationOptionAllowAnimatedContent
     // UIViewAnimationOptionShowHideTransitionViews
     // UIViewAnimationOptionOverrideInheritedOptions
     // UIViewAnimationOptionCurveEaseInOut
     // UIViewAnimationOptionCurveEaseIn
     // UIViewAnimationOptionCurveEaseOut
     // UIViewAnimationOptionCurveLinear
     // UIViewAnimationOptionTransitionNone
     // UIViewAnimationOptionTransitionFlipFromLeft
     // UIViewAnimationOptionTransitionFlipFromRight
     // UIViewAnimationOptionTransitionCurlUp
     // UIViewAnimationOptionTransitionCurlDown
     // UIViewAnimationOptionTransitionCrossDissolve
     // UIViewAnimationOptionTransitionFlipFromTop
     // UIViewAnimationOptionTransitionFlipFromBottom
     // UIViewAnimationOptionPreferredFramesPerSecondDefault
     // UIViewAnimationOptionPreferredFramesPerSecond60
     // UIViewAnimationOptionPreferredFramesPerSecond30

    /******************************** block 3 **********************************/
#if Controller_Not_Allow_Run
    //执行动画的block 比较简单的方式
    [UIView animateWithDuration:3.f delay:2.f options:UIViewAnimationOptionAutoreverse animations:^{
        self.animateView.frame = CGRectMake(100, 400, 100, 100);
    } completion:^(BOOL finished) {

    }];
#endif
    
    /******************************** block 4 **********************************/
    //duration: 时间间隔,  delay: 延时执行  Damping: 弹簧效果 0.f-1.f
    // initial: 初始加速度
    //大多数iOS系统动画都是用这种方式 弹性效果
#if Controller_Not_Allow_Run
    [UIView animateWithDuration:0.5f delay:1.f usingSpringWithDamping:0.2 initialSpringVelocity:0.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.animateView.frame = CGRectMake(100, 400, 100, 100);
    } completion:^(BOOL finished) {
        NSLog(@"结束");
    }];
#endif
    
    /******************************** block 5 **********************************/
#if Controller_Not_Allow_Run
    //转场动画 duration: 时间间隔 options: 动画类型 animations: 需要做的动画
    [UIView transitionWithView:self.animateView duration:0.5 options:0 animations:^{
        self.animateView.center = CGPointMake(250, 250);
    } completion:^(BOOL finished) {
        
    }];
#endif

    /******************************** block 6 **********************************/
    //IOS 4出的方法
    //FromView: 从父视图移除, ToView: 添加到父视图, duration: 时间间隔, options: 动画效果
#if Controller_Not_Allow_Run
    UIView *removeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    removeView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:removeView];
    [UIView transitionFromView:removeView toView:self.animateView duration:1.f options:0 completion:^(BOOL finished) {
        NSLog(@"结束");
    }];
#endif
}

- (void)setAnimateNormal{
    //基础方式(比较古老了iOS4 以后用block替代了)
    //开始动画
    //参数  开始动画的标识  和  信息 (可以在动画的代理方法得到)
    [UIView beginAnimations:@"testAnimate" context:@"info"];
    //代理
    [UIView setAnimationDelegate:self];
//    //设置代理后 实现的方法  开始和结束的方法
    [UIView setAnimationDidStopSelector:@selector(AnimateStop:Context:)];
    [UIView setAnimationWillStartSelector:@selector(AnimateStart:Context:)];
    //延时操作 default = 0.0
    [UIView setAnimationDelay:2.0f];
    //动画时间间隔 default = 0.2f
    [UIView setAnimationDuration:3.0f];
    // NSString *time = @"2018-01-16 14:48:50";
    // NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // NSDate *date = [formatter dateFromString:time];
    //默认开始时间是现在
    // [UIView setAnimationStartDate:[NSDate date]];
    
    //曲线动画  a=Δv/Δt 物理中的加速度 使其做非匀速运动
    //UIViewAnimationCurveEaseInOut,  慢进慢出
    //UIViewAnimationCurveEaseIn,     慢进
    //UIViewAnimationCurveEaseOut,    慢出
    //UIViewAnimationCurveLinear,     匀速
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    // 0 , 1 都是一次 long_max = 无穷大
    [UIView setAnimationRepeatCount:LONG_MAX];
    //是否执行相反的动画 default = NO
    [UIView setAnimationRepeatAutoreverses:YES];
    //设置为YES动画从当前状态进行新的动画, NO从结束状态进行新动画
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //UIViewAnimationTransitionNone,  无动画
    //UIViewAnimationTransitionFlipFromLeft, 从左到右翻页
    //UIViewAnimationTransitionFlipFromRight, 从右到左翻页
    //UIViewAnimationTransitionCurlUp, 上到下
    //UIViewAnimationTransitionCurlDown, 下到上
    
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.animateView cache:YES];
    //是否允许动画
    [UIView setAnimationsEnabled:YES];
    
    BOOL enable = [UIView areAnimationsEnabled];
    NSLog(@"%d",enable);
    //继承动画间隔时间 iOS9新出的
    int tim = [UIView inheritedAnimationDuration];
    NSLog(@"%d",tim);
#if UIKIT_DEFINE_AS_PROPERTIES
    //是属性的时候 执行
#else
    //类方法执行
#endif
    //某些地方不需要执行动画可以在这个方法里写 iOS 7 后出的方法
    [UIView performWithoutAnimation:^{
        self.animateView.frame = CGRectMake(200, 400, 100, 100);
    }];
    self.animateView.frame = CGRectMake(100, 400, 100, 100);
    self.animateView.alpha = 0;
    //结束动画
    [UIView commitAnimations];
}

- (void)AnimateStop:(id)obj Context:(id)text{
    NSLog(@"结束:%@,--- %@",obj, text);
}

- (void)AnimateStart:(id)obj Context:(id)text{
    NSLog(@"开始:%@--%@",obj,text);
}

- (UIView *)animateView{
    if(!_animateView) {
        _animateView = [UIView new];
        _animateView.backgroundColor = [UIColor redColor];
        _animateView.frame = CGRectMake(100, 100, 100, 100);
    }
    return _animateView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
