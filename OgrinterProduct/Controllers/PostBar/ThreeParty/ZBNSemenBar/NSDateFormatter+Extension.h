//
//  NSDateFormatter+Extension.h


#import <Foundation/Foundation.h>

@interface NSDateFormatter (Extension)
+ (instancetype)zbn_dateFormatter;

+ (instancetype)zbn_dateFormatterWithFormat:(NSString *)dateFormat;

+ (instancetype)zbn_defaultDateFormatter;/*yyyy/MM/dd HH:mm:ss*/
@end
