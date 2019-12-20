//
//  ZBNSHWriteLogisticsListCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHWriteLogisticsListCell.h"

@implementation ZBNSHWriteLogisticsListCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHWriteLogisticsListCellID = @"ZBNSHWriteLogisticsListCellID";
    ZBNSHWriteLogisticsListCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHWriteLogisticsListCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHWriteLogisticsListCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
