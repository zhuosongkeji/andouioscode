//
//  ZBNLocationCell.m
//  Gaode
//
//  Created by 周芳圆 on 2020/3/1.
//  Copyright © 2020 ZhouBunian. All rights reserved.
//

#import "ZBNLocationCell.h"
#import "ZBNSearchAddrM.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface ZBNLocationCell ()

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *detail;


@end

@implementation ZBNLocationCell


- (void)setModel:(ZBNSearchAddrM *)model
{
    _model = model;
    self.name.text = model.name;
    if ([model.province isEqualToString:model.city]) {
        self.detail.text = [NSString stringWithFormat:@"%@%@%@",model.city,model.district,model.address];
    } else {
        self.detail.text = [NSString stringWithFormat:@"%@%@%@%@%@",model.province,model.city,model.district,model.name,model.address];
    }
    if (model.isSelected) {
        [self.name setTextColor:[UIColor colorWithRed:94/255.0  green:211/255.0  blue:174/255.0 alpha:1]];
    } else {
        [self.name setTextColor:[UIColor blackColor]];
    }
}

- (void)setTip:(AMapTip *)tip
{
    _tip = tip;
    self.name.text = tip.name;
    self.detail.text = [NSString stringWithFormat:@"%@%@",tip.district,tip.address];
}

+ (instancetype)registerCellForTable:(UITableView *)tableView
{
    static NSString * const ID = @"ZBNLocationCellID";
    ZBNLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNLocationCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
