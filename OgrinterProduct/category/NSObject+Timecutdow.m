//
//  NSObject+Timecutdow.m
//  EnterPrise
//
//  Created by Mac on 2019/10/12.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "NSObject+Timecutdow.h"


@implementation NSObject (Timecutdow)

- (void)CutTimedowButton:(UIButton *)btn Time:(NSInteger)time{
    
    __block NSInteger second = TIMECOUNT;
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                btn.userInteractionEnabled = YES;
                [btn setTitle:[NSString stringWithFormat:@"获取验证码"] forState:UIControlStateNormal];
                second = TIMECOUNT;
                dispatch_cancel(timer);
                
            }else {
                btn.userInteractionEnabled = NO;
                [btn setTitle:[NSString stringWithFormat:@"%ld秒后获取",second] forState:UIControlStateNormal];
                second--;
            }
        });
    });
    dispatch_resume(timer);
}

+ (UIFont *)fit_configure:(CGFloat)font {
    if (KSCREEN_WIDTH == 320)
        return [UIFont systemFontOfSize:(font - 1)];
    else if (KSCREEN_WIDTH == 375)
        return [UIFont systemFontOfSize:font];
    else
        return [UIFont systemFontOfSize:(font + 1 )];
}

//随机颜色
+ (UIColor*)RandomColor {

    NSInteger aRedValue =arc4random() %255;

    NSInteger aGreenValue =arc4random() %255;

    NSInteger aBlueValue =arc4random() %255;

    UIColor*randColor = [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue /255.0f blue:aBlueValue /255.0f alpha:1.0f];

    return randColor;

}

+ (BOOL)validateContactNumber:(NSString *)mobileNum
{
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";

    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
   
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";

    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
   // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
   // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}


+ (NSString *)transformToPinyin:(NSString *)aString {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);

    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];

    int count = 0;

    for (int  i = 0; i < pinyinArray.count; i++)
    {
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];
                //区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    NSMutableString *initialStr = [NSMutableString new];
    //拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}


+ (BOOL) IsPhoneNumber:(NSString *)number{
    NSString *phoneRegex1=@"1[345789]([0-9]){9}";
    NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return  [phoneTest1 evaluateWithObject:number];
}


