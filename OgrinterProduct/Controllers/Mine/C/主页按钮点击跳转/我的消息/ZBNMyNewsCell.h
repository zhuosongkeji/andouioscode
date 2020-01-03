//
//  ZBNMyNewsCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNMyNewsModel;
@interface ZBNMyNewsCell : UITableViewCell

/*! 注册cell */
+ (instancetype)registerCellForTable:(UITableView *)tableView;

/*! 模型 */
@property (nonatomic, strong) ZBNMyNewsModel *news;

@end

NS_ASSUME_NONNULL_END
