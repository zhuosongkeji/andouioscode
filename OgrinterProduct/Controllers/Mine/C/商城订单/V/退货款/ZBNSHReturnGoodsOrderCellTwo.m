//
//  ZBNSHReturnGoodsOrderCellTwo.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsOrderCellTwo.h"

@implementation ZBNSHReturnGoodsOrderCellTwo

/*! 定单详情点击 */
- (IBAction)orderDetailBtnClick:(UIButton *)sender {
    if (self.orderBtnlClickTask) {
        self.orderBtnlClickTask();
    }
}


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHReturnGoodsOrderCellTwoID = @"ReturnGoodsCellTwo";
    ZBNSHReturnGoodsOrderCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHReturnGoodsOrderCellTwoID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHReturnGoodsOrderCellTwo" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
