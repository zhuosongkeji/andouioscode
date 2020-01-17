//
//  ZBNRTComDetailCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNRTComDetailCell.h"
#import "ZBNRTFoodsModel.h"


@interface ZBNRTComDetailCell ()

/*! 菜品图 */
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
/*! 菜品名 */
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
/*! 菜品名 */
@property (weak, nonatomic) IBOutlet UILabel *num;
/*! 菜品金额 */
@property (weak, nonatomic) IBOutlet UILabel *price;


@end


@implementation ZBNRTComDetailCell


- (void)setDetailM:(ZBNRTFoodsModel *)detailM
{
    _detailM = detailM;
    
    self.goods_name.text = detailM.name;
    self.num.text = [NSString stringWithFormat:@"x%@",detailM.num];
    self.price.text = [NSString stringWithFormat:@"¥%@",detailM.price];
    [self.goods_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imgServer,detailM.image]]];
}


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNRTComDetailCellID = @"ZBNRTComDetailCellID";
    ZBNRTComDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRTComDetailCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRTComDetailCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
