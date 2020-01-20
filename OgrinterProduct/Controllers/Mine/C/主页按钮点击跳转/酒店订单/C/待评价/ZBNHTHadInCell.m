//
//  ZBNHTHadInCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTHadInCell.h"
#import "ZBNHTComDetailModel.h"

@interface ZBNHTHadInCell ()

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
@property (nonatomic, copy) NSString *tel;

@end

@implementation ZBNHTHadInCell

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
    self.tel = detailM.tel;
}

/*! 取消订单 */
- (IBAction)cancelBtnClick:(UIButton *)sender {
    
    
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
