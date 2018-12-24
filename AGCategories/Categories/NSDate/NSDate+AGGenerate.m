//
//  NSDate+AGGenerate.m
//
//
//  Created by JohnnyB0Y on 15/10/3.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//

#import "NSDate+AGGenerate.h"

@implementation NSDate (AGGenerate)

#pragma mark - 判断
- (NSDateComponents *) ag_componentsToDate:(NSDate *)date calendarIdentifier:(NSCalendarIdentifier)identifier
{
    NSCalendar *calendar;
    if ( identifier ) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:identifier];
    }
    return [self ag_componentsToDate:date calendar:calendar];
}
- (NSDateComponents *) ag_componentsToDate:(NSDate *)date calendar:(NSCalendar *)calendar
{
    calendar = calendar ?: [NSCalendar currentCalendar];
    // 想比较哪些元素
    NSCalendarUnit unitFlags
    = NSCalendarUnitYear| NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitHour| NSCalendarUnitMinute| NSCalendarUnitSecond;
    return [calendar components:unitFlags fromDate:self toDate:date options:0];
}
- (NSDateComponents *) ag_componentsToDate:(NSDate *)date
{
    return [self ag_componentsToDate:date calendar:nil];
}

- (BOOL) ag_isToday
{
    NSDateComponents *components = [self ag_componentsToDate:[NSDate date]];
    return 0 == components.day && 0 == components.month && 0 == components.year;
}
- (BOOL) ag_isTomorrow
{
    // -2 > -3 以外
    // -2 < -1 以内
    NSDateComponents *components = [self ag_componentsToDate:[NSDate date]];
    return -1 == components.day && 0 == components.month && 0 == components.year;
}
- (BOOL) ag_isYesterday
{
    // 2 < 3 以外
    // 2 > 1 以内
    NSDateComponents *components = [self ag_componentsToDate:[NSDate date]];
    return 1 == components.day && 0 == components.month && 0 == components.year;
}
- (BOOL) ag_isBeforeToday
{
    NSDateComponents *components = [self ag_componentsToDate:[NSDate date]];
    return 0 < components.day && 0 == components.month && 0 == components.year;
}
- (BOOL) ag_isThisYear
{
    NSDateComponents *components = [self ag_componentsToDate:[NSDate date]];
    return 0 == components.year;
}

// .............
+ (NSString *) ag_stringWithDateUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier
{
    return [[NSDate date] ag_stringWithUnit:unitFlags calendarIdentifier:identifier];
}
+ (NSString *) ag_stringWithDateUnit:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar
{
    return [[NSDate date] ag_stringWithUnit:unitFlags calendar:calendar];
}
+ (NSString *) ag_stringWithDateUnit:(NSCalendarUnit)unitFlags
{
    return [[NSDate date] ag_stringWithUnit:unitFlags];
}

- (NSString *) ag_stringWithUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier
{
    return @([self ag_integerWithUnit:unitFlags calendarIdentifier:identifier]).stringValue;
}
- (NSString *) ag_stringWithUnit:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar
{
    return @([self ag_integerWithUnit:unitFlags calendar:calendar]).stringValue;
}
- (NSString *) ag_stringWithUnit:(NSCalendarUnit)unitFlags
{
    return @([self ag_integerWithUnit:unitFlags]).stringValue;
}

#pragma mark 根据 NSCalendarUnit 枚举，获取（年、月、日、时、分、秒）数值 NSInteger
+ (NSInteger) ag_integerWithDateUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier
{
    return [[NSDate date] ag_integerWithUnit:unitFlags calendarIdentifier:identifier];
}
+ (NSInteger) ag_integerWithDateUnit:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar
{
    return [[NSDate date] ag_integerWithUnit:unitFlags calendar:calendar];
}
+ (NSInteger) ag_integerWithDateUnit:(NSCalendarUnit)unitFlags
{
    return [[NSDate date] ag_integerWithUnit:unitFlags];
}

- (NSInteger) ag_integerWithUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier
{
    NSCalendar *calendar;
    if ( identifier ) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:identifier];
    }
    return [self ag_integerWithUnit:unitFlags calendar:calendar];
}
- (NSInteger) ag_integerWithUnit:(NSCalendarUnit)unitFlags calendar:(NSCalendar *)calendar
{
    calendar = calendar ?: [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self];
    return [dateComponent valueForComponent:unitFlags];
}
- (NSInteger) ag_integerWithUnit:(NSCalendarUnit)unitFlags
{
    return [self ag_integerWithUnit:unitFlags calendar:nil];
}

