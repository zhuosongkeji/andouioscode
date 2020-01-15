//
//  ZBNRestaurantOrderDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRestaurantOrderDetailCell.h"

@implementation ZBNRestaurantOrderDetailCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNRestaurantOrderDetailCellID = @"SHWaitPayDetailCell";
    ZBNRestaurantOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRestaurantOrderDetailCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRestaurantOrderDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
