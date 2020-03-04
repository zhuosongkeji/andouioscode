//
//  ZBNReturnGoodsReasonCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNSHReCellM.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBNReturnGoodsReasonCell : UITableViewCell
/*! 模型数据 */
@property (nonatomic, strong) ZBNSHReCellM *returnM;
+ (instancetype)regiserCellForTable:(UITableView *)tableView;
@property (nonatomic, copy) void(^selctedBtnClickTask)(ZBNReturnGoodsReasonCell *cell);

@end

NS_ASSUME_NONNULL_END
