//
//  ZBNShoppingMallEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNShoppingMallEntryCell.h"



@interface ZBNShoppingMallEntryCell ()

/*! 商家名 */
@property (weak, nonatomic) IBOutlet UITextField *shopNameInput;
/*! 联系人名称 */
@property (weak, nonatomic) IBOutlet UITextField *name;
/*! 联系人电话 */
@property (weak, nonatomic) IBOutlet UITextField *phone;
/*! 店铺地址 */
@property (weak, nonatomic) IBOutlet UITextField *address_id;
/*! 店铺详细地址 */
@property (weak, nonatomic) IBOutlet UITextField *detailAdd;
/*! 商家简介 */
@property (weak, nonatomic) IBOutlet UITextView *shopIntrol;
/*! 商家海报图 */

/*! 商家LOGO图 */

/*! 营业执照 */

@end

@implementation ZBNShoppingMallEntryCell























#pragma mark -- 注册cell

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNShoppingMallEntryCellID = @"ZBNShoppingMallEntryCellID";
    ZBNShoppingMallEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNShoppingMallEntryCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNShoppingMallEntryCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end
