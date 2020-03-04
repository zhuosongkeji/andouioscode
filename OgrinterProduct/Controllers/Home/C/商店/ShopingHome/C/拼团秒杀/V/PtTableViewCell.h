//
//  PtTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KillerbListModel;

@interface PtTableViewCell : UITableViewCell

@property(nonatomic,strong)KillerbListModel *llmodel;
@property(nonatomic,strong)NSString *tStr;

@end

NS_ASSUME_NONNULL_END
