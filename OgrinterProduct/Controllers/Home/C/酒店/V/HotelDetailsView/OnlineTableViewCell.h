//
//  OnlineTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <UIKit/UIKit.h>

@class OrderListModel,PaywayModel,OrderlModel,HotelOrderModel;


NS_ASSUME_NONNULL_BEGIN

@protocol OnlineTableViewCellDelegate <NSObject>

- (void)handleSelectedButtonActionWithSelectedIndexPath:(NSIndexPath *)selectedIndexPath;

@end


typedef void(^SelectDataBlock)(UIButton *btn);

@interface OnlineTableViewCell : UITableViewCell


@property (nonatomic,weak)id<OnlineTableViewCellDelegate> xlDelegate;

@property(nonatomic,strong)OrderListModel *modellist1;
@property(nonatomic,strong)PaywayModel *modellist2;
@property(nonatomic,strong)OrderlModel *modellist3;
@property(nonatomic,strong)HotelOrderModel *listmodel1;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UILabel *rzdateLabel;

@property (weak, nonatomic) IBOutlet UILabel *livedateLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property(nonatomic,copy)SelectDataBlock selectblock;


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath withTpye:(NSInteger)type;


- (void)configTempCellWith:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
