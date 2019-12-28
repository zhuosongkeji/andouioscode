//
//  ZBNMineSettingCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMineSettingCell : UITableViewCell
/*! 当点击关于我们 */
@property (nonatomic, copy) void(^aboutUsCellClickTask)(void);
/*! 注册Cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
