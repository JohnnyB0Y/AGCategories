//
//  TestNSDateViewController.m
//  AGCategories
//
//  Created by JohnnyB0Y on 2018/12/24.
//  Copyright © 2018 JohnnyB0Y. All rights reserved.
//

#import "TestNSDateViewController.h"
#import "AGCategories.h"

@interface TestNSDateViewController ()

@end

@implementation TestNSDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     https://www.google.co.jp/search?newwindow=1&source=hp&ei=a_IgXOKuGYyl8AXuk4GYBA&q=北京时间&btnK=Google+搜索&oq=北京时间&gs_l=psy-ab.3..0l10.1829.4108..4378...1.0..1.211.3045.2j17j1....2..0....1..gws-wiz.....0..0i10j0i12.m4c1VuBNDJI
     
     https://www.google.co.jp/search?newwindow=1&biw=1131&bih=1003&ei=A-IgXMD-LMWs8QXKl7fACQ&q=新西兰时间&oq=新西兰sh&gs_l=psy-ab.1.0.0i12l6j0j0i12l2j0.6964.7279..9193...0.0..0.263.497.2-2......0....1..gws-wiz.......0i71j0i67.SBg9mbkf664
     
     https://www.google.co.jp/search?newwindow=1&source=hp&ei=O9cgXJCpPImqoATs-Lm4CA&q=洛杉矶当地时间&btnK=Google+搜索&oq=洛杉矶当地时间&gs_l=psy-ab.3..0.2069.8152..8544...3.0..1.368.2974.22j5j2j1....2..0....1..gws-wiz.....0..0i12j0i13.leeA_ne_3wY
     
     */
    
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *now = [NSDate date];
    
    // 0. 当前北京时间
    NSLog(@"当前北京时间=>：%@", [now ag_stringWithMode:AGDateFormatModeDateAndTime]);
    // 1. 美国洛杉矶时间 比北京慢 16小时
    NSTimeZone *a_tz = [[NSTimeZone alloc] initWithName:@"America/Los_Angeles"];
    NSString *a_ds = [now ag_stringWithModeString:dateFormat timeZone:a_tz];
    NSLog(@"当前洛杉矶时间：%@", a_ds);
    
    
    // 2. 新西兰奥克兰时间 比北京快 5小时
    NSTimeZone *n_tz = [[NSTimeZone alloc] initWithName:@"Pacific/Auckland"];
    NSString *n_ds = [now ag_stringWithModeString:dateFormat timeZone:n_tz];
    NSLog(@"当前新西兰时间：%@", n_ds);
    
    
    // 1545580800 : 2018/12/24 00:00:00
    NSTimeInterval ti = 1545580800.;
    NSNumber *ms = [NSNumber numberWithLongLong:(long long)(ti * 1000)];
    NSNumber *s = [NSNumber numberWithDouble:ti];
    
    NSDate *newDate1 = [NSDate ag_dateWithSecondTi:ti];
    NSDate *newDate2 = [NSDate ag_dateWithSecond:s];
    NSDate *newDate3 = [NSDate ag_dateWithMillisecond:ms];
    
    
    NSLog(@"=============== 获取特定时间戳，转换成其他城市的时间：");
    NSLog(@"北京时间：2018/12/24 00:00:00 ==> 新西兰时间：%@", [newDate1 ag_stringWithModeString:dateFormat timeZoneName:@"Pacific/Auckland"]);
    NSLog(@"北京时间：2018/12/24 00:00:00 ==> 新西兰时间：%@", [newDate2 ag_stringWithModeString:dateFormat timeZone:n_tz]);
    NSLog(@"北京时间：2018/12/24 00:00:00 ==> 新西兰时间：%@", [newDate3 ag_stringWithModeString:dateFormat timeZoneName:n_tz.name]);
    
    // ...
    NSString *newDateStr1 = [NSDate ag_stringWithMillisecond:ms mode:AGDateFormatModeDateAndTime timeZoneName:@"America/Los_Angeles"];
    NSString *newDateStr2 = [NSDate ag_stringWithSecond:s mode:AGDateFormatModeDateAndTime timeZone:a_tz];
    NSString *newDateStr3 = [NSDate ag_stringWithSecondTi:ti mode:AGDateFormatModeDateAndTime timeZoneName:a_tz.name];
    NSLog(@"北京时间：2018/12/24 00:00:00 ==> 洛杉矶时间：%@", newDateStr1);
    NSLog(@"北京时间：2018/12/24 00:00:00 ==> 洛杉矶时间：%@", newDateStr2);
    NSLog(@"北京时间：2018/12/24 00:00:00 ==> 洛杉矶时间：%@", newDateStr3);
    
    
    NSLog(@"=============== 转回当前时间戳NSDate:");
    NSLog(@"当前时间===>Date：%@", now);
    NSLog(@"洛杉矶时间=>Date：%@", [NSDate ag_dateWithFormatString:a_ds modeString:dateFormat timeZone:a_tz]);
    NSLog(@"新西兰时间=>Date：%@", [NSDate ag_dateWithFormatString:n_ds modeString:dateFormat timeZone:n_tz]);
    
    
    NSLog(@"ag_isToday==>%d", [now ag_isToday]);
    NSLog(@"ag_isTomorrow==>%d", [now ag_isTomorrow]);
    NSLog(@"ag_isYesterday==>%d", [now ag_isYesterday]);
    NSLog(@"ag_isBeforeToday==>%d", [now ag_isBeforeToday]);
    NSLog(@"ag_isThisYear==>%d", [now ag_isThisYear]);
    
    NSLog(@"ag_isToday==>%d", [newDate1 ag_isToday]);
    NSLog(@"ag_isTomorrow==>%d", [newDate1 ag_isTomorrow]);
    NSLog(@"ag_isYesterday==>%d", [newDate1 ag_isYesterday]);
    NSLog(@"ag_isBeforeToday==>%d", [newDate1 ag_isBeforeToday]);
    NSLog(@"ag_isThisYear==>%d", [newDate1 ag_isThisYear]);
    
    NSDate *date1 = [NSDate ag_dateWithFormatString:@"2030/11/26 00:00:00" mode:AGDateFormatModeDateAndTime];
    NSDate *date2 = [NSDate ag_dateWithFormatString:@"2018/12/24 10:10:10" mode:AGDateFormatModeDateAndTime];
    NSDateComponents *comp = [date2 ag_componentsToDate:date1];
    NSLog(@"%@", comp);
    NSDate *date3 = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    NSLog(@"%@", [date3 ag_stringWithModeString:@"y-M-d HH:mm:ss"]);
}

+ (instancetype)testNSDateViewController
{
    TestNSDateViewController *vc = [[TestNSDateViewController alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
    return vc;
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
