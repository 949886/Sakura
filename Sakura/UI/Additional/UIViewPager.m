//
//  UIViewPager.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/10.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "UIViewPager.h"
#import "UITabs.h"

@interface UIViewPager () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView * navigationBar;

@end

@implementation UIViewPager

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
        [self initialize];
    return self;
}

- (void)initialize
{
    //navigation
    _navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 64)];
    _navigationBar.backgroundColor = [UIColor whiteColor];
    _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_navigationBar];
    
    //intialize scrollView
    _scrollView = [UIScrollView new];
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
    //UITabs
    _tabs = [[UITabs alloc] initWithType:UITabsTypeCustom];
    _tabs.frame = CGRectMake(0, 20, _navigationBar.bounds.size.width - 16, 36);
    _tabs.items = _tabs.mutableCopy;
    _tabs.color = [UIColor orangeColor];
    _tabs.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    _tabs.layer.cornerRadius = 4;
    _tabs.accessory.backgroundColor = [UIColor whiteColor];
    _tabs.accessory.layer.cornerRadius = 4;
    _tabs.accessoryInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [_navigationBar addSubview:_tabs];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

@end
