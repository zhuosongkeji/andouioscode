//
//  ZBNHTComCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/11.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNHTComModel;
@interface ZBNHTComCell : UITableViewCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView;

/*! 模型数据 */
@property (nonatomic, strong) ZBNHTComModel *comM;


@end

NS_ASSUME_NONNULL_END