#pragma mark - ----------- Private Methods ---------
+ (BOOL) _isValid:(id)value
{
    BOOL isOK = YES;
    if ( ![value isKindOfClass:[NSNumber class]] && ![value isKindOfClass:[NSString class]] ) {
        isOK = NO;
    }

    return isOK;
}

#pragma mark generate new date instance
+ (NSDate *) ag_dateWithMillisecond:(id)ms
{
    NSTimeInterval second = [ms longLongValue] * 0.001;
    return [self ag_dateWithSecondTi:second];
}

+ (NSDate *) ag_dateWithSecondTi:(NSTimeInterval)ti
{
    return [NSDate dateWithTimeIntervalSince1970:ti];
}

+ (NSDate *) ag_dateWithSecond:(id)s
{
    return [self ag_dateWithSecondTi:(NSTimeInterval)[s longLongValue]];
}

+ (NSDate *) ag_dateWithFormatString:(NSString *)format mode:(AGDateFormatMode)formatMode timeZoneName:(NSString *)name
{
    return [self ag_dateWithFormatString:format modeString:[self ag_modeStringWithMode:formatMode] timeZoneName:name];
}
+ (NSDate *) ag_dateWithFormatString:(NSString *)format mode:(AGDateFormatMode)formatMode timeZone:(NSTimeZone *)timeZone
{
    return [self ag_dateWithFormatString:format modeString:[self ag_modeStringWithMode:formatMode] timeZone:timeZone];
}
+ (NSDate *) ag_dateWithFormatString:(NSString *)format mode:(AGDateFormatMode)formatMode
{
    return [self ag_dateWithFormatString:format modeString:[self ag_modeStringWithMode:formatMode]];
}

+ (NSDate *) ag_dateWithFormatString:(NSString *)format modeString:(NSString *)formatMode timeZoneName:(NSString *)name
{
    NSTimeZone *tz;
    if ( name ) {
        tz = [[NSTimeZone alloc] initWithName:name];
    }
    return [self ag_dateWithFormatString:format modeString:formatMode timeZone:tz];
}
+ (NSDate *) ag_dateWithFormatString:(NSString *)format modeString:(NSString *)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ( timeZone ) {
        [formatter setTimeZone:timeZone];
    }
    [formatter setDateFormat:formatMode];
    return [formatter dateFromString:format];
}
+ (NSDate *) ag_dateWithFormatString:(NSString *)format modeString:(NSString *)formatMode
{
    return [self ag_dateWithFormatString:format modeString:formatMode timeZone:nil];
}


+ (NSString *) ag_modeStringWithMode:(AGDateFormatMode)formatMode
{
    switch (formatMode) {
        case AGDateFormatModeOnlyDate: {
            return @"yyyy-MM-dd";
        } break;
            
        case AGDateFormatModeOnlyTime: {
            return @"HH:mm:ss";
        } break;
            
        default: {
            return @"yyyy-MM-dd HH:mm:ss";
        } break;
    }
}

#pragma mark - NSDate => NSString
- (NSString *) ag_stringWithMode:(AGDateFormatMode)formatMode timeZoneName:(NSString *)name
{
    return [self ag_stringWithModeString:[NSDate ag_modeStringWithMode:formatMode] timeZoneName:name];
}
- (NSString *) ag_stringWithMode:(AGDateFormatMode)formatMode timeZone:(NSTimeZone *)timeZone
{
    return [self ag_stringWithModeString:[NSDate ag_modeStringWithMode:formatMode] timeZone:timeZone];
}
- (NSString *) ag_stringWithMode:(AGDateFormatMode)formatMode
{
    return [self ag_stringWithModeString:[NSDate ag_modeStringWithMode:formatMode]];
}

- (NSString *) ag_stringWithModeString:(NSString *)formatMode timeZoneName:(NSString *)name
{
    NSTimeZone *tz;
    if ( name ) {
        tz = [[NSTimeZone alloc] initWithName:name];
    }
    return [self ag_stringWithModeString:formatMode timeZone:tz];
}
- (NSString *) ag_stringWithModeString:(NSString *)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ( timeZone ) {
        [formatter setTimeZone:timeZone];
    }
    [formatter setDateFormat:formatMode];
    return [formatter stringFromDate:self];
}
- (NSString *) ag_stringWithModeString:(NSString *)formatMode
{
    return [self ag_stringWithModeString:formatMode timeZone:nil];
}

