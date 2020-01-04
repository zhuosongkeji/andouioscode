//
//  ZBNSHCommonCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHCommonCell.h"

#import "ZBNSHGoAndPayDetailVC.h"
#import "ZBNSHZDeliverGoodsDOVC.h"

@interface ZBNSHCommonCell ()
/*! 商家图标 */
@property (weak, nonatomic) IBOutlet UIImageView *shopIconV;
/*! 商家名 */
@property (weak, nonatomic) IBOutlet UILabel *shopNameL;
/*! 订单编号 */
@property (weak, nonatomic) IBOutlet UILabel *goodsOrderNum;
/*! 订单状态 */
@property (weak, nonatomic) IBOutlet UILabel *goodsState;
/*! 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageV;
/*! 商品名 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/*! 商品数量 */
@property (weak, nonatomic) IBOutlet UILabel *goodsCountL;
/*! 商品介绍 */
@property (weak, nonatomic) IBOutlet UILabel *goodsSubL;
/*! 商品价格 */
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceL;
/*! 合计 */
@property (weak, nonatomic) IBOutlet UILabel *countL;
/*! 总价 */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceL;
/*! 底部第一个按钮 */
@property (weak, nonatomic) IBOutlet UIButton *firButton;
/*! 底部第二个按钮 */
@property (weak, nonatomic) IBOutlet UIButton *secButton;
/*! 底部第三个按钮 */
@property (weak, nonatomic) IBOutlet UIButton *thiButton;
@end


@implementation ZBNSHCommonCell


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


#pragma mark -- 按钮点击 -- 底部从左至右的按钮

/*! 第一个按钮的点击 */
- (IBAction)firBtnClick:(UIButton *)sender {
    
    if ([self.commonM.status integerValue] == 40) {
        NSLog(@"待收货的订单详情");
    } else if ([self.commonM.status integerValue] == 50) {
        NSLog(@"待评价的查看物流");
    }
    
    if (self.firBtnClickTask) {
        self.firBtnClickTask();
    }
}
/*! 第二个按钮的点击 */
- (IBAction)secButtonClick:(UIButton *)sender {
    if (self.secBtnClickTask) {
        self.secBtnClickTask();
    }
    ADWeakSelf;
    if ([self.commonM.status integerValue] == 10) { // 如果是待付款的订单详情
        ZBNSHGoAndPayDetailVC *vc = [[ZBNSHGoAndPayDetailVC alloc] init];
        vc.getOrderNum = self.commonM.order_id;
        [[weakSelf viewController].navigationController pushViewController:vc animated:YES];
    } else if ([self.commonM.status integerValue] == 40) {  //待收货的查看物流
        NSLog(@"查看物流");
    } else if ([self.commonM.status integerValue] == 50) {
        NSLog(@"待评价的订单详情");
    }
    
}
/*! 第三个按钮的点击 */
- (IBAction)thiBtnClick:(UIButton *)sender {
    if (self.thiBtnClickTask) {
        self.thiBtnClickTask();
    }
    ADWeakSelf;
    if ([self.commonM.status integerValue] == 10) {
        NSLog(@"待付款的去付款");
    } else if ([self.commonM.status integerValue] == 20) {
        NSLog(@"待发货的订单订单详情");
        ZBNSHZDeliverGoodsDOVC *vc = [[ZBNSHZDeliverGoodsDOVC alloc] init];
        vc.order_num = self.commonM.order_id;
        [[weakSelf viewController].navigationController pushViewController:vc animated:YES];
    } else if ([self.commonM.status integerValue] == 40) {
        NSLog(@"待收货的确认收货");
    } else if ([self.commonM.status integerValue] == 50) {
        NSLog(@"待评价的去评价");
    }
    
}

#pragma mark -- 设置模型数据

