//
//  ZBNRTPayCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTPayCell.h"
#import "ZBNRTComDetailModel.h"

@interface ZBNRTPayCell ()
/*! 时间 */
@property (weak, nonatomic) IBOutlet UILabel *time;
/*! 人数 */
@property (weak, nonatomic) IBOutlet UILabel *personNum;
/*! 备注 */
@property (weak, nonatomic) IBOutlet UILabel *atension;
/*! 总金额 */
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
/*! 使用感恩币 */
@property (weak, nonatomic) IBOutlet UILabel *integarl;
/*! 实际支付 */
@property (weak, nonatomic) IBOutlet UILabel *payMoney;
/*! 微信按钮 */
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;
/*! 余额按钮 */
@property (weak, nonatomic) IBOutlet UIButton *yueBtn;

@end

@implementation ZBNRTPayCell

- (void)setDetailM:(ZBNRTComDetailModel *)detailM
{
    _detailM = detailM;
    self.time.text = detailM.dinnertime;
    self.personNum.text = [NSString stringWithFormat:@"%@人",detailM.people];
    self.atension.text = detailM.remark;
    self.totalPrice.text = [NSString stringWithFormat:@"¥%@",detailM.prices];
    self.integarl.text = detailM.integral;
    self.payMoney.text = [NSString stringWithFormat:@"¥%@",detailM.prices];
}


- (IBAction)weixinBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.weixinBtnClickTask) {
        self.weixinBtnClickTask(sender);
    }
    if (sender.selected) {
        self.yueBtn.selected = NO;
    } else {
        sender.selected = YES;
        self.yueBtn.selected = NO;
    }

}

- (IBAction)yueBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.yueBtnClickTask) {
        self.yueBtnClickTask(sender);
    }
    if (sender.selected) {
        self.weixinBtn.selected = NO;
    } else {
        sender.selected = YES;
        self.weixinBtn.selected = NO;
    }

}



@end
