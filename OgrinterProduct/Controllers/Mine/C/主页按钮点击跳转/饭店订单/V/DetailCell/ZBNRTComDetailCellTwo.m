//
//  ZBNRTComDetailCellTwo.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTComDetailCellTwo.h"
#import "ZBNRTComDetailModel.h"
#import "SGQRCode.h"

@interface ZBNRTComDetailCellTwo ()
/*! 二维码图 */
@property (weak, nonatomic) IBOutlet UIImageView *erweimaImg;
/*! 二维码号 */
@property (weak, nonatomic) IBOutlet UILabel *erweima_num;
/*! 到店时间 */
@property (weak, nonatomic) IBOutlet UILabel *booking_time;
/*! 人数 */
@property (weak, nonatomic) IBOutlet UILabel *person_num;
/*! 备注 */
@property (weak, nonatomic) IBOutlet UILabel *intro;
/*! 总金额 */
@property (weak, nonatomic) IBOutlet UILabel *total_price;
/*! 支付方式 */
@property (weak, nonatomic) IBOutlet UILabel *pay_way;
/*! 使用积分 */
@property (weak, nonatomic) IBOutlet UILabel *integeral;
/*! 实际支付 */
@property (weak, nonatomic) IBOutlet UILabel *pay_money;
/*! 取消订单按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end


@implementation ZBNRTComDetailCellTwo


- (void)setDetailM:(ZBNRTComDetailModel *)detailM
{
    _detailM = detailM;
    self.booking_time.text = detailM.dinnertime;
    self.person_num.text = detailM.people;
    self.intro.text = detailM.remark;
    self.total_price.text = [NSString stringWithFormat:@"¥%@",detailM.prices];
    self.pay_way.text = detailM.method;
    self.integeral.text = detailM.integral;
    self.pay_money.text = [NSString stringWithFormat:@"¥%@",detailM.pay_money];
    
    self.erweimaImg.image =  [SGQRCodeObtain generateQRCodeWithData:@"啊,弱小的人类" size:self.erweimaImg.height];
    self.erweima_num.text = [NSString stringWithFormat:@"二维码号:%@",detailM.order_sn];
    
}

/*! 取消订单按钮点击 */
- (IBAction)cancelBtnClick:(id)sender {
    
}

#pragma mark -- life
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.cancelBtn.layer.cornerRadius = 10;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
    [self.cancelBtn setTitleColor:KSRGBA(97, 194, 156, 1) forState:UIControlStateNormal];
}


@end
