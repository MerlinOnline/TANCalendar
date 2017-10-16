//
//  TANBelleTeacher+Category.m
//  TANCalendar
//
//  Created by merrill on 2017/8/17.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANBelleTeacher+Category.h"

#import <objc/runtime.h>

@implementation TANBelleTeacher (Category)

const char boy_friend;

- (void)setBoyFriend:(NSString *)boyFriend
{
    objc_setAssociatedObject(self, &boy_friend, boyFriend, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)boyFriend {
    return  objc_getAssociatedObject(self, &boy_friend);
}

@end
