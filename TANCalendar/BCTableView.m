//
//  BCTableView.m
//  TANCalendar
//
//  Created by merrill on 2017/8/16.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "BCTableView.h"

@implementation BCTableView

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
