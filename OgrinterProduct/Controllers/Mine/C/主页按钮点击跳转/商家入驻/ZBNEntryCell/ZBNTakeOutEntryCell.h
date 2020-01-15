//
//  ZBNTakeOutEntryCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNTakeOutEntryCell : UITableViewCell
+ (instancetype)registerCellForTableView:(UITableView *)tableView;

@property (nonatomic, copy) void(^chooseAddressLTask)(void);
/*! 设置label的文字 */
- (ZBNTakeOutEntryCell *(^)(NSString *labelText))setLabelText;
@end

NS_ASSUME_NONNULL_END
