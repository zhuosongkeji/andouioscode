//
//  ZBNSHOrderCanceledCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSHOrderDetailComM;
@interface ZBNSHOrderCanceledCell : UITableViewCell

@property (nonatomic, copy) void(^returnGoodsClickTask)(ZBNSHOrderCanceledCell *cell);
@property (nonatomic, strong) ZBNSHOrderDetailComM *detailM;

@end

NS_ASSUME_NONNULL_END
