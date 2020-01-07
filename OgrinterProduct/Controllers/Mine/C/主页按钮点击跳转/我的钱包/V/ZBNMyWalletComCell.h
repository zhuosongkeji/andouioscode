//
//  ZBNMyWalletComCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNMyIntegralModel;
@interface ZBNMyWalletComCell : UITableViewCell

+ (instancetype)registerCellForTableView:(UITableView *)tableView;

/*! 积分模型 */
@property (nonatomic, strong) ZBNMyIntegralModel *integerM;

@end

NS_ASSUME_NONNULL_END
