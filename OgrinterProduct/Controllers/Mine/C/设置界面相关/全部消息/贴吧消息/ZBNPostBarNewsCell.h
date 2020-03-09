//
//  ZBNPostBarNewsCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNMyAllNewsModel;
@interface ZBNPostBarNewsCell : UITableViewCell
@property (nonatomic, strong) ZBNMyAllNewsModel *model;
/*! 注册cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
