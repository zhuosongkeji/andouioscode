//
//  ZBNRTComDetailCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/16.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNRTFoodsModel;
@interface ZBNRTComDetailCell : UITableViewCell
+ (instancetype)regiserCellForTable:(UITableView *)tableView;
@property (nonatomic, strong) ZBNRTFoodsModel *detailM;
@end

NS_ASSUME_NONNULL_END
