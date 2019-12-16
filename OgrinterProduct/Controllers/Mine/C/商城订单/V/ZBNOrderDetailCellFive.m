//
//  ZBNOrderDetailCellFive.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNOrderDetailCellFive.h"

@implementation ZBNOrderDetailCellFive

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNOrderDetailCellFiveID = @"fiveCellID";
    ZBNOrderDetailCellFive *cell = [tableView dequeueReusableCellWithIdentifier:ZBNOrderDetailCellFiveID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNOrderDetailCellFive" owner:nil options:nil].lastObject;
    }
    return cell;
}


@end
