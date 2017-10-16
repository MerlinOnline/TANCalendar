//
//  TodayViewController.m
//  TANCalendarToday
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TANDataManager.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10)
    {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    self.preferredContentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 110);
    
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    NSLog(@"maxWidth %f maxHeight %f",maxSize.width,maxSize.height);
    
    if (activeDisplayMode == NCWidgetDisplayModeCompact)
    {
        self.preferredContentSize = CGSizeMake(maxSize.width, 110);
    }
    else
    {
        self.preferredContentSize = CGSizeMake(maxSize.width, 400);
    }
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    [self setUpdateUI];

    completionHandler(NCUpdateResultNewData);
}

- (void)setUpdateUI
{
    NSArray *dataSource = [TANDataManager shareManager].dataSource;
    
    for (int i = 0; i < dataSource.count; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.frame = CGRectMake(30 + i%4*80, 30 + i/4*50, 70, 40);
        itemButton.layer.cornerRadius = 4;
        itemButton.layer.masksToBounds = YES;
        itemButton.backgroundColor = [UIColor redColor];
        itemButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [itemButton setTitle:dataSource[i] forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:itemButton];
    }
}

- (void)itemButtonClick:(id)sender
{
     [self.extensionContext openURL:[NSURL URLWithString:[NSString stringWithFormat:@"TANPrivate0719://action=Event"]] completionHandler:nil];
}

@end
