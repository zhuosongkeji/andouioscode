//
//  ZBNRTCommentVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNRTCommentVC : UITableViewController

/*! 订单号 */
@property (nonatomic, copy) NSString *order_id;
/*! 商户ID */
@property (nonatomic, copy) NSString *merchants_id;

@end

NS_ASSUME_NONNULL_END
