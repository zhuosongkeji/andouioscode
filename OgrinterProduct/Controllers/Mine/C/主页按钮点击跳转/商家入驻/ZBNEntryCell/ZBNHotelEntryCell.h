//
//  ZBNHotelEntryCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNHotelEntryCell : UITableViewCell
+ (instancetype)registerCellForTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^chooseAddressLTask)(void);
/*! 设置label的文字 */
- (ZBNHotelEntryCell *(^)(NSString *labelText))setLabelText;

@end

NS_ASSUME_NONNULL_END
