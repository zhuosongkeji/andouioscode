//
//  ZBNMyWalletComCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyWalletComCell.h"
#import "ZBNMyIntegralModel.h"

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
