//
//  ZBNRechargeCellFour.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCellFour.h"

@implementation ZBNRechargeCellFour

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNRechargeCellFourID = @"fourCell";
    ZBNRechargeCellFour *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRechargeCellFourID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRechargeCellFour" owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
