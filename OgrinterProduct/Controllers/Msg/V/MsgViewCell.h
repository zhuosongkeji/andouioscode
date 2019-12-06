//
//  MsgViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MsgModel;

typedef void(^DidButtonWithBlcok)(UIButton *button);

NS_ASSUME_NONNULL_BEGIN

@interface MsgViewCell : UITableViewCell

@property (nonatomic,strong) MsgModel *listmodel;
@property (nonatomic,copy) DidButtonWithBlcok selectBlock;

@end

NS_ASSUME_NONNULL_END
