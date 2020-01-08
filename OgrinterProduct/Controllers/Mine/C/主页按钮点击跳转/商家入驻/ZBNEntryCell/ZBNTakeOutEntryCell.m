//
//  ZBNTakeOutEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTakeOutEntryCell.h"

@implementation ZBNTakeOutEntryCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNTakeOutEntryCellID = @"ZBNTakeOutEntryCellID";
    ZBNTakeOutEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNTakeOutEntryCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNTakeOutEntryCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
