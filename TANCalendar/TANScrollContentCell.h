//
//  TANScrollContentCell.h
//  TANCalendar
//
//  Created by merrill on 2017/8/16.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSPageContentView.h"

@interface TANScrollContentCell : UITableViewCell
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) NSString *currentTagStr;

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString*)identifier;


@end
