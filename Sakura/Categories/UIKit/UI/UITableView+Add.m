//
//  UITableView+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/23.
//  Copyright © 2017年 YaeSakura. All rights reserved.
//

#import "UITableView+Add.h"

@implementation UITableView (Add)

-(UIView *)autolayoutTableViewHeader
{
    return self.tableHeaderView;
}

-(void)setAutolayoutTableViewHeader:(UIView *)autolayoutTableViewHeader
{
    [self autolayoutHeaderFooterView:autolayoutTableViewHeader type:0];
}

-(UIView *)autolayoutTableViewFooter
{
    return self.tableFooterView;
}

-(void)setAutolayoutTableViewFooter:(UIView *)autolayoutTableViewFooter
{
    [self autolayoutHeaderFooterView:autolayoutTableViewFooter type:1];
}

-(void)autolayoutHeaderFooterView:(UIView *)view type:(NSInteger)type /* 0: header, 1: footer */
{
    if (view) {
        [view setNeedsLayout];
        [view layoutIfNeeded];
        
        CGFloat height = [view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect frame = CGRectMake(0, 0, view.bounds.size.width, height);
        view.frame = frame;
        
        if (type == 0) self.tableHeaderView = view;
        else self.tableFooterView = view;
    }
    else {
        if (type == 0) self.tableHeaderView = nil;
        else self.tableFooterView = nil;
    }
}

@end
