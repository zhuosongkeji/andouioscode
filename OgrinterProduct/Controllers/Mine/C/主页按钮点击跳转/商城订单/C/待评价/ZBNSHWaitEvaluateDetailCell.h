//
//  ZBNSHWaitEvaluateDetailCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSHOrderUserInfoM, ZBNSHOrderDetailsM, ZBNSHOrderDetailComM;
@interface ZBNSHWaitEvaluateDetailCell : UITableViewCell
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailM;
@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;


@property (nonatomic, copy) void(^returnGoodsBtnClickTask)(void);

@end

NS_ASSUME_NONNULL_END
