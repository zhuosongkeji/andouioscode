//
//  ZBNEntryCellThree.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNEntryCellThree.h"

@implementation ZBNEntryCellThree

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNEntryCellThreeID = @"ThreeCell";
    ZBNEntryCellThree *cell = [tableView dequeueReusableCellWithIdentifier:ZBNEntryCellThreeID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNEntryCellThree" owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
