//
//  ZBNLocationCell.h
//  Gaode
//
//  Created by 周芳圆 on 2020/3/1.
//  Copyright © 2020 ZhouBunian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSearchAddrM,AMapTip;
@interface ZBNLocationCell : UITableViewCell

+ (instancetype)registerCellForTable:(UITableView *)tableView;
@property (nonatomic, strong) ZBNSearchAddrM *model;
@property (nonatomic, strong) AMapTip *tip;
@end

NS_ASSUME_NONNULL_END
