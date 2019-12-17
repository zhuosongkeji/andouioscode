//
//  ZBNEntryCellOne.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNEntryCellOne.h"


@interface ZBNEntryCellOne ()



@end

@implementation ZBNEntryCellOne


+ (instancetype)registerCellForTableView:(UITableView *)tableView 
{
    static NSString * const ZBNEntryCellOneID = @"OneCell";
    ZBNEntryCellOne *cell = [tableView dequeueReusableCellWithIdentifier:ZBNEntryCellOneID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNEntryCellOne" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
