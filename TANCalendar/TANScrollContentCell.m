//
//  TANScrollContentCell.m
//  TANCalendar
//
//  Created by merrill on 2017/8/16.
//  Copyright © 2017年 TAN. All rights reserved.
//

#import "TANScrollContentCell.h"
#import "TANScrollContentViewController.h"

@implementation TANScrollContentCell

+(instancetype)cellWithTableView:(UITableView *)tableView reuseIdentifier:(NSString*)identifier{
    
    TANScrollContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCreateConfigView];
        
    }
    return self;
}


- (void)setCreateConfigView
{

}

#pragma mark Setter
- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
}

- (void)setCellCanScroll:(BOOL)cellCanScroll
{
    _cellCanScroll = cellCanScroll;
    
    for (TANScrollContentViewController *VC in _viewControllers) {
        VC.vcCanScroll = cellCanScroll;
        if (!cellCanScroll) {//如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            VC.tableView.contentOffset = CGPointZero;
        }
    }
}

- (void)setIsRefresh:(BOOL)isRefresh
{
    _isRefresh = isRefresh;
    
    for (TANScrollContentViewController *ctrl in self.viewControllers) {
        if ([ctrl.title isEqualToString:self.currentTagStr]) {
            ctrl.isRefresh = isRefresh;
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
