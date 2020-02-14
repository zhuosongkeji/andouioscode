//
//  CresTwoTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CommentModel;

@interface CresTwoTableViewCell : UITableViewCell

@property(nonatomic,strong)CommentModel *listmodel;

@property(nonatomic,strong)CommentModel *clistmodel;


@end

NS_ASSUME_NONNULL_END
