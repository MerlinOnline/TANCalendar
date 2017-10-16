//
//  TANSpeechViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANSpeechViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface TANSpeechViewController ()

@property (strong, nonatomic) UIButton *nextButton;
@property (strong, nonatomic) AVSpeechSynthesizer *aVSpeechSynthesizer;

@end

@implementation TANSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"文本朗读";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setCreateNextButton];
    [self setAnimationViewUI];
}

- (void)setCreateNextButton{
    
    UIButton *speechButton = [UIButton buttonWithType:UIButtonTypeCustom];
    speechButton.frame = CGRectMake(30, 100, CGRectGetWidth(self.view.bounds) - 60, 60);
    speechButton.layer.cornerRadius = 4;
    speechButton.layer.masksToBounds = YES;
    speechButton.backgroundColor = [UIColor redColor];
    speechButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [speechButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [speechButton setTitle:@"PLAY" forState:UIControlStateNormal];
    [speechButton addTarget:self action:@selector(speechButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speechButton];
    
}


- (void)speechButtonClick:(id)sender{
    [self readContent:@"你今天走了10248步"];
    [self setUpPushAnimationUI];
}

- (void)readContent:(NSString*)str{    //AVSpeechUtterance: 可以假想成要说的一段话
    
    self.aVSpeechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    
    AVSpeechUtterance * aVSpeechUtterance = [[AVSpeechUtterance alloc] initWithString:str];
    
    aVSpeechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate;    //AVSpeechSynthesisVoice: 可以假想成人的声音
    aVSpeechUtterance.voice =[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];    //发音 zh-CN en-US
    //设置语速
    aVSpeechUtterance.rate *= 0.5;
    //设置音量
    aVSpeechUtterance.volume = 0.6;
    [self.aVSpeechSynthesizer speakUtterance:aVSpeechUtterance];
    
}



- (void)setAnimationViewUI
{

    UIView *animationView = [UIView new];
    animationView.frame = CGRectMake(20, 84, 60, 60);
    animationView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    animationView.layer.cornerRadius = 4;
    animationView.layer.masksToBounds = YES;
    animationView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:animationView];
    
//    [self setBreatheAnimationUI:animationView];
//    [self setSharkAnimationUI:animationView];
//    [self setUpCAKeyframeAnimationUseValues:animationView];
//    [self setUpCAKeyframeAnimationUsePath:animationView];
//    [self setUpCAKeyframeAnimationUsekeyTimes:animationView];
    [self setUpAnimationGroup:animationView];
    
}

// 呼吸动画
- (void)setBreatheAnimationUI:(UIView*)view
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;    //回退动画（动画可逆，即循环）
    animation.duration = 1.0f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [view.layer addAnimation:animation forKey:@"aAlpha"];
}

// 摇摆动画
- (void)setSharkAnimationUI:(UIView*)view
{
    //设置旋转原点
    view.layer.anchorPoint = CGPointMake(0.5, 0);
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //角度转弧度（这里用1，-1简单处理一下）
    rotationAnimation.toValue = [NSNumber numberWithFloat:0.5];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:-0.5];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
}

// 平移动画
-(void)setUpCAKeyframeAnimationUseValues:(UIView*)view
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth - 50, 100)];
    
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth - 50, kScreenHeight - 100)];
    
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(50, kScreenHeight - 100)];
    
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(50, 100)];
    
    animation.values = @[value1,value2,value3,value4,value5];
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 6.0f;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:animation forKey:@"values"];
    
}

-(void)setUpCAKeyframeAnimationUsePath:(UIView*)view
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //矩形线路
    CGPathAddRect(path, NULL, CGRectMake(50,50, kScreenWidth - 100, kScreenHeight - 100));
    
    animation.path=path;
    
    CGPathRelease(path);
    
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 10.0f;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [view.layer addAnimation:animation forKey:@"path"];
}

-(void)setUpCAKeyframeAnimationUsekeyTimes:(UIView*)view
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position.x";
    animation.values = @[@0, @20, @-20, @20, @0];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.5;
    animation.additive = YES;
    animation.repeatCount = MAXFLOAT;
    [view.layer addAnimation:animation forKey:@"keyTimes"];
    
}

- (void)setUpAnimationGroup:(UIView*)view
{
    CABasicAnimation * animationScale = [CABasicAnimation animation];
    animationScale.keyPath = @"transform.scale";
    animationScale.toValue = @(0.1);
    
    CABasicAnimation *animationRota = [CABasicAnimation animation];
    animationRota.keyPath = @"transform.rotation";
    animationRota.toValue = @(M_PI_2);
    
    CAAnimationGroup * group = [[CAAnimationGroup alloc] init];
    group.duration = 3.0;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.repeatCount = MAXFLOAT;
    
    group.animations = @[animationScale,animationRota];
    [view.layer addAnimation:group forKey:nil];
}

- (void)setUpPushAnimationUI
{
    TANSpeechViewController *speechViewC = [TANSpeechViewController new];
    CATransition *animation = [CATransition animation];
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"push"; // fade   moveIn  push reveal cube  suck oglFlip ripple Curl UnCurl caOpen caClose
    animation.duration =0.5f;
    animation.subtype =kCATransitionFromRight;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    [self presentViewController:speechViewC animated:NO completion:nil];
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
