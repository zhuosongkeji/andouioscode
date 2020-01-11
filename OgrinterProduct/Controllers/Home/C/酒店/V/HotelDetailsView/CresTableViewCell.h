//
//  CresTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/8.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <UIKit/UIKit.h>


@class MsgModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^didselectButtonBlock)(UIButton *btn);

@interface CresTableViewCell : UITableViewCell

@property (nonatomic,copy)didselectButtonBlock selectbtnBlock;

@property(nonatomic,strong)MsgModel *listmodels;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
