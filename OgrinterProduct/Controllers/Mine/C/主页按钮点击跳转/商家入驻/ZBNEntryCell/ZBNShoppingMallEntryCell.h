//
//  ZBNShoppingMallEntryCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNMallEntryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBNShoppingMallEntryCell : UITableViewCell
+ (instancetype)registerCellForTableView:(UITableView *)tableView;
@property (nonatomic, strong) ZBNMallEntryModel *model;
/*! 返回第一个URL */
@property (nonatomic, copy) NSString *getURLOne;
/*! 返回第一个URL */
@property (nonatomic, copy) NSString *getURLTwo;
/*! 返回第一个URL */
@property (nonatomic, copy) NSString *getURLThree;

@property (nonatomic, copy) void(^addressLabelClickTask)(void);

/*! 设置label的文字 */
- (ZBNShoppingMallEntryCell *(^)(NSString *labelText))setLabelText;



@end

NS_ASSUME_NONNULL_END
