//
//  ZBNOrderDetailCellTwo.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNOrderDetailCellTwo.h"

@implementation ZBNOrderDetailCellTwo

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNOrderDetailCellTwoID = @"twoCellID";
    ZBNOrderDetailCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:ZBNOrderDetailCellTwoID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNOrderDetailCellTwo" owner:nil options:nil].lastObject;
    }
    return cell;
}


@end
