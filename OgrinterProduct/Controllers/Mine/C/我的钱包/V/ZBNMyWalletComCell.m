//
//  ZBNMyWalletComCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyWalletComCell.h"

@implementation ZBNMyWalletComCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNMyWalletComCellID = @"commonCell";
    ZBNMyWalletComCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyWalletComCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMyWalletComCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
