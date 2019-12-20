//
//  ZBNSHGoAndPayDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHGoAndPayDetailCell.h"

@implementation ZBNSHGoAndPayDetailCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHGoAndPayDetailCellID = @"ZBNSHWaitReceivingGoodsOrderCellID";
    ZBNSHGoAndPayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHGoAndPayDetailCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHGoAndPayDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
