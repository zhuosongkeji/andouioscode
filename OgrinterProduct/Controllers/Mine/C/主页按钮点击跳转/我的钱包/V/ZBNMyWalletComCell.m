//
//  ZBNMyWalletComCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyWalletComCell.h"
#import "ZBNMyIntegralModel.h"
#import "ZBNCostModel.h"
#import "ZBNReChargeDetailModel.h"

@interface ZBNMyWalletComCell ()

/*! 流动描述的label */
@property (weak, nonatomic) IBOutlet UILabel *describeL;
/*! 流动时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeL;
/*! 流动金额 */
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end


@implementation ZBNMyWalletComCell

/*! 设置积分模型数据 */
- (void)setIntegerM:(ZBNMyIntegralModel *)integerM
{
    _integerM = integerM;
    
    self.describeL.text = integerM.describe;
    self.timeL.text = integerM.create_time;
    self.priceL.text = integerM.price;
    
}

/*! 设置余额明细模型" */
- (void)setCostM:(ZBNCostModel *)costM
{
    _costM = costM;
    
    self.describeL.text = costM.describe;
    self.timeL.text = costM.create_time;
    if ([costM.state intValue] == 1) {
        self.priceL.text = [NSString stringWithFormat:@"+%@",costM.price];
    } else if ([costM.state intValue] == 2) {
        self.priceL.text = [NSString stringWithFormat:@"-%@",costM.price];
    }
}

/*! 设置提现明细的模型 */
- (void)setDetailM:(ZBNReChargeDetailModel *)DetailM
{
    _DetailM = DetailM;
    self.describeL.text = DetailM.describe;
    self.timeL.text = DetailM.create_time;
    if ([DetailM.state intValue] == 1) {
        self.priceL.text = [NSString stringWithFormat:@"+%@",DetailM.price];
    } else if ([DetailM.state intValue] == 2) {
        self.priceL.text = [NSString stringWithFormat:@"-%@",DetailM.price];
    }
}

/*! 注册cell */
+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNMyWalletComCellID = @"commonCell";
    ZBNMyWalletComCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyWalletComCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMyWalletComCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= 0.5;
    [super setFrame:frame];
}


@end
