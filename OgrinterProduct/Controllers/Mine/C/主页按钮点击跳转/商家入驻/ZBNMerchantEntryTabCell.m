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
    // 商城商家入驻
    UITapGestureRecognizer *shGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shoppingHallClick)];
    [self.shoppingHallV addGestureRecognizer:shGes];
    // 酒店商家入驻
    UITapGestureRecognizer *hotleGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotleViewClick)];
    [self.hotelV addGestureRecognizer:hotleGes];
    // 饭店商家入驻
    UITapGestureRecognizer *takeGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeViewClick)];
    [self.take_outFoodV addGestureRecognizer:takeGes];
}

- (void)shoppingHallClick
{
    if (self.shoppingHallClickTask) {
        self.shoppingHallClickTask();
    }
}

- (void)hotleViewClick
{
    if (self.hotleViewClickTask) {
        self.hotleViewClickTask();
    }
}

- (void)takeViewClick
{
    if (self.takeViewClickTask) {
        self.takeViewClickTask();
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
