//
//  ZBNMyAllNewsCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNMyAllNewsModel;
@interface ZBNMyAllNewsCell : UITableViewCell

/*! 注册Cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, strong) ZBNMyAllNewsModel *allM;

@end

NS_ASSUME_NONNULL_END
