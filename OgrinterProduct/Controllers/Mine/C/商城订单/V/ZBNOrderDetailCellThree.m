//
//  ZBNOrderDetailCellThree.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNOrderDetailCellThree.h"

@implementation ZBNOrderDetailCellThree

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNOrderDetailCellThreeID = @"threeCellID";
    ZBNOrderDetailCellThree *cell = [tableView dequeueReusableCellWithIdentifier:ZBNOrderDetailCellThreeID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNOrderDetailCellThree" owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
