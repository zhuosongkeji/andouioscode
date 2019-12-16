//
//  ZBNRechargeCellTwo.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCellTwo.h"

@implementation ZBNRechargeCellTwo

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNRechargeCellTwoID = @"twoCell";
    ZBNRechargeCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRechargeCellTwoID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRechargeCellTwo" owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
