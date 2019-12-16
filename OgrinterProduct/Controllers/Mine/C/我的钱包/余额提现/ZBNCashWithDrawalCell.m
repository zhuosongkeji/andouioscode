//
//  ZBNCashWithDrawalCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNCashWithDrawalCell.h"

@implementation ZBNCashWithDrawalCell


+ (instancetype)regiserCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNCashWithDrawalCellID = @"cashCell";
    ZBNCashWithDrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNCashWithDrawalCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNCashWithDrawalCell" owner:nil options:nil].lastObject;
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