+ (BOOL)validateIDCardNumber:(NSString *)idCardNumber {
    
    idCardNumber = [idCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!idCardNumber) {
        return NO;
    }else {
        length = idCardNumber.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [idCardNumber substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [idCardNumber substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            }else {
                //测试出生日期的合法性
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber options:NSMatchingReportProgress range:NSMakeRange(0, idCardNumber.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [idCardNumber substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:idCardNumber options:NSMatchingReportProgress range:NSMakeRange(0, idCardNumber.length)];
            
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [idCardNumber substringWithRange:NSMakeRange(0,1)].intValue*7 + [idCardNumber substringWithRange:NSMakeRange(10,1)].intValue *7 + [idCardNumber substringWithRange:NSMakeRange(1,1)].intValue*9 + [idCardNumber substringWithRange:NSMakeRange(11,1)].intValue *9 + [idCardNumber substringWithRange:NSMakeRange(2,1)].intValue*10 + [idCardNumber substringWithRange:NSMakeRange(12,1)].intValue *10 + [idCardNumber substringWithRange:NSMakeRange(3,1)].intValue*5 + [idCardNumber substringWithRange:NSMakeRange(13,1)].intValue *5 + [idCardNumber substringWithRange:NSMakeRange(4,1)].intValue*8 + [idCardNumber substringWithRange:NSMakeRange(14,1)].intValue *8 + [idCardNumber substringWithRange:NSMakeRange(5,1)].intValue*4 + [idCardNumber substringWithRange:NSMakeRange(15,1)].intValue *4 + [idCardNumber substringWithRange:NSMakeRange(6,1)].intValue*2 + [idCardNumber substringWithRange:NSMakeRange(16,1)].intValue *2 + [idCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6 + [idCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                
                NSString *lastStr = [idCardNumber substringWithRange:NSMakeRange(17,1)];
                
                NSLog(@"%@",M);
                NSLog(@"%@",[idCardNumber substringWithRange:NSMakeRange(17,1)]);
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else{
                        
                        return NO;
                    }
                }else{
                    
                    if ([M isEqualToString:[idCardNumber substringWithRange:NSMakeRange(17,1)]]) {
                        return YES;
                    }else {
                        return NO;
                    }
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}


+ (NSString *)imageSavedPath:(NSString *) imageName {
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    
    [fileManager createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * imagePath = [imageDocPath stringByAppendingPathComponent:imageName];
    
    return imagePath;
}


+ (BOOL)saveToDocument:(UIImage *)image withFilePath:(NSString *)filePath  {
    
    if ((image == nil) || (filePath == nil) || [filePath isEqualToString:@""]) {
        return NO;
    }
    NSData *imageData = nil;
    NSString *extention = [filePath pathExtension];
    if ([extention isEqualToString:@"png"]) {
         imageData = UIImagePNGRepresentation(image);
    }else{
        imageData = UIImageJPEGRepresentation(image, 0);
    }
    if (imageData == nil || [imageData length] <= 0) {
        return NO;
    }
     [imageData writeToFile:filePath atomically:YES];
    
    return YES;
}


+ (UIImage *)getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

//MARK:- 使用颜色填充图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}


//MARK:- 获取s当前视图所在的Controller
+ (UIViewController *)findCurrentShowingViewController {
    //获得当前活动窗口的根视图
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

//注意考虑几种特殊情况：①A present B, B present C，参数vc为A时候的情况
/* 完整的描述请参见文件头部 */
+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc
{
    //方法1：递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) { //注要优先判断vc是否有弹出其他视图，如有则当前显示的视图肯定是在那上面
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
        
    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }
    
    return currentShowingVC;
    
}

+(NSString *)getNowtime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *nowDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    
    return nowDateString;
}


+(NSString *)getNowtime1 {
    
    NSDate * newDate = [NSDate date];
    NSDateFormatter*dateformat=[[NSDateFormatter alloc]init];
    
    [dateformat setDateFormat:@"HH:mm:ss"];
    
    NSString *newDateOne = [dateformat stringFromDate:newDate];
    
    [dateformat setFormatterBehavior:NSDateFormatterFullStyle];
    [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    return newDateOne;
}


+(NSString *)getnextDate{
    
    NSDate *nowDate = [NSDate date];
    
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:nowDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    nextDay = [nextDay dateByAddingTimeInterval:interval];
    NSString *nextStr = [dateFormatter stringFromDate:nextDay];
    
    return nextStr;
}


+ (NSString *)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2{
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comp = [calendar components:NSCalendarUnitDay
                    fromDate:date1      toDate:date2 options:NSCalendarWrapComponents];
    
//    // 2.创建日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    // 3.利用日历对象比较两个时间的差值
//    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
//    // 4.输出结果
//    NSLog(@"两个时间相差%ld年%ld月%ld日", cmps.year, cmps.month, cmps.day);
    
    NSLog(@"comp.day == %ld",comp.day);
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld",comp.day];
    
    return timeStr;
}



+ (NSString *)pleaseInsertStarTimeo1:(NSString *)time1 andInsertEndTime:(NSString *)time2{
    // 1.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * comp = [calendar components:NSCalendarUnitDay
                                          fromDate:date1      toDate:date2 options:NSCalendarWrapComponents];
    
    //    // 2.创建日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    // 3.利用日历对象比较两个时间的差值
    //    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    //    // 4.输出结果
    //    NSLog(@"两个时间相差%ld年%ld月%ld日", cmps.year, cmps.month, cmps.day);
    
    NSLog(@"comp.day == %ld",comp.day);
    
    NSString *timeStr = [NSString stringWithFormat:@"%ld",comp.day];
    
    return timeStr;
}

- (NSString *)intervalFromLastDate: (NSString *) time2 with: (NSString *) nowTime{
    
    
    NSLog(@"%@.....%@",time2,nowTime);
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSDate *d1=[date dateFromString:time2];
    
    
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    
    
    NSDate *d2 = [date dateFromString:nowTime];
    
    
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha=late2-late1;
    
    NSString *timeString=@"";
    
    NSString *house=@"";
    
    NSString *min=@"";
    
    NSString *sen=@"";
    
    
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    
    //        min = [min substringToIndex:min.length-7];
    
    //    秒
    
    sen=[NSString stringWithFormat:@"%@", sen];
    
    
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    
    //        min = [min substringToIndex:min.length-7];
    
    //    分
    
    min=[NSString stringWithFormat:@"%@", min];
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];

    
    return timeString;
    
}



@end
