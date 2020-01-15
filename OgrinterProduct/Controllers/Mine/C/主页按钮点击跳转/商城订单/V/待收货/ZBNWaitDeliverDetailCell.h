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

/*! 收货 */
@property (nonatomic, copy) void(^beSureReciveGoodsBtnClickTask)(void);
/*! 退货 */
@property (nonatomic, copy) void(^returnGoodsBtnClickTask)(void);
/*! 查看物流 */
@property (nonatomic, copy) void(^viewLogisticsBtnClickTask)(void);

@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailM;
@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;




@end

NS_ASSUME_NONNULL_END
