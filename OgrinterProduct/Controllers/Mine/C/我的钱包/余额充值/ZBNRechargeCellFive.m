//
//  ZBNRechargeCellFive.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/18.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCellFive.h"

@implementation ZBNRechargeCellFive

+ (instancetype)registerCleeForTableView:(UITableView *)tableView
{
    static NSString * const ZBNRechargeCellFiveID = @"fiveCell";
    ZBNRechargeCellFive *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRechargeCellFiveID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRechargeCellFive" owner:nil options:nil].lastObject;
    }
    return cell;
}

@end
