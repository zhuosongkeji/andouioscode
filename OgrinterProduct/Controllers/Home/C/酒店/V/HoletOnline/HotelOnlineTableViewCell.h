//
//  HotelOnlineTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BtnSelectBlock)(NSInteger idx);

@class OnlineOrderModel;

@interface HotelOnlineTableViewCell : UITableViewCell

@property(nonatomic,strong)OnlineOrderModel *listmodel;

@property(nonatomic,copy)BtnSelectBlock btnclickBlock;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


- (void)configTempCellWith:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
