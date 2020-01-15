//
//  NSObject+Timecutdow.h
//  EnterPrise
//
//  Created by Mac on 2019/10/12.
//  Copyright © 2019 Mac. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Timecutdow)

+ (BOOL) IsPhoneNumber:(NSString *)number;

- (void)CutTimedowButton:(UIButton *)btn Time:(NSInteger)time;

+ (UIFont *)fit_configure:(CGFloat)font;

+ (BOOL)validateContactNumber: (NSString*) mobileNum;

+ (UIColor*)RandomColor;

+ (NSString *)transformToPinyin:(NSString *)aString;

+ (BOOL)validateIDCardNumber:(NSString *)idCardNumber;//身份证

+ (NSString *)imageSavedPath:(NSString *) imageName;

+ (BOOL)saveToDocument:(UIImage *)image withFilePath:(NSString *)filePath;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;

+ (UIImage *)imageWithColor:(UIColor *)color;

//获取当前视图所在的Controller
+ (UIViewController *)findCurrentShowingViewController;

+(NSString *)getNowtime;

+(NSString *)getnextDate;

//计算两个时间差
+ (NSString *)pleaseInsertStarTimeo:(NSString *)time1 andInsertEndTime:(NSString *)time2;

@end

NS_ASSUME_NONNULL_END
