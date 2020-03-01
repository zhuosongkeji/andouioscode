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
#import "ZBNRTPayVC.h"
#import "ZBNRTCommentVC.h"

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

//获取控制器

- (UIViewController *)viewController
{
        for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];

         if ([nextResponder isKindOfClass:[UIViewController class]]) {
         return (UIViewController *)nextResponder;
     }
        
     }
      return nil;
}


- (void)setDetailM:(ZBNRTComDetailModel *)detailM
{
    _detailM = detailM;
    self.booking_time.text = detailM.dinnertime;
    self.person_num.text = detailM.people;
    self.intro.text = detailM.remark;
    self.total_price.text = [NSString stringWithFormat:@"¥%@",detailM.prices];
    self.pay_way.text = detailM.method;
    self.integeral.text = detailM.integral;
    self.pay_money.text = [NSString stringWithFormat:@"¥%@",detailM.prices];
    
    self.erweimaImg.image =  [SGQRCodeObtain generateQRCodeWithData:@"啊,弱小的人类" size:self.erweimaImg.height];
    self.erweima_num.text = [NSString stringWithFormat:@"二维码号:%@",detailM.order_sn];
    
    if (detailM.status.intValue == 10) { // 如果是未付款
        [self.cancelBtn setTitle:@"去付款" forState:UIControlStateNormal];
        self.cancelBtn.hidden = NO;
    } else if (detailM.status.intValue == 20) {
        self.cancelBtn.hidden = YES;
    } else {
        [self.cancelBtn setTitle:@"去评论" forState:UIControlStateNormal];
        self.cancelBtn.hidden = NO;
    }
    
}

/*! 取消订单按钮点击 */
- (IBAction)cancelBtnClick:(id)sender {
    if (self.detailM.status.intValue == 10) { // 如果是未付款你的去付款
        ZBNRTPayVC *vc = [[ZBNRTPayVC alloc] init];
        vc.order_id = self.detailM.ID;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    } else if (self.detailM.status.intValue == 40) {  // 如果是待评论的去评价
        ZBNRTCommentVC *vc = [[ZBNRTCommentVC alloc] init];
        vc.merchants_id = self.detailM.merchant_id;
        vc.order_id = self.detailM.ID;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
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
