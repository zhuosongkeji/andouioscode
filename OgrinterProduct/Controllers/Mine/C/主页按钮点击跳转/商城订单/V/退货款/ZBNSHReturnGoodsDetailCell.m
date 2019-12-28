//
//  ZBNSHReturnGoodsDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHReturnGoodsDetailCell.h"

@implementation ZBNSHReturnGoodsDetailCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHReturnGoodsDetailCellID = @"ZBNSHReturnGoodsDetailCellID";
    ZBNSHReturnGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHReturnGoodsDetailCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHReturnGoodsDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
