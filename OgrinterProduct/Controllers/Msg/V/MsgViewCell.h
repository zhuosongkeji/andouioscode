//
//  MsgViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MsgModel,ZBNBrowseModel,ZBNShopFollowModel;

typedef void(^DidButtonWithBlcok)(UIButton *button);

NS_ASSUME_NONNULL_BEGIN

@interface MsgViewCell : UITableViewCell

@property (nonatomic,strong) MsgModel *listmodel;
@property (nonatomic,copy) DidButtonWithBlcok selectBlock;

/*! zhou */
@property (nonatomic, strong) ZBNBrowseModel *browseM;
@property (nonatomic, strong) ZBNShopFollowModel *shopM;
@end

NS_ASSUME_NONNULL_END
