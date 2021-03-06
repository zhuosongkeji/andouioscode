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
/*! 去付款 */
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
/*! 取消订单 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

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
    self.address.text = [NSString stringWithFormat:@"%@%@%@%@",comM.userinfo.province,comM.userinfo.city,comM.userinfo.area,comM.userinfo.address];
    // 电话号码
    self.phone_num.text = comM.userinfo.mobile;

    // 商品图片
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comM.details.img]]];
    
    self.price.text = [NSString stringWithFormat:@"¥%@",comM.details.price];
    self.goodsName.text = comM.details.name;
    self.num.text = [NSString stringWithFormat:@"¥%@",comM.details.num];
    NSMutableString *muStr = [NSMutableString string];
    for (NSString *str in comM.details.attr_value) {
        [muStr appendString:[NSString stringWithFormat:@"%@",str]];
    }
    self.attr_value.text = [NSString stringWithFormat:@"%@",muStr];
}

/*! 取消订单 */
- (IBAction)cancelBtnClick:(UIButton *)sender {
    if (self.cancelBtnClickTask) {
        self.cancelBtnClickTask();
    }
}


/*! 去付款按钮的点击 */
- (IBAction)goAndPayBtnClick:(UIButton *)sender {
    if (self.goAndPayBtnClickTask) {
        self.goAndPayBtnClickTask();
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.payBtn.layer.cornerRadius = 10;
    self.payBtn.layer.borderWidth = 1;
    self.payBtn.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
    
    self.cancelBtn.layer.cornerRadius = 10;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
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
