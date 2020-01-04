//
//  ZBNSHGoAndPayDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHGoAndPayDetailCell.h"

#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderDetailsM.h"

@interface ZBNSHGoAndPayDetailCell ()

/*! 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *order_num;
/*! 订单时间 */
@property (weak, nonatomic) IBOutlet UILabel *order_create_time;
/*! 订单总金额 */
@property (weak, nonatomic) IBOutlet UILabel *order_money;
/*! 使用积分 */
@property (weak, nonatomic) IBOutlet UILabel *integral;
/*! 支付金额 */
@property (weak, nonatomic) IBOutlet UILabel *pay_money;

/*!***********userBegin****************/
/*! 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/*! 收货详细地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/*! 电话号码 */
@property (weak, nonatomic) IBOutlet UILabel *phone_num;
/*!***********userEnd****************/

/*!***********detailBegin****************/

/*! 商品名 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/*! 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *img;
/*! 单价 */
@property (weak, nonatomic) IBOutlet UILabel *price;
/*! 购买数量 */
@property (weak, nonatomic) IBOutlet UILabel *num;
/*! 规格 */
@property (weak, nonatomic) IBOutlet UILabel *attr_value;
/*!***********detailEnd****************/

@end

@implementation ZBNSHGoAndPayDetailCell


- (void)setComM:(ZBNSHOrderDetailComM *)comM
{
    _comM = comM;
    // 订单编号
    self.order_num.text = comM.order_sn;
    // 订单时间
    self.order_create_time.text = comM.pay_time;
    // 订单总金额
    self.order_money.text = [NSString stringWithFormat:@"¥%@",comM.order_money];
    // 使用积分
    // 支付金额
    self.pay_money.text = [NSString stringWithFormat:@"¥%@",comM.pay_money];
    
    // 收货人
    self.name.text = comM.userinfo.name;
    // 收货详细地址
    self.address.text = comM.userinfo.address;
    // 电话号码
    self.phone_num.text = comM.userinfo.mobile;

}

- (void)setDetailM:(ZBNSHOrderDetailsM *)detailM
{
    _detailM = detailM;
    // 商品图片
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailM.img]]];
    
    self.price.text = [NSString stringWithFormat:@"¥%@",detailM.price];
    self.goodsName.text = detailM.name;
    self.num.text = detailM.num;
    self.attr_value.text = detailM.attr_value[1];
    
}


/*! 退货退款按钮的点击 */
- (IBAction)returnGoodsBtnClick:(UIButton *)sender {
}

/*! 去付款按钮的点击 */
- (IBAction)goAndPayBtnClick:(UIButton *)sender {
}





+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHGoAndPayDetailCellID = @"ZBNSHWaitReceivingGoodsOrderCellID";
    ZBNSHGoAndPayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHGoAndPayDetailCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHGoAndPayDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