/*! 设置模型数据 */
- (void)setCommonM:(ZBNSHCommonModel *)commonM
{
    _commonM = commonM;
    
    if ([commonM.status integerValue] == 10) { // 待付款
        self.firButton.hidden = YES;
        self.secButton.hidden = NO;
        self.thiButton.hidden = NO;
        self.goodsState.text = @"未付款";
        // 第二按钮
        [self.secButton setTitle:@"订单详情" forState:UIControlStateNormal];
        [self.secButton setTitleColor:KSRGBA(150, 150, 150, 1) forState:UIControlStateNormal];
        self.secButton.layer.borderColor = KSRGBA(150, 150, 150, 1).CGColor;
        // 第三按钮
        [self.thiButton setTitle:@"去付款" forState:UIControlStateNormal];
        self.thiButton.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
        [self.thiButton setTitleColor:KSRGBA(97, 194, 156, 1) forState:UIControlStateNormal];
    } else if ([commonM.status integerValue] == 20) { // 待发货 / 已付款
        self.firButton.hidden = YES;
        self.secButton.hidden = YES;
        self.thiButton.hidden = NO;
        // 第三按钮
        [self.thiButton setTitle:@"订单详情" forState:UIControlStateNormal];
        self.thiButton.layer.borderColor = KSRGBA(150, 150, 150, 1).CGColor;
        [self.thiButton setTitleColor:KSRGBA(150, 150, 150, 1) forState:UIControlStateNormal];
        self.goodsState.text = @"待发货";
    } else if ([commonM.status integerValue] == 40) { // 待收货 / 已发货
        self.firButton.hidden = NO;
        self.secButton.hidden = NO;
        self.thiButton.hidden  =NO;
        // 第一
        [self.firButton setTitle:@"订单详情" forState:UIControlStateNormal];
        self.firButton.layer.borderColor = KSRGBA(150, 150, 150, 1).CGColor;
        [self.firButton setTitleColor:KSRGBA(150, 150, 150, 1) forState:UIControlStateNormal];
        // 第二
        [self.secButton setTitle:@"查看物流" forState:UIControlStateNormal];
        self.secButton.layer.borderColor = KSRGBA(150, 150, 150, 1).CGColor;
        [self.secButton setTitleColor:KSRGBA(150, 150, 150, 1) forState:UIControlStateNormal];
        // 第三
        [self.thiButton setTitle:@"确认收货" forState:UIControlStateNormal];
        self.thiButton.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
        [self.thiButton setTitleColor:KSRGBA(97, 194, 156, 1) forState:UIControlStateNormal];
        self.goodsState.text = @"待收货";
    } else if ([commonM.status integerValue] == 50) { // 待评价
        self.goodsState.text = @"待评价";
        self.firButton.hidden = NO;
        self.secButton.hidden = NO;
        self.thiButton.hidden = NO;
        // 第一
        [self.firButton setTitle:@"查看物流" forState:UIControlStateNormal];
        self.firButton.layer.borderColor = KSRGBA(150, 150, 150, 1).CGColor;
        [self.firButton setTitleColor:KSRGBA(150, 150, 150, 1) forState:UIControlStateNormal];
        // 第二
        [self.secButton setTitle:@"订单详情" forState:UIControlStateNormal];
        self.secButton.layer.borderColor = KSRGBA(150, 150, 150, 1).CGColor;
        [self.secButton setTitleColor:KSRGBA(150, 150, 150, 1) forState:UIControlStateNormal];
        // 第三
        [self.thiButton setTitle:@"去评价" forState:UIControlStateNormal];
        self.thiButton.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
        [self.thiButton setTitleColor:KSRGBA(97, 194, 156, 1) forState:UIControlStateNormal];
    }
    
    // 商家图片
    [self.shopIconV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,commonM.logo_img]]];
    // 商家名字
    self.shopNameL.text = commonM.mname;
    // 订单编号
    self.goodsOrderNum.text = commonM.order_id;
    // 商品图片
    [self.goodsImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,commonM.img]]];
    // 商品名
    self.goodsName.text = commonM.name;
    // 商品数量
    self.goodsCountL.text = commonM.num;
    // 商品介绍
    self.goodsSubL.text = commonM.attr_value[1];
    // 商品价格
    self.goodsPriceL.text = commonM.price;
    // 合计
    // 总价
    self.totalPriceL.text = commonM.pay_money;
    
}

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHCommonCellID = @"ZBNSHCommonCellID";
    ZBNSHCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHCommonCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHCommonCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    [super setFrame:frame];
}




// rgba(97, 194, 156, 1)绿色  rgba(150, 150, 150, 1)灰色  rgba(97, 194, 156, 1)下划线
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.firButton.layer.cornerRadius = 10;
    self.firButton.layer.borderWidth = 1;
    self.secButton.layer.cornerRadius = 10;
     self.secButton.layer.borderWidth = 1;
    self.thiButton.layer.cornerRadius = 10;
     self.thiButton.layer.borderWidth = 1;
    
}

@end
