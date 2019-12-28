//
//  ZBNWaitDeliverDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNWaitDeliverDetailCell.h"

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

@end
