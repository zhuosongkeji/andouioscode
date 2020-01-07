//
//  ZBNWaitDeliverDetailCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBNSHOrderUserInfoM, ZBNSHOrderDetailsM, ZBNSHOrderDetailComM;
@interface ZBNWaitDeliverDetailCell : UITableViewCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, copy) void(^beSureReciveGoodsBtnClickTask)(void);
@property (nonatomic, copy) void(^returnGoodsBtnClickTask)(void);

@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailM;
@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;


@end

NS_ASSUME_NONNULL_END
