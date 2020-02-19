//
//  ZBNHTWaitInDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTWaitInDetailCell.h"
#import "ZBNHTComDetailModel.h"
#import "SGQRCode.h"
#import "ZBNHTApplyRefundVC.h"

@interface ZBNHTWaitInDetailCell ()

/*! 商家名字 */
@property (weak, nonatomic) IBOutlet UILabel *merchants_name;
/*! 房间图片 */
@property (weak, nonatomic) IBOutlet UIImageView *img;
/*! 房间名字 */
@property (weak, nonatomic) IBOutlet UILabel *house_name;
/*! 单价 */
@property (weak, nonatomic) IBOutlet UILabel *price;
/*! 订单总金额 */
@property (weak, nonatomic) IBOutlet UILabel *money;
/*! 使用积分 */
@property (weak, nonatomic) IBOutlet UILabel *integral;
/*! 支付金额 */
@property (weak, nonatomic) IBOutlet UILabel *pay_money;
/*! 入住时间 */
@property (weak, nonatomic) IBOutlet UILabel *start_time;
/*! 入住人 */
@property (weak, nonatomic) IBOutlet UILabel *real_name;
/*! 手机 */
@property (weak, nonatomic) IBOutlet UILabel *mobile;
/*! 订单号 */
@property (weak, nonatomic) IBOutlet UILabel *book_sn;
/*! 订单时间 */
@property (weak, nonatomic) IBOutlet UILabel *created_at;
/*! 支付方式 */
@property (weak, nonatomic) IBOutlet UILabel *pay_way;
/*! 二维码图片 */
@property (weak, nonatomic) IBOutlet UIImageView *erweimaImg;
/*! 二维码号 */
@property (weak, nonatomic) IBOutlet UILabel *erweima_num;

@property (nonatomic, copy) NSString *tel;

@end




@implementation ZBNHTWaitInDetailCell


- (void)setDetailM:(ZBNHTComDetailModel *)detailM
{
    _detailM = detailM;
    
    self.merchants_name.text = detailM.merchants_name;
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailM.img]]];
    self.house_name.text = detailM.house_name;
    self.price.text = detailM.price;
    self.money.text = detailM.money;
    self.integral.text = detailM.integral;
    self.pay_money.text = detailM.pay_money;
    self.start_time.text = detailM.start_time;
    self.real_name.text = detailM.real_name;
    self.mobile.text = detailM.mobile;
    self.book_sn.text = detailM.book_sn;
    self.created_at.text = detailM.created_at;
    self.pay_way.text = detailM.pay_way;
    self.erweimaImg.image =  [SGQRCodeObtain generateQRCodeWithData:[NSString stringWithFormat:@"%@",detailM.book_sn] size:self.erweimaImg.height];
    self.erweima_num.text = [NSString stringWithFormat:@"二维码号:%@",detailM.book_sn];
    self.tel = detailM.tel;
    
    
}

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

/*! 取消点击 */
- (IBAction)cancelBtnClick:(id)sender {
    ZBNHTApplyRefundVC *vc = [[ZBNHTApplyRefundVC alloc] init];
    vc.money = self.detailM.money;
    vc.merchants_id = self.detailM.merchant_id;
    vc.order_sn = self.detailM.book_sn;
    NSLog(@"%@===============",self.detailM.merchant_id);
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

/*! 联系商家 */
- (IBAction)contactShop:(id)sender {
    if (self.tel) {
           NSString *telephoneNumber = self.tel;
           NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
           [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:str]];
       } else {
           NSString *telephoneNumber = @"10086";
           NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
           [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:str]];
       }
}




@end
