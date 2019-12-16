//
//  ZBNMyAddressCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyAddressCell.h"
#import "ZBNMyAddressModel.h"

@interface ZBNMyAddressCell ()
/*! 用户名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/*! 电话号码 */
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
/*! 地址 */
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
/*! 设置默认地址的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *defaultAddButton;

@end

@implementation ZBNMyAddressCell

#pragma mark - 注册以及数据设置

/*! 注册cell */
+ (instancetype)registerCellForTable:(UITableView *)tableView
{
    static NSString  * const addressCellID = @"addressCellID";
    ZBNMyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCellID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMyAddressCell" owner:nil options:nil].lastObject;
    }
    return cell;
}
/*! 设置模型数据 */
- (void)setAddModel:(ZBNMyAddressModel *)addModel
{
    
    if (addModel.isSelcted) {
        self.defaultAddButton.selected = YES;
    } else {
        self.defaultAddButton.selected = NO;
    }
    _addModel = addModel;
}


#pragma mark - 按钮的点击事件
/*! 默认地址按钮的点击 */
- (IBAction)defaultBtnClick:(UIButton *)sender {
    // 如果block有值,那么我们将模型传出去让外界判断按钮的状态
    if (self.DefaultClickTask) {
        self.DefaultClickTask(self.addModel);
    }
}
/*! 删除按钮的点击 */
- (IBAction)deleteBtnClick:(UIButton *)sender {
    
}
/*! 编辑按钮的点击 */
- (IBAction)editBtnClick:(UIButton *)sender {
    
}



@end
