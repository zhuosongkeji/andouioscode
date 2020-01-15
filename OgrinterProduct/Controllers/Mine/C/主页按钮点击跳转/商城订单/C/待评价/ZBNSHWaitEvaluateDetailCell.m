//
//  ZBNSHWaitEvaluateDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHWaitEvaluateDetailCell.h"

#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderDetailsM.h"
#import "ZBNSHOrderUserInfoM.h"


@interface ZBNSHWaitEvaluateDetailCell ()

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

@end


@implementation ZBNSHWaitEvaluateDetailCell

- (void)setComM:(ZBNSHOrderDetailComM *)comM
{
    _comM = comM;
    self.order_num.text = comM.order_sn;
    self.order_money.text = comM.order_money;
    self.integral.text = comM.integral;
    self.pay_money.text = comM.pay_money;
    
    self.name.text = comM.userinfo.name;
    self.address.text = comM.userinfo.address;
    self.phone_num.text = comM.userinfo.mobile;
    
}

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHWaitEvaluateDetailCellID = @"ZBNSHWaitEvaluateDetailCellID";
    ZBNSHWaitEvaluateDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHWaitEvaluateDetailCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHWaitEvaluateDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
