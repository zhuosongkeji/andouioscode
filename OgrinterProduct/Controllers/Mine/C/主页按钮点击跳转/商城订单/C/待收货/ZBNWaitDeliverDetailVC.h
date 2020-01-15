//
//  ZBNWaitDeliverDetailVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNWaitDeliverDetailVC : UITableViewController

/*! 订单号 */
@property (nonatomic, copy) NSString *getOrderNum;
/*! 快递单号 */
@property (nonatomic, copy) NSString *courier_num;
/*! 快递公司ID */
@property (nonatomic, copy) NSString *express_id;
/*! ID */
@property (nonatomic, copy) NSString *order_goods_id;

@end

NS_ASSUME_NONNULL_END
