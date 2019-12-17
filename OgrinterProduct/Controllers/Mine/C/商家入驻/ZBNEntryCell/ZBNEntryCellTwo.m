//
//  ZBNEntryCellTwo.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNEntryCellTwo.h"

@interface ZBNEntryCellTwo ()


@end

@implementation ZBNEntryCellTwo


+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNEntryCellTwoID = @"TwoCell";
    ZBNEntryCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:ZBNEntryCellTwoID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNEntryCellTwo" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
