//
//  ZBNMyWalletHeadView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyWalletHeadView.h"

@interface ZBNMyWalletHeadView ()

@property (weak, nonatomic) IBOutlet UIView *rechargeBtnView;


@end

@implementation ZBNMyWalletHeadView


/*! 余额提现的点击 */
- (IBAction)cashWithDrawalClick:(UIButton *)sender {
    
    if (self.cashWithDrawalBtnClickTask) {
        self.cashWithDrawalBtnClickTask();
    }
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.rechargeBtnView.layer.cornerRadius = 10;
    self.rechargeBtnView.layer.borderWidth = 1;
    self.rechargeBtnView.layer.borderColor = [UIColor whiteColor].CGColor;
}

@end
