//
//  TANSystemShareViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANSystemShareViewController.h"

@interface TANSystemShareViewController ()

@end

@implementation TANSystemShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"系统分享";
    [self setCreateNextButton];
}

- (void)setCreateNextButton{
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(30, CGRectGetHeight(self.view.bounds) - 100, CGRectGetWidth(self.view.bounds) - 60, 60);
    shareButton.layer.cornerRadius = 4;
    shareButton.layer.masksToBounds = YES;
    shareButton.backgroundColor = [UIColor redColor];
    shareButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareButton setTitle:@"SHARE" forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    
    UIButton *gradeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gradeButton.frame = CGRectMake(30, CGRectGetMinY(shareButton.frame) - 100, CGRectGetWidth(self.view.bounds) - 60, 60);
    gradeButton.layer.cornerRadius = 4;
    gradeButton.layer.masksToBounds = YES;
    gradeButton.backgroundColor = [UIColor redColor];
    gradeButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [gradeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gradeButton setTitle:@"App Store 评分" forState:UIControlStateNormal];
    [gradeButton addTarget:self action:@selector(gradeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gradeButton];
}

- (void)shareButtonClick:(id)sender
{
    NSArray *images = @[@"fd2aa8bbef714343abd0b5a9259a0e02.jpg"];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
    
}

- (void)gradeButtonClick:(id)sender
{
    [self loadAppStoreController];
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
