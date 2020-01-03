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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
/*! 设置模型数据 */
- (void)setAddModel:(ZBNMyAddressModel *)addModel
{
    _addModel = addModel;
    if (addModel.is_defualt) {
        self.defaultAddButton.selected = YES;
    } else {
        self.defaultAddButton.selected = NO;
    }
    
    self.nameLabel.text = addModel.name;
    self.numberLabel.text = addModel.mobile;
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addModel.province,addModel.city,addModel.area,addModel.address];
    
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
    
    [ZBNAlertTool zbn_alertTitle:@"您确定要删除吗?" type:UIAlertControllerStyleAlert message:@"删老就没得老喔~" didTask:^{
        if (self.deleteAddClickTask) {
            self.deleteAddClickTask(self.addModel);
        }
    }];
    
}


/*! 编辑按钮的点击 */
- (IBAction)editBtnClick:(UIButton *)sender {
    
    
    
}

- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
