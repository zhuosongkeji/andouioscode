//
//  ZBNMerchantEntryTabCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMerchantEntryTabCell : UITableViewCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView;
/*! 商城 */
@property (nonatomic, copy) void(^shoppingHallClickTask)(void);
/*! 酒店 */
@property (nonatomic, copy) void(^hotleViewClickTask)(void);
/*! 外卖 */
@property (nonatomic, copy) void(^takeViewClickTask)(void);
@end

NS_ASSUME_NONNULL_END
