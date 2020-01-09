//
//  ZBNSHGoAndEvaluateCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSHGoAndEvaluateModel;
@interface ZBNSHGoAndEvaluateCell : UITableViewCell
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, strong) ZBNSHGoAndEvaluateModel *model;
@end

NS_ASSUME_NONNULL_END
