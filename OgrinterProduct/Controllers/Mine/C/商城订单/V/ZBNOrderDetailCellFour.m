//
//  ZBNOrderDetailCellFour.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNOrderDetailCellFour.h"

@implementation ZBNOrderDetailCellFour

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNOrderDetailCellFourID = @"fourCellID";
    ZBNOrderDetailCellFour *cell = [tableView dequeueReusableCellWithIdentifier:ZBNOrderDetailCellFourID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNOrderDetailCellFour" owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
