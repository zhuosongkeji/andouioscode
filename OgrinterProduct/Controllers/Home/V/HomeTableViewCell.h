//
//  HomeTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef enum : NSUInteger {
    
    CustomCellStyleOne,
    CustomCellStyleTwo,
    CustomCellStyleThird,
    CustomCellStyleFouth,
    
}CustomCellStyle;

#import <UIKit/UIKit.h>
@class HomeCellModel,OnlineOrderModel;

@class MDBannerModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^HomeTableViewCellBlock)(NSInteger idx);

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic,strong)HomeCellModel *listmodel;

@property(nonatomic,strong)OnlineOrderModel *modelist;

@property(nonatomic,strong)OnlineOrderModel *modelist1;

@property(nonatomic,strong)MDBannerModel *Bamodelist;

@property(nonatomic,strong)NSArray *listArr;

@property(nonatomic,strong)NSArray *listArrt;

@property(nonatomic)CustomCellStyle style;

@property(nonatomic,copy)HomeTableViewCellBlock mblock;


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


- (void)configTempCellWith:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
