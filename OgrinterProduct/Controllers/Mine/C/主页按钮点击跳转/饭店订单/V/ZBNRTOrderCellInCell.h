//
//  ZBNRTOrderCellInCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBNRTFoodsModel;
@interface ZBNRTOrderCellInCell : UITableViewCell
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, strong) ZBNRTFoodsModel *foodsM;

@end

NS_ASSUME_NONNULL_END
