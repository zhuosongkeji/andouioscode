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
@property (weak, nonatomic) IBOutlet UIView *segmentView;
/*! 余额label */
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *consumpDetaiBtn;

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
    
    // 设置选钮容器视图的cornerRadius
    self.segmentView.layer.cornerRadius = 10;
    UIView *lineView = [[UIView alloc] init];
    lineView.width = self.consumpDetaiBtn.width;
    lineView.height = 1;
    lineView.y = self.segmentView.height - 2;
    lineView.centerX = self.consumpDetaiBtn.centerX;
    lineView.backgroundColor = [UIColor greenColor];
    [self.segmentView addSubview:lineView];
}

@end
