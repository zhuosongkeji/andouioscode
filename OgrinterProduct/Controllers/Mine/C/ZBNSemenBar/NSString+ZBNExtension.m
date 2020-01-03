//
//  NSString+ZBNExtension.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "NSString+ZBNExtension.h"

@implementation NSString (ZBNExtension)

+ (instancetype)returnImportentNum:(NSString *)importentNum
{
        NSString *formerStr = [importentNum substringToIndex:4];
     NSString *str1 = [importentNum stringByReplacingOccurrencesOfString:formerStr withString:@""];
    NSString *endStr = [importentNum substringFromIndex:importentNum.length-4];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:endStr withString:@""];
     NSString *middleStr = [str2 stringByReplacingOccurrencesOfString:str2 withString:@"****"];
     NSString *finalNum = [formerStr stringByAppendingFormat:@"%@%@",middleStr,endStr];
     return finalNum;

}


- (unsigned long long)zbn_fileSize
{
    // 计算self这个文件夹\文件的大小
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:self error:nil];
    NSString *fileType = attrs.fileType;
    
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:self];
        
        // 总大小
        unsigned long long fileSize = 0;
        
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        
        return fileSize;
    }
    
    // 文件
    return attrs.fileSize;
}


@end
