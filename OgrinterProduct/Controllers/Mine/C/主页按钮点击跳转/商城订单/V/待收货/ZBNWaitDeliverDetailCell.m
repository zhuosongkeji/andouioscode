//
//  ZBNWaitDeliverDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWaitDeliverDetailCell.h"

#import "ZBNSHCommonModel.h"
#import "ZBNSHOrderDetailComM.h"
#import "ZBNSHOrderDetailsM.h"


@interface ZBNWaitDeliverDetailCell ()

@property (weak, nonatomic) IBOutlet UIButton *returnGoodsBtn;
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

@implementation ZBNWaitDeliverDetailCell


/*! 确认收货按钮的点击事件 */
- (IBAction)beSureReciveGoodsBtnClick:(UIButton *)sender {
    if (self.beSureReciveGoodsBtnClickTask) {
        self.beSureReciveGoodsBtnClickTask();
    }
}

/*! 退货退款的点击 */

- (IBAction)returnGoodsBtnClick:(UIButton *)sender {
    if (self.returnGoodsBtnClickTask) {
        self.returnGoodsBtnClickTask();
    }
}


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

     [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comM.details.img]]];
       
       self.price.text = [NSString stringWithFormat:@"¥%@",comM.details.price];
       self.goodsName.text = comM.details.name;
       self.num.text = comM.details.num;
       NSMutableString *muStr = [NSMutableString string];
       for (NSString *str in comM.details.attr_value) {
           [muStr appendString:[NSString stringWithFormat:@"%@",str]];
       }
       self.attr_value.text = [NSString stringWithFormat:@"%@",muStr];
}





+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNWaitDeliverDetailCellID = @"ZBNWaitDeliverDetailCell";
    ZBNWaitDeliverDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNWaitDeliverDetailCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNWaitDeliverDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
/*! 查看物流点击 */
- (IBAction)viewLogisticsBtnClick:(UIButton *)sender {
    if (self.viewLogisticsBtnClickTask) {
        self.viewLogisticsBtnClickTask();
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.returnGoodsBtn.layer.cornerRadius = 12;
    self.returnGoodsBtn.layer.borderWidth = .5f;
    self.returnGoodsBtn.layer.borderColor = KSRGBA(100, 100, 100, 1).CGColor;
}




@end
