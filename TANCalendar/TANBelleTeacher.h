//
//  TANBelleTeacher.h
//  TANCalendar
//
//  Created by merrill on 2017/8/17.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TANBelleTeacher : NSObject

@property (nonatomic,   copy) NSString * name;
@property (nonatomic, assign) NSInteger  age;
@property (nonatomic,   copy) NSString * hobby;

- (void)bathe;
- (void)getUndressed;

@end
