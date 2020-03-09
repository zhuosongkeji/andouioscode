//
//  ZBNSHZDeliverGoodsDOCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHZDeliverGoodsDOCell.h"

#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderDetailsM.h"


@interface ZBNSHZDeliverGoodsDOCell ()

@property (weak, nonatomic) IBOutlet UIButton *returnGoodsBtn;
/*! 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *order_num;
/*! 支付时间 */
@property (weak, nonatomic) IBOutlet UILabel *order_time;
/*! 收货人 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/*! 收货地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/*! 电话 */
@property (weak, nonatomic) IBOutlet UILabel *phone_num;
/*! 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconV;
/*! 商品名 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/*! 规格 */
@property (weak, nonatomic) IBOutlet UILabel *goods_attr;
/*! 单价 */
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
/*! 数量 */
@property (weak, nonatomic) IBOutlet UILabel *goods_count;


/*! 合计 */
@property (weak, nonatomic) IBOutlet UILabel *total_money;
/*! 积分 */
@property (weak, nonatomic) IBOutlet UILabel *integer;
/*! 运费 */
@property (weak, nonatomic) IBOutlet UILabel *shipping_free;
/*! 实际付款 */
@property (weak, nonatomic) IBOutlet UILabel *pay_money;
/*! 付款方式 */
@property (weak, nonatomic) IBOutlet UILabel *pay_way;

@end

@implementation ZBNSHZDeliverGoodsDOCell


- (void)setComM:(ZBNSHOrderDetailComM *)comM
{
    _comM = comM;
    
    // 订单编号
    self.order_num.text = comM.order_sn;
    // 支付时间
    self.order_time.text = comM.pay_time;
    // 收货人
    self.name.text = comM.userinfo.name;
    // 收货地址
    self.address.text = [NSString stringWithFormat:@"%@%@%@%@",comM.userinfo.province,comM.userinfo.city,comM.userinfo.area,comM.userinfo.address];
    // 电话
    self.phone_num.text = comM.userinfo.mobile;
    // 合计
    self.total_money.text = [NSString stringWithFormat:@"¥%@",comM.order_money];
    // 积分
    self.integer.text = comM.integral;
    // 运费
    self.shipping_free.text = [NSString stringWithFormat:@"¥%@",comM.shipping_free];
    // 实际付款
    self.pay_money.text = [NSString stringWithFormat:@"¥%@",comM.pay_money];

}

- (void)setDetailM:(ZBNSHOrderDetailsM *)detailM
{
    _detailM = detailM;
    // 商品图片
    [self.goodsIconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailM.img]]];
    // 商品名
    self.goodsName.text = detailM.name;
    // 规格
    NSMutableString *muStr = [NSMutableString string];
    for (NSString *str in detailM.attr_value) {
        [muStr appendString:[NSString stringWithFormat:@"%@",str]];
    }
    self.goods_attr.text = [NSString stringWithFormat:@"%@",muStr];
    // 单价
    self.goods_price.text = [NSString stringWithFormat:@"¥%@",detailM.price];
    
     self.goods_count.text = [NSString stringWithFormat:@"x%@",detailM.num];
}


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHZDeliverGoodsDOCellID = @"ZBNSHZDeliverGoodsDOCellID";
    ZBNSHZDeliverGoodsDOCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHZDeliverGoodsDOCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHZDeliverGoodsDOCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (IBAction)returnGoodsBtnClick:(UIButton *)sender {
    if (self.returnGoodsBtnClickTask) {
        self.returnGoodsBtnClickTask();
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.returnGoodsBtn.layer.cornerRadius = 12;
    self.returnGoodsBtn.layer.borderColor = KSRGBA(100, 100, 100, 1).CGColor;
    self.returnGoodsBtn.layer.borderWidth = .5f;
}


@end
