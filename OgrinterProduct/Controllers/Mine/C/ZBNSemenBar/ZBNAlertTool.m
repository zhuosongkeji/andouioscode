//
//  ZBNAlertTool.m
//  ZBNFM
//
//  Created by 周芳圆 on 2019/11/21.
//  Copyright © 2019 周芳圆. All rights reserved.
//

#import "ZBNAlertTool.h"


@implementation ZBNAlertTool

+ (void)zbn_alertTitle:(NSString *)titile type:(UIAlertControllerStyle)alertType message:(NSString * __nullable)message didTask:(void (^)(void))task
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:titile message:message preferredStyle:alertType];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (task) {
            task();
        }
    }];
    [alertVC addAction:action];
    [alertVC addAction:action1];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}



@end
