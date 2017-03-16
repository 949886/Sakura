//
//  SegmentedControl.m
//  Sakura
//
//  Created by YaeSakura on 16/7/8.
//  Copyright © 2016 Sakura. All rights reserved.
//

#import "UITabs.h"

#pragma mark - UITab

@implementation UITab

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectZero])
    {
        _titleColor = [UIColor lightGrayColor];
        _selectedTitleColor = [UIColor blackColor];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        _button.userInteractionEnabled = YES;
        _button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_button setTitleColor:_titleColor forState:UIControlStateNormal];
        [_button setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
        [_button addTarget:self action:@selector(buttonClicks:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    [_button setTitle:title forState:UIControlStateNormal];
}

-(void)setSelected:(BOOL)selected
{
    if(selected) {
        [_button setSelected: YES];
        [_button.titleLabel setFont:_tabs.selectedFont];
    }
    else {
        [_button setSelected: NO];
        [_button.titleLabel setFont:_tabs.font];
    }
}

-(void)buttonClicks:(UIButton *)sender
{
    if(nil == self.tabs) return;
    
    self.tabs.index = self.tag;
    
    if(self.tabs.didClickTab)
        self.tabs.didClickTab(self.tag);
}

-(void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [_button setTitleColor:_titleColor forState:UIControlStateSelected];
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    [_button setTitleColor:_selectedTitleColor forState:UIControlStateSelected];
}

@end


/*==========================SegmentedControl==============================*/


#pragma mark - SegmentedControl

@interface UITabs ()

@property (nonatomic, assign) UITabsTypes type;
@property (nonatomic, copy) NSMutableArray<UITab *> * tabs;

@property (nonatomic, assign) NSInteger presentedIndex;

@property (nonatomic, assign) BOOL initialized;

@end

@implementation UITabs

#pragma mark Initialization

-(instancetype)initWithType:(UITabsTypes)type
{
    if (self = [super initWithFrame:CGRectZero])
    {
        _type = type;
        _background = [UIView new];
        _scrollView = [UIScrollView new];
        _scrollView.scrollEnabled = NO;
        
        [self addSubview:_background];
        [self addSubview:_scrollView];
        
        _items = [NSMutableArray new];
        _tabs = [NSMutableArray new];
        [self addObserver:self forKeyPath:@"_items.@count" options:1 context:NULL]; //监听items变化
        
        _color = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        _selectedColor = [UIColor lightGrayColor];
        _font = [UIFont systemFontOfSize:15];
        _selectedFont = [UIFont boldSystemFontOfSize:15];
        
        _accessory = [UIView new];
        [self addSubview:_accessory];
        [self sendSubviewToBack:_accessory];
        
        _accessoryInsets = UIEdgeInsetsZero;
        _presentedIndex = -1;
        
    }
    return self;
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"_items.@count" context:NULL];
}

#pragma mark Override

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //Run as initial
    if (!_initialized) {
        _initialized = YES;
        
        //高亮第初始化默认被选中的
        if(_index < _tabs.count)
            _tabs[_index].selected = YES;
        
        //Set fonts.
        for (int i = 0; i < _tabs.count; ++i) {
            _tabs[i].titleColor = _color;
            _tabs[i].selectedTitleColor = _selectedColor;
            
            if (_tabs[i].selected)
                _tabs[i].button.titleLabel.font = _selectedFont;
            else _tabs[i].button.titleLabel.font = _font;
        }
    }
    
    //Sizing.
    _background.frame = self.bounds;
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = self.bounds.size;
    if(0 == _items.count) return;
    
    //Adjust tabs' frame
    float contentWidth = self.bounds.size.width / _items.count;
    
    for (int i = 0; i < _tabs.count; ++i)
        _tabs[i].frame = CGRectMake(contentWidth * i, 0, contentWidth, self.bounds.size.height);
    
    CGRect rect = CGRectZero;
    
    //Move underline.
    if (_type == UITabsTypeUnderlined)
    {
        _accessory.backgroundColor = _color;
        rect = CGRectMake(contentWidth * _index, self.bounds.size.height - 2, contentWidth, 2);
    }
    if (_type == UITabsTypeCustom)
    {
        rect = CGRectMake(contentWidth * _index + _accessoryInsets.left,
                          _accessoryInsets.top,
                          contentWidth - _accessoryInsets.left - _accessoryInsets.right,
                          self.bounds.size.height - _accessoryInsets.top - _accessoryInsets.bottom);
    }
    
    if(CGRectIsEmpty(_accessory.frame))
        _accessory.frame = rect;
    else
    {
        //监听动画过程
        CADisplayLink * link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        //开始动画
        [UIView animateWithDuration:0.4 animations:^{
            _accessory.frame = rect;
        } completion:^(BOOL finished) {
            //结束监听
            [link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }];
    }
}

#pragma mark Getter & Setter

@synthesize items = _items;

-(void)setIndex:(NSInteger)index
{
    _index = index;
    [self setNeedsLayout];
}

- (NSMutableArray *)items;
{
    return [self mutableArrayValueForKey:@"_items"];
}

-(void)setItems:(NSMutableArray *)items
{
    _items = items;
    [self refreshSegments];
}

-(void)setColor:(UIColor *)color
{
    _color = color;
    
    for (UITab * tab in self.tabs)
        tab.titleColor = color;
}

-(NSArray<UITab *> *)allTabs
{
    return self.tabs.copy;
}

-(void)setAccessoryInsets:(UIEdgeInsets)accessoryInsets
{
    _accessoryInsets = accessoryInsets;
    [self setNeedsLayout];
}

#pragma mark Delegate

/* 监听items的count，若数组被修改则该方法会被回调，并刷新SegmentedControl */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [self refreshSegments];
}

#pragma mark Callback Function

-(void)displayLinkCallback
{
    CALayer * layer = _accessory.layer.presentationLayer;
    float contentWidth = self.bounds.size.width / _items.count;
    int i = (layer.frame.origin.x + contentWidth * 0.5) / contentWidth;

    if(i < _tabs.count && _presentedIndex != i)
    {
        _presentedIndex = i;
        
        for (UITab * tab in _tabs)
            tab.selected = NO;
        _tabs[i].selected = YES;
    }
}

#pragma mark Encapsulation

-(void)refreshSegments
{
    //若items中的元素数小于tabs中的元素数，则移除多余的tab
    if (_tabs.count > _items.count)
        for (int i = (int)_items.count; i < _tabs.count; ++i)
        {
            [_tabs[i] removeFromSuperview];
            [_tabs removeObjectAtIndex:i];
        }
    
    for (int i = 0; i < _items.count; ++i)
    {
        NSString * item = _items[i];
        if (i < _tabs.count)
        {   //若title发生了改变，更改tab的title
            if (_tabs[i].title != item)
                _tabs[i].title = item;
        } //若items中的元素数大于tabs中的元素数，创建新的tab
        else [self createSegment:item atIndex:i];
    }
    
    [self setNeedsLayout];
}

-(void)createSegment:(NSString *)title atIndex:(NSInteger)index
{
    UITab * tab = [UITab new];
    tab.tag = index;
    tab.title = title;
    tab.titleColor = self.color;
    tab.tabs = self;
    [_tabs insertObject:tab atIndex:index];
    [_scrollView addSubview:tab];
}

#pragma mark Methods

-(void)handleEventWithBlock:(void(^)(NSInteger))block;
{
    self.didClickTab = block;
}

@end
