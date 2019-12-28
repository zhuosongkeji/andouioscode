//
//  ZBNSHReturnGoodsOrderCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsOrderCell.h"


@interface ZBNSHReturnGoodsOrderCell ()

@end

@implementation ZBNSHReturnGoodsOrderCell

/*! 查看详情点击 */
- (IBAction)lookDetailBtnClick:(UIButton *)sender {
    if (self.lookDetailBtnlClickTask) {
        self.lookDetailBtnlClickTask();
    }
}



+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHReturnGoodsOrderCellID = @"ReturnGoodsCellOne";
    ZBNSHReturnGoodsOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHReturnGoodsOrderCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHReturnGoodsOrderCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
