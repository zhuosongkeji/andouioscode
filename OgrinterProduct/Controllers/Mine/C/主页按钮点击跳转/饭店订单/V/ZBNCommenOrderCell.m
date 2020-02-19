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
    
    [self.dataArr addObjectsFromArray:comM.foods];
    [self.shop_logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,comM.logo_img]]];
    self.shop_name.text = comM.name;
    self.order_sn.text = comM.order_sn;
    self.total_price.text = [NSString stringWithFormat:@"¥%@",comM.prices];
    
    if (comM.status.intValue == 10) {
        [self.state setText:@"未支付"];
    } else if (comM.status.intValue == 30) {
        [self.state setText:@"已使用"];
    } else if (comM.status.intValue == 40) {
        [self.state setText:@"待评价"];
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
    self.order_detailBtn.layer.cornerRadius = 10;
    self.order_detailBtn.layer.borderWidth = 1;
    self.order_detailBtn.layer.borderColor = KSRGBA(97, 194, 156, 1).CGColor;
    [self.order_detailBtn setTitleColor:KSRGBA(97, 194, 156, 1) forState:UIControlStateNormal];
    
}

#pragma mark -- 事件处理

/*! 订单详情点击 */
- (IBAction)detailBtnClick:(UIButton *)sender {
    if (self.detailBtnClickTask) {
        self.detailBtnClickTask();
    }
    
    ZBNRTComDetailVC *vc = [[ZBNRTComDetailVC alloc] init];
    vc.order_id = self.comM.ID;
    [[self viewController].navigationController pushViewController:vc animated:YES];
    
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
    static NSString * const ZBNCommenOrderCellID = @"OrderCommenCell";
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
