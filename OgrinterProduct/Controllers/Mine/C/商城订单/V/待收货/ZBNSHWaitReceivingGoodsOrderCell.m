//
//  ZBNSHWaitReceivingGoodsOrderCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHWaitReceivingGoodsOrderCell.h"

@implementation ZBNSHWaitReceivingGoodsOrderCell


- (IBAction)orderDetailBtnClick:(UIButton *)sender {
    if (self.orderDetailBtnClickTask) {
        self.orderDetailBtnClickTask();
    }
}


- (IBAction)beSureRecivedGoodsBtnClick:(UIButton *)sender {
    if (self.beSureRecivedGoodsBtnClickTask) {
        self.beSureRecivedGoodsBtnClickTask();
    }
}


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHWaitReceivingGoodsOrderCellID = @"ZBNSHWaitReceivingGoodsOrderCellID";
    ZBNSHWaitReceivingGoodsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHWaitReceivingGoodsOrderCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHWaitReceivingGoodsOrderCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
