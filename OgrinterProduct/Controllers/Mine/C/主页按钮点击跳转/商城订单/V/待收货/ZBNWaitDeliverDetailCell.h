//
//  ZBNWaitDeliverDetailCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNWaitDeliverDetailCell : UITableViewCell
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, copy) void(^beSureReciveGoodsBtnClickTask)(void);
@property (nonatomic, copy) void(^returnGoodsBtnClickTask)(void);
@end

NS_ASSUME_NONNULL_END
