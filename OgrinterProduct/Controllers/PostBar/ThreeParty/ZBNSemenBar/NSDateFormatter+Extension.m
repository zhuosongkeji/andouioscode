//
//  NSDateFormatter+Extension.m

#import "NSDateFormatter+Extension.h"

@implementation NSDateFormatter (Extension)
+ (instancetype)zbn_dateFormatter
{
    return [[self alloc] init];
}

+ (instancetype)zbn_dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (instancetype)zbn_defaultDateFormatter
{
    return [self zbn_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
}
@end
