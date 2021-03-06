//
//  ZBNSHGoAndPayDetailCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBNSHOrderUserInfoM, ZBNSHOrderDetailsM, ZBNSHOrderDetailComM;
@interface ZBNSHGoAndPayDetailCell : UITableViewCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView;

@property (nonatomic, strong) ZBNSHOrderDetailComM *comM;
@property (nonatomic, strong) ZBNSHOrderDetailsM *detailM;
@property (nonatomic, strong) ZBNSHOrderUserInfoM *userInfoM;

@property (nonatomic, copy) void(^goAndPayBtnClickTask)(void);
@property (nonatomic, copy) void(^cancelBtnClickTask)(void);
@end

NS_ASSUME_NONNULL_END
