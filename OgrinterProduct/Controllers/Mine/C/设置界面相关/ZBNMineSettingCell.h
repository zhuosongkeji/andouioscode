//
//  ZBNMineSettingCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNMineSettingModel;
@interface ZBNMineSettingCell : UITableViewCell
/*! 当点击关于我们 */
@property (nonatomic, copy) void(^aboutUsCellClickTask)(void);
/*! 问题反馈 */
@property (nonatomic, copy) void(^feedbackClickTask)(void);

/*! 注册Cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

/*! 设置界面的模型 */
@property (nonatomic, strong) ZBNMineSettingModel *settingM;

@end

NS_ASSUME_NONNULL_END
