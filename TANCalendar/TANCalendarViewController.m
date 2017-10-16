//
//  TANCalendarViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/6/12.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANCalendarViewController.h"


#import "TANLabelViewController.h"
#import "FSCalendar.h"


@interface TANCalendarViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance,UIGestureRecognizerDelegate>

@property (strong, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) UIPanGestureRecognizer *scopeGesture;

@property (strong, nonatomic) NSDictionary *fillSelectionColors;
@property (strong, nonatomic) NSDictionary *fillDefaultColors;
@property (strong, nonatomic) NSDictionary *borderDefaultColors;
@property (strong, nonatomic) NSDictionary *borderSelectionColors;

@property (strong, nonatomic) NSArray *datesWithEvent;
@property (strong, nonatomic) NSArray *datesWithMultipleEvents;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter2;

@end

@implementation TANCalendarViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    [self setDataSource];
}

- (void)setUpUI{
    
    self.title = @"日历页 📅";
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 300)];
    [calendar setCurrentPage:[self.dateFormatter1 dateFromString:@"2015/10/03"] animated:NO];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.firstWeekday = 2;
    calendar.accessibilityIdentifier = @"calendar";
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.calendar action:@selector(handleScopeGesture:)];
    panGesture.delegate = self;
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 2;
    [self.view addGestureRecognizer:panGesture];
    self.scopeGesture = panGesture;
    
}

- (void)setDataSource{
    self.fillDefaultColors = @{@"2015/10/08":[UIColor purpleColor],
                               @"2015/10/06":[UIColor greenColor],
                               @"2015/10/18":[UIColor cyanColor],
                               @"2015/10/22":[UIColor yellowColor],
                               @"2015/11/08":[UIColor purpleColor],
                               @"2015/11/06":[UIColor greenColor],
                               @"2015/11/18":[UIColor cyanColor],
                               @"2015/11/22":[UIColor yellowColor],
                               @"2015/12/08":[UIColor purpleColor],
                               @"2015/12/06":[UIColor greenColor],
                               @"2015/12/18":[UIColor cyanColor],
                               @"2015/12/22":[UIColor magentaColor]};
    
    self.fillSelectionColors = @{@"2015/10/08":[UIColor greenColor],
                                 @"2015/10/06":[UIColor purpleColor],
                                 @"2015/10/17":[UIColor grayColor],
                                 @"2015/10/21":[UIColor cyanColor],
                                 @"2015/11/08":[UIColor greenColor],
                                 @"2015/11/06":[UIColor purpleColor],
                                 @"2015/11/17":[UIColor grayColor],
                                 @"2015/11/21":[UIColor cyanColor],
                                 @"2015/12/08":[UIColor greenColor],
                                 @"2015/12/06":[UIColor purpleColor],
                                 @"2015/12/17":[UIColor grayColor],
                                 @"2015/12/21":[UIColor cyanColor]};
    
    self.borderDefaultColors = @{@"2015/10/08":[UIColor brownColor],
                                 @"2015/10/17":[UIColor magentaColor],
                                 @"2015/10/21":FSCalendarStandardSelectionColor,
                                 @"2015/10/25":[UIColor blackColor],
                                 @"2015/11/08":[UIColor brownColor],
                                 @"2015/11/17":[UIColor magentaColor],
                                 @"2015/11/21":FSCalendarStandardSelectionColor,
                                 @"2015/11/25":[UIColor blackColor],
                                 @"2015/12/08":[UIColor brownColor],
                                 @"2015/12/17":[UIColor magentaColor],
                                 @"2015/12/21":FSCalendarStandardSelectionColor,
                                 @"2015/12/25":[UIColor blackColor]};
    
    self.borderSelectionColors = @{@"2015/10/08":[UIColor redColor],
                                   @"2015/10/17":[UIColor purpleColor],
                                   @"2015/10/21":FSCalendarStandardSelectionColor,
                                   @"2015/10/25":FSCalendarStandardTodayColor,
                                   @"2015/11/08":[UIColor redColor],
                                   @"2015/11/17":[UIColor purpleColor],
                                   @"2015/11/21":FSCalendarStandardSelectionColor,
                                   @"2015/11/25":FSCalendarStandardTodayColor,
                                   @"2015/12/08":[UIColor redColor],
                                   @"2015/12/17":[UIColor purpleColor],
                                   @"2015/12/21":FSCalendarStandardSelectionColor,
                                   @"2015/12/25":FSCalendarStandardTodayColor};
    
    
    self.datesWithEvent = @[@"2015-10-03",
                            @"2015-10-06",
                            @"2015-10-12",
                            @"2015-10-25"];
    
    self.datesWithMultipleEvents = @[@"2015-10-08",
                                     @"2015-10-16",
                                     @"2015-10-20",
                                     @"2015-10-28"];
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    self.dateFormatter1.dateFormat = @"yyyy/MM/dd";
    
    self.dateFormatter2 = [[NSDateFormatter alloc] init];
    self.dateFormatter2.dateFormat = @"yyyy-MM-dd";


}


#pragma mark - <FSCalendarDelegate>

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    //    NSLog(@"%@",(calendar.scope==FSCalendarScopeWeek?@"week":@"month"));
    self.calendar.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(bounds));
    [self.view layoutIfNeeded];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    NSMutableArray *selectedDates = [NSMutableArray arrayWithCapacity:calendar.selectedDates.count];
    [calendar.selectedDates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedDates addObject:[self.dateFormatter stringFromDate:obj]];
    }];
    NSLog(@"selected dates is %@",selectedDates);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%s %@", __FUNCTION__, [self.dateFormatter stringFromDate:calendar.currentPage]);
}


#pragma mark - <FSCalendarDelegateAppearance>

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithEvent containsObject:dateString]) {
        return [UIColor redColor];
    }
    return nil;
}

- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    NSString *dateString = [self.dateFormatter2 stringFromDate:date];
    if ([_datesWithMultipleEvents containsObject:dateString]) {
        return @[[UIColor magentaColor],appearance.eventDefaultColor,[UIColor blackColor]];
    }
    return nil;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_fillSelectionColors.allKeys containsObject:key]) {
        return _fillSelectionColors[key];
    }
    return appearance.selectionColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    return nil;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_borderDefaultColors.allKeys containsObject:key]) {
        return _borderDefaultColors[key];
    }
    return appearance.borderDefaultColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderSelectionColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_borderSelectionColors.allKeys containsObject:key]) {
        return _borderSelectionColors[key];
    }
    return appearance.borderSelectionColor;
}

- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{
    if ([@[@8,@17,@21,@25] containsObject:@([self.gregorian component:NSCalendarUnitDay fromDate:date])]) {
        return 10.0;
    }
    return 1.0;
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
