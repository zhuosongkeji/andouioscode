//
//  ZBNHTOrderNotPayCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTOrderNotPayCell.h"
#import "ZBNHTComDetailModel.h"

@interface ZBNHTOrderNotPayCell ()

/*! 酒店名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/*! 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *image;
/*! 房间名 */
@property (weak, nonatomic) IBOutlet UILabel *roomName;
/*! 几个房 */
@property (weak, nonatomic) IBOutlet UILabel *count;
/*! 单价 */
@property (weak, nonatomic) IBOutlet UILabel *price;
/*! 地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/*! 总价 */
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
/*! 积分 */
@property (weak, nonatomic) IBOutlet UILabel *integeral;
/*! 实际支付 */
@property (weak, nonatomic) IBOutlet UILabel *paymoney;
/*! 入店时间 */
@property (weak, nonatomic) IBOutlet UILabel *time;
/*! 人 */
@property (weak, nonatomic) IBOutlet UILabel *person;
/*! 电话 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
/*! 下单号 */
@property (weak, nonatomic) IBOutlet UILabel *order_sn;
/*! 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *order_time;
/*! 支付方式 */
@property (weak, nonatomic) IBOutlet UILabel *payWays;
@property (nonatomic, copy) NSString *tel;
@end

@implementation ZBNHTOrderNotPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailM:(ZBNHTComDetailModel *)detailM
{
    _detailM = detailM;
    
    self.name.text = detailM.merchants_name;
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailM.img]] placeholderImage:[UIImage imageNamed:@"80"]];
    self.roomName.text = detailM.house_name;
    self.count.text = @"x1";
    self.price.text = [NSString stringWithFormat:@"¥%@",detailM.price];
    self.address.text = @"重庆大都市里面";
    
    self.totalPrice.text = [NSString stringWithFormat:@"¥%@",detailM.money];
    self.integeral.text = [NSString stringWithFormat:@"%@",detailM.integral];
    self.paymoney.text = [NSString stringWithFormat:@"¥%@",detailM.pay_money];
    
    self.time.text = detailM.start_time;
    self.person.text = detailM.real_name;
    self.phoneNum.text = detailM.mobile;
    
    self.order_sn.text = detailM.book_sn;
    self.order_time.text = detailM.created_at;
    self.payWays.text = detailM.pay_way;
    
}



- (IBAction)phoneClick:(id)sender {
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
