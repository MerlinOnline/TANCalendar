//
//  TANDataManager.m
//  TANCalendar
//
//  Created by merrill on 2017/8/15.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANDataManager.h"

static NSString *filePath = @"group.BCWalkToday";

static NSString *kTANTodayDataTypeDataSourceKey = @"k_TODAY_DATA_TYPE_DATA_SOURCE_KEY";


@interface TANDataManager ()

@end

@implementation TANDataManager

+(TANDataManager *)shareManager{
    static TANDataManager *manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [self new];
    });
    return manager;
}

- (NSUserDefaults *)userDefalts{
    NSUserDefaults * defaults = [[NSUserDefaults alloc]initWithSuiteName:filePath];
    return defaults;
}

- (void)setDataSource:(NSArray *)dataSource
{
    [self.userDefalts setObject:dataSource forKey:kTANTodayDataTypeDataSourceKey];
    [self.userDefalts synchronize];
}

- (NSArray *)dataSource
{
    NSArray *dataSource = [self.userDefalts objectForKey:kTANTodayDataTypeDataSourceKey];
    return dataSource;
}



-(BOOL)saveDataByNSFileManager
{
    NSError *err = nil;
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.com.BCWalkToday"];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/ widget"];
    NSString *value = @"asdfasdfasf";
    BOOL result = [value writeToURL:containerURL atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (!result)
    {
        NSLog(@"%@",err);
    }
    else
    {
        NSLog(@"save value:%@ success.",value);
    }
    return result;
}


@end
