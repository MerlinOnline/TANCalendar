//
//  TANScrollContentViewController.h
//  TANCalendar
//
//  Created by merrill on 2017/8/16.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANBaseViewController.h"

@interface TANScrollContentViewController : TANBaseViewController

@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) NSString *str;


@end
