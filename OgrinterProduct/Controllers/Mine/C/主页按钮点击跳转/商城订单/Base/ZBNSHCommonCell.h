//
//  ZBNSHCommonCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBNSHCommonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHCommonCell : UITableViewCell
/*! 模型数据 */
@property (nonatomic, strong) ZBNSHCommonModel *commonM;

+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, copy) void(^firBtnClickTask)(void);
@property (nonatomic, copy) void(^secBtnClickTask)(void);
@property (nonatomic, copy) void(^thiBtnClickTask)(void);

@end

NS_ASSUME_NONNULL_END
