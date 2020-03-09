//
//  ZBNCommenOrderCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNCommenOrderCell.h"
#import "ZBNRTOrderCellInCell.h"
#import "ZBNRTComModel.h"
#import "ZBNRTFoodsModel.h"
#import "ZBNRTComDetailVC.h"
#import "ZBNRTPayVC.h" // 支付控制器
#import "ZBNRTCommentVC.h"

@interface ZBNCommenOrderCell () <UITableViewDelegate, UITableViewDataSource>

/*! table */
@property (weak, nonatomic) IBOutlet UITableView *myTable;
/*! contentView */
@property (weak, nonatomic) IBOutlet UIView *tableBack;
/*! 店铺图 */
@property (weak, nonatomic) IBOutlet UIImageView *shop_logo;
/*! 店铺名 */
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
/*! 订单号 */
@property (weak, nonatomic) IBOutlet UILabel *order_sn;
/*! 状态label */
@property (weak, nonatomic) IBOutlet UILabel *state;
/*! 总计 */
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
/*! 总价格 */
@property (weak, nonatomic) IBOutlet UILabel *total_price;
/*! 订单详情按钮 */
@property (weak, nonatomic) IBOutlet UIButton *order_detailBtn;
/*! 内部cell数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;

/*! 立即支付按钮 */
@property (weak, nonatomic) IBOutlet UIButton *payBtn;


@end

@implementation ZBNCommenOrderCell


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

- (void)setComM:(ZBNRTComModel *)comM
{
    _comM = comM;
    
    self.dataArr = comM.foods;
    [self.shop_logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comM.logo_img]]];
    self.shop_name.text = comM.name;
    self.order_sn.text = comM.order_sn;
    self.total_price.text = [NSString stringWithFormat:@"¥%@",comM.prices];
    
    if (comM.status.intValue == 0) {
        [self.state setText:@"已取消"];
        self.payBtn.hidden = YES;
    }
    if (comM.status.intValue == 10) { // 未支付
        [self.state setText:@"待支付"];
        [self.payBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        self.payBtn.hidden = NO;
    } else if (comM.status.intValue == 20) { // 待使用
        [self.state setText:@"待使用"];
        [self.payBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        self.payBtn.hidden = YES;
    } else if (comM.status.intValue == 30) { //待评价
        [self.state setText:@"待评价"];
        [self.payBtn setTitle:@"立即评价" forState:UIControlStateNormal];
        self.payBtn.hidden = NO;
    } else if (comM.status.intValue == 40) { // 已评价
        [self.state setText:@"已评价"];
        self.payBtn.hidden = YES;
    }
    self.totalLabel.text = [NSString stringWithFormat:@"当前有%zd个菜品,合计:",comM.foods.count];

}

#pragma mark -- life

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置代理
    [self setupDelegate];
    
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置边框
    // 订单详情
    self.order_detailBtn.layer.cornerRadius = 10;
    self.order_detailBtn.layer.borderWidth = 1;
    self.order_detailBtn.layer.borderColor = KSRGBA(100, 100, 100, 1).CGColor;
    [self.order_detailBtn setTitleColor:KSRGBA(100, 100, 100, 1) forState:UIControlStateNormal];
    // 立即支付
    self.payBtn.layer.cornerRadius = 10;
    self.payBtn.layer.borderWidth = 1;
    self.payBtn.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
    [self.payBtn setTitleColor:KSRGBA(97, 194, 156, 1) forState:UIControlStateNormal];
    
}

#pragma mark -- 事件处理

/*! 订单详情点击 */
- (IBAction)detailBtnClick:(UIButton *)sender {
    
    if (self.comM.status.intValue == 0) { // 取消的订单详情
        ZBNRTComDetailVC *vc = [[ZBNRTComDetailVC alloc] init];
        vc.order_id = self.comM.ID;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
    
    if ([self.comM.status intValue] == 10) {  // 未支付的订单详情
        ZBNRTComDetailVC *vc = [[ZBNRTComDetailVC alloc] init];
        vc.order_id = self.comM.ID;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    } else if (self.comM.status.intValue == 20) { // 未使用的详情
        // 未支付的订单详情
        ZBNRTComDetailVC *vc = [[ZBNRTComDetailVC alloc] init];
        vc.order_id = self.comM.ID;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    } else if (self.comM.status.intValue == 30) {
        // 订单详情
        ZBNRTComDetailVC *vc = [[ZBNRTComDetailVC alloc] init];
        vc.order_id = self.comM.ID;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    } else if (self.comM.status.intValue == 40) { // 待评价的详情
        // 订单详情
        ZBNRTComDetailVC *vc = [[ZBNRTComDetailVC alloc] init];
        vc.order_id = self.comM.ID;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)payBtnClick:(UIButton *)sender {
    
    if ([self.comM.status intValue] == 10) { // 未支付的去支付
        ZBNRTPayVC *payVC = [[ZBNRTPayVC alloc] init];
        payVC.order_id = self.comM.ID;
        [[self viewController].navigationController pushViewController:payVC animated:YES];
    } else if (self.comM.status.intValue == 20) { // 未使用的取消订单
        NSLog(@"20");
    } else if (self.comM.status.intValue == 30) { // 为评论的去评论
        ZBNRTCommentVC *vc = [[ZBNRTCommentVC alloc] init];
        vc.order_id = self.comM.ID;
        vc.merchants_id = self.comM.merchant_id;
        [[self viewController].navigationController pushViewController:vc animated:YES];
    } else if (self.comM.status.intValue == 40) { // 已评价
        NSLog(@"40");
    }
}


#pragma mark -- 代理&数据源


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ZBNRTOrderCellInCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRTOrderCellInCell" owner:nil options:nil].lastObject;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.foodsM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


#pragma mark -- Other

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNCommenOrderCellID = @"OrderCommenCellID";
    ZBNCommenOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNCommenOrderCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNCommenOrderCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setupDelegate
{
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    [super setFrame:frame];
}

@end
