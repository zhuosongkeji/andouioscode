//
//  ZBNSHDeliverGoodsOrderCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHDeliverGoodsOrderCell.h"



@interface ZBNSHDeliverGoodsOrderCell ()



@end

@implementation ZBNSHDeliverGoodsOrderCell


/*! 待发货订单详情按钮的点击 */
- (IBAction)waitDeliverBtnClick:(UIButton *)sender {
    
    if (self.waitDeliverBtnClickTask) {
        self.waitDeliverBtnClickTask();
    }
}


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHDeliverGoodsOrderCellID = @"DeliverGoodsCellID";
    ZBNSHDeliverGoodsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHDeliverGoodsOrderCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHDeliverGoodsOrderCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
