//
//  ZBNMyCollectionCommenCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBNMyCollectionM;
@interface ZBNMyCollectionCommenCell : UITableViewCell

/*! 注册cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView;
/*! 模型数据 */
@property (nonatomic, strong) ZBNMyCollectionM *collectionM;

@end

NS_ASSUME_NONNULL_END
