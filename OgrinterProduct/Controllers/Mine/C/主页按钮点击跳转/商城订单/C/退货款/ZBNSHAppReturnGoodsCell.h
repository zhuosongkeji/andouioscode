//
//  ZBNSHAppReturnGoodsCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNSHOrderDetailsM.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHAppReturnGoodsCell : UITableViewCell
/*! 模型 */
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailsM;
/*! 订单编号 */
@property (nonatomic, copy) NSString *orderNum;
@end

NS_ASSUME_NONNULL_END
