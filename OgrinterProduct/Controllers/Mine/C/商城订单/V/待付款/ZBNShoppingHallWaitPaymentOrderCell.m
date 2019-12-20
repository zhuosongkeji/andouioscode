//
//  ZBNShoppingHallWaitPaymentOrderCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNShoppingHallWaitPaymentOrderCell.h"

@implementation ZBNShoppingHallWaitPaymentOrderCell



- (IBAction)goAndPayBtnClick:(UIButton *)sender {
    
    if (self.goAndPayBtnClickTask) {
        self.goAndPayBtnClickTask();
    }
}
/*! 定单详情点击 */
- (IBAction)orderDetailBtnClick:(UIButton *)sender {
    if (self.orderDetailBtnClickTask) {
        self.orderDetailBtnClickTask();
    }
}




+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNShoppingHallWaitPaymentOrderCellID = @"ZBNSHWaitReceivingGoodsOrderCellID";
    ZBNShoppingHallWaitPaymentOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShoppingHallWaitPaymentOrderCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNShoppingHallWaitPaymentOrderCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
