//
//  TANMainViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANMainViewController.h"

#import "TANCalendarViewController.h"
#import "TANLabelViewController.h"
#import "TANSpeechViewController.h"
#import "TANSystemShareViewController.h"
#import "TANWidgetEditViewController.h"
#import "TANTableNestViewController.h"
#import "TANHTMLWebViewController.h"
#import "TANRuntimeViewController.h"

@interface TANMainViewController ()

@end

@implementation TANMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

- (IBAction)calendarButtonClick:(id)sender
{
    TANCalendarViewController *calendarVC = [TANCalendarViewController new];
    [self.navigationController pushViewController:calendarVC animated:YES];
}

- (IBAction)textButtonClick:(id)sender
{
    TANLabelViewController *labelVC = [TANLabelViewController new];
    [self.navigationController pushViewController:labelVC animated:YES];
}

- (IBAction)speechButtonClick:(id)sender
{
    TANSpeechViewController *speechVC = [TANSpeechViewController new];
    [self.navigationController pushViewController:speechVC animated:YES];
}

- (IBAction)systemShareButtonClick:(id)sender
{
    TANSystemShareViewController *systemShareVC = [TANSystemShareViewController new];
    [self.navigationController pushViewController:systemShareVC animated:YES];
}

- (IBAction)widgetInputClick:(id)sender
{
    TANWidgetEditViewController *widgetEditVC = [TANWidgetEditViewController new];
    [self.navigationController pushViewController:widgetEditVC animated:YES];
}

- (IBAction)tableNestButtonClick:(id)sender
{
    TANTableNestViewController *tableNestVC = [TANTableNestViewController new];
    [self.navigationController pushViewController:tableNestVC animated:YES];
}

- (IBAction)webVeiwButtonClick:(id)sender
{
    TANHTMLWebViewController *htmlWebViewVC = [TANHTMLWebViewController new];
    [self.navigationController pushViewController:htmlWebViewVC animated:YES];
}

- (IBAction)runTimeButtonClick:(id)sender
{
    TANRuntimeViewController *runtimeVC = [TANRuntimeViewController new];
    [self.navigationController pushViewController:runtimeVC animated:YES];
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
