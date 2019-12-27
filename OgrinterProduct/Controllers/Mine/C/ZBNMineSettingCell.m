//
//  ZBNMineSettingCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineSettingCell.h"

@implementation ZBNMineSettingCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNMineSettingCellID = @"ZBNMineSettingCellID";
    ZBNMineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMineSettingCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMineSettingCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
