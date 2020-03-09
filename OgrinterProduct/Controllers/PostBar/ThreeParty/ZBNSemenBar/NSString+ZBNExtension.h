//
//  NSString+ZBNExtension.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZBNExtension)

/*! 返回一部分***的字符串 */
+ (instancetype)returnImportentNum:(NSString *)importentNum;
/*! 文件大小 */
- (unsigned long long)zbn_fileSize;

/**
 *  动态计算文字的宽高（单行）
 *  @param font 文字的字体
 *  @return 计算的宽高
 */
- (CGSize)zbn_sizeWithFont:(UIFont *)font;



@end

NS_ASSUME_NONNULL_END
