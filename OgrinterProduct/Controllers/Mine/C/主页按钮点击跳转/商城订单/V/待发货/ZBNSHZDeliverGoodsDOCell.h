//
//  ZBNSHZDeliverGoodsDOCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/4.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSHOrderDetailsM, ZBNSHOrderDetailComM;
@interface ZBNSHZDeliverGoodsDOCell : UITableViewCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailM;

@end

NS_ASSUME_NONNULL_END
