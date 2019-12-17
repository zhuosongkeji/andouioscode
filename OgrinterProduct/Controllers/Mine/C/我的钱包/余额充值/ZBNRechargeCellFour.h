//
//  ZBNRechargeCellFour.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNRechargeCellFour : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImagev;

@property (weak, nonatomic) IBOutlet UILabel *textOne;


+ (instancetype)registerCellForTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
