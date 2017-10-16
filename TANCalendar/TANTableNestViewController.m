//
//  TANTableNestViewController.m
//  TANCalendar
//
//  Created by merrill on 2017/8/16.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANTableNestViewController.h"

#import "BCTableView.h"
#import "FSScrollContentView.h"
#import "TANScrollContentCell.h"
#import "TANScrollContentViewController.h"
#import "TANChallengeDetailViewController.h"
#import "TANChallengeRankListViewController.h"

static NSString * cellIdentifier = @"contentCellIdentifier";

@interface TANTableNestViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) BCTableView *tableView;
@property (nonatomic, strong) UIView * tableHeaderView;
@property (nonatomic, strong) TANScrollContentCell *contentCell;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@property (nonatomic, assign) BOOL canScroll;

@end

@implementation TANTableNestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"table 嵌套";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"leaveTop" object:nil];
    
    BCTableView *tableView = [[BCTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = kScreenHeight - 114*kScreenScale;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerClass:[TANScrollContentCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 间距约束（添加到self.view身上）
    CGFloat margin = 0;
    [self.view addConstraints:@[
                                // 左边
                                [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin],
                                
                                // 右边
                                [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant: - margin],
                                
                                // 顶部
                                [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant: - margin],
                                
                                // 底部
                                [NSLayoutConstraint constraintWithItem:tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant: - margin]
                                ]
     ];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    tableHeaderView.backgroundColor = [UIColor purpleColor];
    self.tableHeaderView = tableHeaderView;
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.canScroll = YES;
}

#pragma mark notify
- (void)changeScrollStatus//改变主视图的状态
{
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}

#pragma mark UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bottomCellOffset = [self.tableView rectForSection:1].origin.y - 64;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.tableView.showsVerticalScrollIndicator = self.canScroll?YES:NO;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    _contentCell = [TANScrollContentCell cellWithTableView:tableView reuseIdentifier:cellIdentifier];
   NSMutableArray *viewControllers = [self viewControllers];
    _contentCell.viewControllers = viewControllers;
    _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50) childVCs:viewControllers parentVC:self delegate:self];
    [_contentCell.contentView addSubview:_contentCell.pageContentView];
    return _contentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.001f;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50)
                                                       titles:[self titles]
                                                     delegate:self
                                                indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = RGBA_HEX(0xF6F6F6, 1.0);
    return self.titleView;
}

- (NSArray*)titles
{
    return @[@"详情",@"排行",@"动态"];
}

- (NSMutableArray*)viewControllers
{
    NSArray *titles = [self titles];
    NSMutableArray *contentVCs = [NSMutableArray array];
    for (NSString *title in titles) {
        if ([title isEqualToString:@"详情"]) {
            TANChallengeDetailViewController *vc = [[TANChallengeDetailViewController alloc]init];
            vc.title = title;
            vc.str = title;
            [contentVCs addObject:vc];
        }else if ([title isEqualToString:@"排行"]){
            TANChallengeRankListViewController *vc = [[TANChallengeRankListViewController alloc]init];
            vc.title = title;
            vc.str = title;
            [contentVCs addObject:vc];
        } else{
            TANScrollContentViewController *vc = [[TANScrollContentViewController alloc]init];
            vc.title = title;
            vc.str = title;
            [contentVCs addObject:vc];
        }
    }
    
    return contentVCs;
}

#pragma mark FSSegmentTitleViewDelegate

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
    _tableView.scrollEnabled = YES;//此处其实是监测scrollview滚动，pageView滚动结束主tableview可以滑动，或者通过手势监听或者kvo，这里只是提供一种实现方式
}

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.contentCell.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress
{
    _tableView.scrollEnabled = NO;//pageView开始滚动主tableview禁止滑动
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{

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
