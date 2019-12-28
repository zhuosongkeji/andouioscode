//
//  ZBNRechargeCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNRechargeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


+ (instancetype)registerCellForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
