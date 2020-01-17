//
//  ZBNVIPRechargeCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNVIPRechargeCell.h"

@interface ZBNVIPRechargeCell ()
/*! 微信支付按钮 */
@property (weak, nonatomic) IBOutlet UIButton *wxPayBtn;
/*! 余额支付按钮 */
@property (weak, nonatomic) IBOutlet UIButton *yePayBtn;
@end


@implementation ZBNVIPRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (IBAction)payBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.tag == 10 && sender.selected) {
        self.yePayBtn.selected = NO;
        if (self.payBtnClickTask) {
            self.payBtnClickTask(@"1");
        }
        NSLog(@"选择了微信");
    } else if (sender.tag == 20 && sender.selected) {
        self.wxPayBtn.selected = NO;
        if (self.payBtnClickTask) {
            self.payBtnClickTask(@"99");
        }
        NSLog(@"选择了余额");
    }
}

@end
