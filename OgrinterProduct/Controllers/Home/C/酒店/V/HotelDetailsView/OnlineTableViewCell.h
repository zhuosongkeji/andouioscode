//
//  OnlineTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <UIKit/UIKit.h>

@class OrderlModel,PaywayModel;


NS_ASSUME_NONNULL_BEGIN

@protocol OnlineTableViewCellDelegate <NSObject>

- (void)handleSelectedButtonActionWithSelectedIndexPath:(NSIndexPath *)selectedIndexPath;

@end


@interface OnlineTableViewCell : UITableViewCell


@property (nonatomic,weak)id<OnlineTableViewCellDelegate> xlDelegate;

@property(nonatomic,strong)OrderlModel *modellist1;
@property(nonatomic,strong)PaywayModel *modellist2;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath withTpye:(NSInteger)type;


- (void)configTempCellWith:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
