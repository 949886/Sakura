//
//  NSDate+Add.h
//  Sakura
//
//  Created by YaeSakura on 2017/2/15.
//  Copyright © 2017 Sakura. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SEC_PER_MIN 60.0
#define SEC_PER_HOUR 3600.0
#define SEC_PER_DAY 86400.0
#define SEC_PER_WEEK 604800.0

@interface NSDate (Add)

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger millisecond;
@property (nonatomic, readonly) NSInteger microsecond;
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger dayOfYear;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger quarter;

@property (nonatomic, strong) NSCalendar * calendar;

//About format you can refer to:
//http://userguide.icu-project.org/formatparse/datetime

+(NSDate *)parse:(NSString *)date format:(NSString *)format;
+(NSDate *)parse:(NSString *)date format:(NSString *)format locale: (NSString *)locale;
+(NSString *)format:(NSDate *)date format:(NSString *)format;
+(NSString *)format:(NSDate *)date format:(NSString *)format locale: (NSString *)locale;

@end
