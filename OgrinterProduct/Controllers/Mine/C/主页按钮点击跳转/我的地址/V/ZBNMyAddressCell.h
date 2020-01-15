//
//  ZBNMyAddressCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class ZBNMyAddressCell;
@protocol ZBNMyAddressCellDelegate <NSObject>

- (void) ZBNMyAddressCellDidClickChangeButton:(ZBNMyAddressCell *)cell;

@end

@class ZBNMyAddressModel;
/*! 传入地址cell模型 */
typedef void(^DefaultBtnClickTask)(ZBNMyAddressModel *model);

@interface ZBNMyAddressCell : UITableViewCell
/*! 模型 */
@property (nonatomic, strong) ZBNMyAddressModel *addModel;
/*! 点击设置默认地址按钮的Block */
@property (nonatomic, copy) DefaultBtnClickTask DefaultClickTask;

@property (nonatomic, copy) void(^deleteAddClickTask)(ZBNMyAddressModel *model);
/*! 注册cell */
+ (instancetype)registerCellForTable:(UITableView *)tableView;

@property (nonatomic, weak) id<ZBNMyAddressCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
