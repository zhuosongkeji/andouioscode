//
//  ZBNRTOrderCellInCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTOrderCellInCell.h"
#import "ZBNRTFoodsModel.h"

@interface ZBNRTOrderCellInCell ()
/*! 菜名 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/*! 数量 */
@property (weak, nonatomic) IBOutlet UILabel *num;
/*! 价格 */
@property (weak, nonatomic) IBOutlet UILabel *price;
@end

@implementation ZBNRTOrderCellInCell

- (void)setFoodsM:(ZBNRTFoodsModel *)foodsM
{
    _foodsM = foodsM;
    self.name.text = foodsM.name;
    self.num.text = [NSString stringWithFormat:@"x%@",foodsM.num];
    self.price.text = [NSString stringWithFormat:@"¥%@",foodsM.price];
}



+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNRTOrderCellInCellID = @"ZBNRTOrderCellInCellID";
    ZBNRTOrderCellInCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRTOrderCellInCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRTOrderCellInCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
