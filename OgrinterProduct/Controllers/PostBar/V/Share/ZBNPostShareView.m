//
//  ZBNPostShareView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostShareView.h"

@implementation ZBNPostShareView


- (IBAction)didMissBtnClick:(UIButton *)sender {
    QWAlertView *alertV = [QWAlertView sharedMask];
    [alertV dismiss];
}


@end
