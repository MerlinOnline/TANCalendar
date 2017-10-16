//
//  TANDataManager.h
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TANDataManager : NSObject

+ (TANDataManager*)shareManager;

@property (nonatomic, strong) NSUserDefaults *userDefalts;
@property (nonatomic,   copy) NSArray * dataSource;

@end
