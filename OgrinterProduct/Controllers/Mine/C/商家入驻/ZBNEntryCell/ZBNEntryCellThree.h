//
//  ZBNEntryCellThree.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNEntryCellThree : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textOne;
@property (weak, nonatomic) IBOutlet UILabel *textTwo;

+ (instancetype)registerCellForTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
