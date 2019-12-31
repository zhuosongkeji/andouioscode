//
//  ZBNHotelEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNHotelEntryCell.h"

@implementation ZBNHotelEntryCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNHotelEntryCellID = @"ZBNHotelEntryCellID";
    ZBNHotelEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNHotelEntryCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHotelEntryCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
