//
//  ZBNCommenOrderCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNCommenOrderCell.h"
#import "ZBNOrderModel.h"

@interface ZBNCommenOrderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userIconV;
@property (weak, nonatomic) IBOutlet UILabel *userNameL;

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *payStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *orderDetailBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;



@end

@implementation ZBNCommenOrderCell


/*! 订单详情点击 */
- (IBAction)orderBtnClick:(UIButton *)sender {
    if (self.orderDetailClickTask) {
        self.orderDetailClickTask();
    }
}


- (IBAction)payBtnClick:(UIButton *)sender {
}


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





@end
