//
//  ZBNRTMoreView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTMoreView.h"

@implementation ZBNRTMoreView

/*! 点击加载更多 */
- (IBAction)moreBtnClick:(UIButton *)sender {

    if (self.moreBtnClickTask) {
        self.moreBtnClickTask(sender);
    }
}

@end
