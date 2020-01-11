//
//  ZBNSHComViewLogisticsCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/10.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSHDetailLogisticsModel;
@interface ZBNSHComViewLogisticsCell : UITableViewCell
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

/*! 模型数据 */
@property (nonatomic, strong) ZBNSHDetailLogisticsModel *detailM;

@end

NS_ASSUME_NONNULL_END
