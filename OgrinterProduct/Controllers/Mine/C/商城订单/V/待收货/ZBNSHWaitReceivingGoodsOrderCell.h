//
//  ZBNSHWaitReceivingGoodsOrderCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/19.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHWaitReceivingGoodsOrderCell : UITableViewCell
+ (instancetype)regiserCellForTable:(UITableView *)tableView;



@property (nonatomic, copy) void(^orderDetailBtnClickTask)(void);
// beSureRecivedGoodsBtnClick
@property (nonatomic, copy) void(^beSureRecivedGoodsBtnClickTask)(void);

@end

NS_ASSUME_NONNULL_END
