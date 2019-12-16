//
//  ZBNOrderDetailCellOne.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNOrderDetailCellOne.h"

@implementation ZBNOrderDetailCellOne

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNOrderDetailCellOneID = @"oneCellID";
    ZBNOrderDetailCellOne *cell = [tableView dequeueReusableCellWithIdentifier:ZBNOrderDetailCellOneID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNOrderDetailCellOne" owner:nil options:nil].lastObject;
    }
    return cell;
}


@end
