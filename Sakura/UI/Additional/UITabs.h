//
//  UITabs.h
//  Sakura
//
//  Created by YaeSakura on 16/7/8.
//  Copyright © 2016 Sakura. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITabsTypes)
{
    UITabsTypeCustom = 0,     //默认为自定义
    UITabsTypeUnderlined      //下划线样式
};

@class UITab;

@interface UITabs : UIView

@property (nonatomic, strong) NSMutableArray * items;
@property (nonatomic, assign) NSInteger index;                      //当前选择的选项卡的序号（从0开始）

@property (nonatomic, strong) UIColor * color;                      //文字和underline的颜色，默认为blue, alpha=0.5
@property (nonatomic, strong) UIColor * selectedColor;
@property (nonatomic, strong) UIFont * font;                        //标题字体，默认为system, 15point
@property (nonatomic, strong) UIFont * selectedFont;

@property (nonatomic, strong, readonly) UIView * background;
@property (nonatomic, strong, readonly) UIScrollView * scrollView;

@property (nonatomic, strong, readonly) UIView * accessory;         //自定义装饰view
@property (nonatomic, assign) UIEdgeInsets accessoryInsets;

@property (nonatomic, assign) BOOL scrollEnabled;                   //默认为NO
@property (nonatomic, assign) CGFloat contentWidth;                 //scrollEnabled为YES时此属性才有用

@property (nonatomic, readonly) NSArray<UITab *>* allTabs;

@property (nonatomic, copy) void(^didClickTab)(NSInteger);      //通过此属性设置回调事件

-(instancetype)initWithType:(UITabsTypes)type;

-(void)handleEventWithBlock:(void(^)(NSInteger))block;              //同didClickSegment

//-(void)addSegment:(NSString *)title event:(void(^)(NSInteger))event;
//-(void)addEvent:(void(^)(NSInteger))event atIndex:(NSInteger)index;

@end


@interface UITab : UIView

@property (nonatomic, copy) NSString * title;
@property (nonatomic, strong) UIColor * titleColor;
@property (nonatomic, strong) UIColor * selectedTitleColor;
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, weak) UITabs * tabs;


//TODO: BELOW

@property (nonatomic, copy) NSString * badge;

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * badgeView;

@end

