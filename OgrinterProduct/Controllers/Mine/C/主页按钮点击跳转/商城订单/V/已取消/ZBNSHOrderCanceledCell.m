//
//  ZBNSHOrderCanceledCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHOrderCanceledCell.h"
#import "ZBNSHOrderDetailComM.h"

@interface ZBNSHOrderCanceledCell ()

/*! 订单号 */
@property (weak, nonatomic) IBOutlet UILabel *order_sn;
/*! 名字 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/*! 地址 */
@property (weak, nonatomic) IBOutlet UILabel *address;
/*! 电话 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
/*! 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
/*! 商品名 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/*! 规格 */
@property (weak, nonatomic) IBOutlet UILabel *goods_attr;
/*! 价格 */
@property (weak, nonatomic) IBOutlet UILabel *price;
/*! 购买数量 */
@property (weak, nonatomic) IBOutlet UILabel *num;
/*! 退货按钮 */
@property (weak, nonatomic) IBOutlet UIButton *returnBtn;
/*! 总价格 */
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
/*! 运费 */
@property (weak, nonatomic) IBOutlet UILabel *freight;
/*! 实际支付 */
@property (weak, nonatomic) IBOutlet UILabel *payMoney;

@end


@implementation ZBNSHOrderCanceledCell

- (void)setDetailM:(ZBNSHOrderDetailComM *)detailM
{
    _detailM = detailM;
    
    self.order_sn.text = detailM.order_sn;
    self.name.text = detailM.userinfo.name;
    self.address.text = detailM.userinfo.address;
    self.phoneNum.text = detailM.userinfo.mobile;
    
    self.goodsName.text = detailM.details.name;
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailM.details.img]] placeholderImage:[UIImage imageNamed:@"80"]];
    NSMutableString *muStr = [NSMutableString string];
    for (NSString *str in detailM.details.attr_value) {
        [muStr appendString:[NSString stringWithFormat:@"%@",str]];
    }
    self.self.goods_attr.text = [NSString stringWithFormat:@"%@",muStr];
    self.price.text = [NSString stringWithFormat:@"¥%@",detailM.details.price];
    self.num.text = [NSString stringWithFormat:@"x%@",detailM.details.num];
    
    self.totalMoney.text = [NSString stringWithFormat:@"¥%@",detailM.order_money];
    self.freight.text = [NSString stringWithFormat:@"+¥%@",detailM.shipping_free];
    self.payMoney.text = [NSString stringWithFormat:@"¥%@",detailM.pay_money];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.returnBtn.layer.cornerRadius = 15;
    self.returnBtn.layer.borderColor = KSRGBA(100, 100, 100, 1).CGColor;
    self.returnBtn.layer.borderWidth = .5;
}

- (IBAction)returnGoodsClick:(UIButton *)sender {
    if (self.returnGoodsClickTask) {
        self.returnGoodsClickTask(self);
    }
}


@end
