//
//  ShopCollectionViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MdBannerListModel,ShoperListModel,MsgModel;

@interface ShopCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)MdBannerListModel *modellists;
@property (nonatomic,strong)ShoperListModel *listmodels;
@property (nonatomic,strong)MsgModel *msglist;

@end

NS_ASSUME_NONNULL_END
