//
//  OnlineTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnlineTableViewCell : UITableViewCell


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)configTempCellWith:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
