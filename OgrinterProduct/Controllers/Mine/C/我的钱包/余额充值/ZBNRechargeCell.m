//
//  ZBNRechargeCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCell.h"

@implementation ZBNRechargeCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNRechargeCellID = @"oneCell";
    ZBNRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRechargeCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRechargeCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
