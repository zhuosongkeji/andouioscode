//
//  ZBNAlertTool.h
//  ZBNFM
//
//  Created by 周芳圆 on 2019/11/21.
//  Copyright © 2019 周芳圆. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNAlertTool : NSObject

+ (void)zbn_alertTitle:(NSString *)titile type:(UIAlertControllerStyle)alertType message:(NSString * __nullable)message didTask:(void(^)(void))task;
@end

NS_ASSUME_NONNULL_END
