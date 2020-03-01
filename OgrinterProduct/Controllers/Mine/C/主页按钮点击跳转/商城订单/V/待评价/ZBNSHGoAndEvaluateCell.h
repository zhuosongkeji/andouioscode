//
//  ZBNSHGoAndEvaluateCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHGoAndEvaluateCell : UITableViewCell
/*! 快速获取 */
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

/*! 发表评论按钮点击 */
@property (nonatomic, copy) void(^commentBtnClickTask)(void);

@end

NS_ASSUME_NONNULL_END
