//
//  BeseListViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/2.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol BeseListViewCellDelegate <NSObject>

-(void)didSelect:(UIButton *)btn;

@end

@class BeseListListModel;


@interface BeseListViewCell : UITableViewCell

@property (nonatomic,strong)BeseListListModel* listlistModel;

@property (weak,nonatomic)id<BeseListViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
