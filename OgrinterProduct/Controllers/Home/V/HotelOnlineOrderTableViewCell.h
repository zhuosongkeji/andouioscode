//
//  HotelOnlineOrderTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotelOnlinesListModel,PaywayModel;

NS_ASSUME_NONNULL_BEGIN


@protocol HotelOnlineOrderTableViewCellDelegate <NSObject>

- (void)handleSelectedSelectedIndexPath:(NSIndexPath *)selectedIndexPath;

-(void)selectDataker:(UIButton *)btn;

@end

@interface HotelOnlineOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *pBtn;

@property(nonatomic,strong)HotelOnlinesListModel *listmodel;

@property(nonatomic,weak)id<HotelOnlineOrderTableViewCellDelegate>delegate;

@property(nonatomic,strong)PaywayModel *modellist;

@property(nonatomic,strong)NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet UILabel *gnlable;

@property (weak, nonatomic) IBOutlet UILabel *numberplable;


@property(nonatomic,strong)NSString *taday;
@property (weak, nonatomic) IBOutlet UILabel *taotltitlLable;
@property (weak, nonatomic) IBOutlet UILabel *tatolPrice;
@property (weak, nonatomic) IBOutlet UILabel *tatolPriceo;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)configTempCellWith:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
