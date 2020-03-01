//
//  NSDate+Extension.h

#import <Foundation/Foundation.h>
#import "NSDateFormatter+Extension.h"

#define MH_D_MINUTE	    60
#define MH_D_HOUR		3600
#define MH_D_DAY		86400
#define MH_D_WEEK		604800
#define MH_D_YEAR		31556926


@interface NSDate (Extension)
/**
 *  是否为今天
 */
- (BOOL)zbn_isToday;
/**
 *  是否为昨天
 */
- (BOOL)zbn_isYesterday;
/**
 *  是否为今年
 */
- (BOOL)zbn_isThisYear;
/**
 *  是否本周
 */
- (BOOL) zbn_isThisWeek;

/**
 *  星期几
 */
- (NSString *)zbn_weekDay;

/**
 *  是否为在相同的周
 */
- (BOOL) zbn_isSameWeekWithAnotherDate: (NSDate *)anotherDate;


/**
 *  通过一个时间 固定的时间字符串 "2016/8/10 14:43:45" 返回时间
 *  @param timestamp 固定的时间字符串 "2016/8/10 14:43:45"
 */
+ (instancetype)zbn_dateWithTimestamp:(NSString *)timestamp;

/**
 *  返回固定的 当前时间 2016-8-10 14:43:45
 */
+ (NSString *)zbn_currentTimestamp;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)zbn_dateWithYMD;

/**
 * 格式化日期描述
 */
- (NSString *)zbn_formattedDateDescription;

/** 与当前时间的差距 */
- (NSDateComponents *)zbn_deltaWithNow;



//////////// MVC&MVVM的商品的发布时间的描述 ////////////
- (NSString *)zbn_string_yyyy_MM_dd;
- (NSString *)zbn_string_yyyy_MM_dd:(NSDate *)toDate;
//////////// MVC&MVVM的商品的发布时间的描述 ////////////

@end
