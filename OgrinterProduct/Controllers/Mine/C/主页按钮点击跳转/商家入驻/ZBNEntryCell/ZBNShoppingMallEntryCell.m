//
//  ZBNShoppingMallEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNShoppingMallEntryCell.h"

@implementation ZBNShoppingMallEntryCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNShoppingMallEntryCellID = @"ZBNShoppingMallEntryCellID";
    ZBNShoppingMallEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShoppingMallEntryCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNShoppingMallEntryCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
