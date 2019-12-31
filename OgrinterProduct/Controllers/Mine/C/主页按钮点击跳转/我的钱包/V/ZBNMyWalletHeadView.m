//
//  ZBNMyWalletHeadView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyWalletHeadView.h"

@interface ZBNMyWalletHeadView ()
/*! 充值 */
@property (weak, nonatomic) IBOutlet UIView *rechargeBtnView;
/*! 提现 */
@property (weak, nonatomic) IBOutlet UIView *cashWithdrawalBtnView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation ZBNMyWalletHeadView


/*! 余额提现的点击 */
- (IBAction)cashWithDrawalClick:(UIButton *)sender {
    
    if (self.cashWithDrawalBtnClickTask) {
        self.cashWithDrawalBtnClickTask();
    }
}

- (IBAction)reChargeBtnClick:(UIButton *)sender {
    if (self.reChargeBtnClickTask) {
        self.reChargeBtnClickTask(self.moneyLabel.text);
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 充值
    self.rechargeBtnView.layer.cornerRadius = 10;
    self.rechargeBtnView.layer.borderWidth = 1;
    self.rechargeBtnView.layer.borderColor = [UIColor whiteColor].CGColor;
    // 提现
    self.cashWithdrawalBtnView.layer.cornerRadius = 10;
    self.cashWithdrawalBtnView.layer.borderWidth = 1;
    self.cashWithdrawalBtnView.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
