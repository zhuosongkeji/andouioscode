//
//  ZBNRechargeCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCell.h"

@interface ZBNRechargeCell ()


@property (weak, nonatomic) IBOutlet UIView *LabelView;


@end

@implementation ZBNRechargeCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNRechargeCellID = @"oneCell";
    ZBNRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRechargeCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRechargeCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.LabelView.layer.cornerRadius = 15 * 0.5;
}

@end
