//
//  ZBNSHComViewLogisticsVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHComViewLogisticsVC : UITableViewController

/*! 快递公司ID */
@property (nonatomic, copy) NSString *express_id;
/*! 快递单号 */
@property (nonatomic, copy) NSString *courier_num;


@end

NS_ASSUME_NONNULL_END