// ............
+ (NSString *) ag_stringWithMillisecond:(id)ms mode:(AGDateFormatMode)formatMode timeZoneName:(NSString *)name
{
    NSDate *date = [self ag_dateWithMillisecond:ms];
    return [date ag_stringWithMode:formatMode timeZoneName:name];
}
+ (NSString *) ag_stringWithMillisecond:(id)ms mode:(AGDateFormatMode)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDate *date = [self ag_dateWithMillisecond:ms];
    return [date ag_stringWithMode:formatMode timeZone:timeZone];
}
+ (NSString *) ag_stringWithMillisecond:(id)ms mode:(AGDateFormatMode)formatMode
{
    NSDate *date = [self ag_dateWithMillisecond:ms];
    return [date ag_stringWithMode:formatMode];
}

+ (NSString *) ag_stringWithMillisecond:(id)ms modeString:(NSString *)formatMode timeZoneName:(NSString *)name
{
    NSDate *date = [self ag_dateWithMillisecond:ms];
    return [date ag_stringWithModeString:formatMode timeZoneName:name];
}
+ (NSString *) ag_stringWithMillisecond:(id)ms modeString:(NSString *)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDate *date = [self ag_dateWithMillisecond:ms];
    return [date ag_stringWithModeString:formatMode timeZone:timeZone];
}
+ (NSString *) ag_stringWithMillisecond:(id)ms modeString:(NSString *)formatMode
{
    NSDate *date = [self ag_dateWithMillisecond:ms];
    return [date ag_stringWithModeString:formatMode];
}

+ (NSString *) ag_stringWithSecond:(id)s mode:(AGDateFormatMode)formatMode timeZoneName:(NSString *)name
{
    NSDate *date = [self ag_dateWithSecond:s];
    return [date ag_stringWithMode:formatMode timeZoneName:name];
}
+ (NSString *) ag_stringWithSecond:(id)s mode:(AGDateFormatMode)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDate *date = [self ag_dateWithSecond:s];
    return [date ag_stringWithMode:formatMode timeZone:timeZone];
}
+ (NSString *) ag_stringWithSecond:(id)s mode:(AGDateFormatMode)formatMode
{
    NSDate *date = [self ag_dateWithSecond:s];
    return [date ag_stringWithMode:formatMode];
}

+ (NSString *) ag_stringWithSecond:(id)s modeString:(NSString *)formatMode timeZoneName:(NSString *)name
{
    NSDate *date = [self ag_dateWithSecond:s];
    return [date ag_stringWithModeString:formatMode timeZoneName:name];
}
+ (NSString *) ag_stringWithSecond:(id)s modeString:(NSString *)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDate *date = [self ag_dateWithSecond:s];
    return [date ag_stringWithModeString:formatMode timeZone:timeZone];
}
+ (NSString *) ag_stringWithSecond:(id)s modeString:(NSString *)formatMode
{
    NSDate *date = [self ag_dateWithSecond:s];
    return [date ag_stringWithModeString:formatMode];
}

+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti mode:(AGDateFormatMode)formatMode timeZoneName:(NSString *)name
{
    NSDate *date = [self ag_dateWithSecondTi:ti];
    return [date ag_stringWithMode:formatMode timeZoneName:name];
}
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti mode:(AGDateFormatMode)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDate *date = [self ag_dateWithSecondTi:ti];
    return [date ag_stringWithMode:formatMode timeZone:timeZone];
}
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti mode:(AGDateFormatMode)formatMode
{
    NSDate *date = [self ag_dateWithSecondTi:ti];
    return [date ag_stringWithMode:formatMode];
}

+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti modeString:(NSString *)formatMode timeZoneName:(NSString *)name
{
    NSDate *date = [self ag_dateWithSecondTi:ti];
    return [date ag_stringWithModeString:formatMode timeZoneName:name];
}
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti modeString:(NSString *)formatMode timeZone:(NSTimeZone *)timeZone
{
    NSDate *date = [self ag_dateWithSecondTi:ti];
    return [date ag_stringWithModeString:formatMode timeZone:timeZone];
}
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti modeString:(NSString *)formatMode
{
    NSDate *date = [self ag_dateWithSecondTi:ti];
    return [date ag_stringWithModeString:formatMode];
}

@end
