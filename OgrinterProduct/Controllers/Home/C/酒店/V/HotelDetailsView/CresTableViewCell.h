//
//  CresTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/8.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef void(^didselectButtonBlock)(UIButton *btn);

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CresTableViewCell : UITableViewCell

@property (nonatomic,copy)didselectButtonBlock selectbtnBlock;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
