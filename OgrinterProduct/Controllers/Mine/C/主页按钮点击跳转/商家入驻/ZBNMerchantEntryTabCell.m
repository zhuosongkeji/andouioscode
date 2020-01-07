//
//  ZBNMerchantEntryTabCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNMerchantEntryTabCell.h"


@interface ZBNMerchantEntryTabCell ()

/*! 外卖商家 */
@property (weak, nonatomic) IBOutlet UIView *take_outFoodV;
/*! 酒店商家 */
@property (weak, nonatomic) IBOutlet UIView *hotelV;
/*! 商城商家 */
@property (weak, nonatomic) IBOutlet UIView *shoppingHallV;

@end



@implementation ZBNMerchantEntryTabCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置手势
    [self setupGes];
}


- (void)setupGes
{
    UITapGestureRecognizer *shGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingHallClick)];
    [self.shoppingHallV addGestureRecognizer:shGes];
}

- (void)shoppingHallClick
{
    if (self.shoppingHallClickTask) {
        self.shoppingHallClickTask();
    }
}




+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNMerchantEntryTabCellID = @"ZBNMerchantEntryTabCellID";
    ZBNMerchantEntryTabCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMerchantEntryTabCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMerchantEntryTabCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
