//
//  HolteOnlineSubViewTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HotelOnlinesListModel;

typedef void(^ClickBtnBlock)(NSInteger idx,UIButton *btn);

@interface HolteOnlineSubViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberlabel;

@property(nonatomic,strong)HotelOnlinesListModel *listmodel;

@property(nonatomic,copy)ClickBtnBlock clickBlock;


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)configTempCellWith:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
