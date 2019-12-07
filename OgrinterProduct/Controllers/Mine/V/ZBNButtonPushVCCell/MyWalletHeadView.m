//
//  MyWalletHeadView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//  我的钱包控制器

#import "MyWalletHeadView.h"

@interface MyWalletHeadView ()

/*! 选项卡容器视图 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/*! 余额label */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/*! 消费明细Btn */

@property (weak, nonatomic) IBOutlet UIButton *costBtn;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@end

@implementation MyWalletHeadView


/*! 充值按钮点击 */
- (IBAction)rechargeBtnClick:(UIButton *)sender
{
    if (self.rechargeBtnClickTask) {
        self.rechargeBtnClickTask();
    }
}
/*! 消费明细点击 */
- (IBAction)consumptionDetailClick:(UIButton *)sender {
    if (self.consumptionDetailClick) {
        self.consumptionDetailClick();
    }
}
/*! 充值明细点击 */
- (IBAction)rechargeDetailClick:(UIButton *)sender {
}
/*! 从xib加载调用 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.buttonView.layer.cornerRadius = 8;
    self.buttonView.layer.borderWidth = 1;
    self.buttonView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.bottomView.layer.cornerRadius = 8;
    
}

@end
