//
//  NSDate+Add.m
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import "NSDate+Add.h"

@import ObjectiveC;

@implementation NSDate (Add)

#pragma mark Getter & Setter

-(NSInteger)year { return [self.calendar component:NSCalendarUnitYear fromDate:self]; }
-(NSInteger)month { return [self.calendar component:NSCalendarUnitMonth fromDate:self]; }
-(NSInteger)day { return [self.calendar component:NSCalendarUnitDay fromDate:self]; }
-(NSInteger)weekday { return [self.calendar component:NSCalendarUnitWeekday fromDate:self]; }
-(NSInteger)hour { return [self.calendar component:NSCalendarUnitHour fromDate:self]; }
-(NSInteger)minute { return [self.calendar component:NSCalendarUnitMinute fromDate:self]; }
-(NSInteger)second { return [self.calendar component:NSCalendarUnitSecond fromDate:self]; }
-(NSInteger)millisecond { return [self.calendar component:NSCalendarUnitNanosecond fromDate:self] / 1000000; }
-(NSInteger)microsecond { return [self.calendar component:NSCalendarUnitNanosecond fromDate:self] / 1000; }
-(NSInteger)nanosecond { return [self.calendar component:NSCalendarUnitNanosecond fromDate:self]; }
-(NSInteger)dayOfYear { return [NSDate format:self format:@"D"].integerValue; }
-(NSInteger)weekOfMonth { return [self.calendar component:NSCalendarUnitWeekOfMonth fromDate:self]; }
-(NSInteger)weekOfYear { return [self.calendar component:NSCalendarUnitWeekOfYear fromDate:self]; }
-(NSInteger)quarter { return [self.calendar component:NSCalendarUnitQuarter fromDate:self]; }

-(NSCalendar *)calendar
{
    NSCalendar * calendar = objc_getAssociatedObject(self, @selector(calendar));
    if (calendar == nil)
        calendar = [NSCalendar currentCalendar];
    self.calendar = calendar;
    return calendar;
}

-(void)setCalendar:(NSCalendar *)calendar
{
    objc_setAssociatedObject(self, @selector(calendar), calendar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Methods

+(NSDate *)parse:(NSString *)date format:(NSString *)format
{
    return [self parse:date format:format locale:@"en_US"];
}

+(NSDate *)parse:(NSString *)date format:(NSString *)format locale: (NSString *)locale
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:locale];
    return [formatter dateFromString:date];
}

+(NSString *)format:(NSDate *)date format:(NSString *)format
{
    return [self format:date format:format locale:@"en_US"];
}

+(NSString *)format:(NSDate *)date format:(NSString *)format locale: (NSString *)locale
{
    NSDateFormatter * formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:locale];
    return [formatter stringFromDate:date];
}

@end
