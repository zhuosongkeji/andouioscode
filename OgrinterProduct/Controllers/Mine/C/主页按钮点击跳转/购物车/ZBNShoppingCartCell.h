//
//  ZBNShoppingCartCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNShoppingCartModel, ZBNShoppingCartCell;


typedef void(^DeleteBtnClickTask)(ZBNShoppingCartModel *catModel);
@protocol ZBNShoppingCartCellDelegate <NSObject>
- (void)shoppingCartCellDidClickPlusButton:(ZBNShoppingCartCell *)shoppingCartCell;
- (void)shoppingCartCellDidClickReduceButton:(ZBNShoppingCartCell *)shoppingCartCell;
- (void)shoppingCartCellDidClickSelectedButton:(ZBNShoppingCartCell *)shoppingCartCell;
- (void)shoppingCartCellDidClickDeleteButton:(ZBNShoppingCartCell *)shoppingCartCell;
@end

@interface ZBNShoppingCartCell : UITableViewCell

@property (nonatomic, copy) DeleteBtnClickTask deleteBtnClick;

@property (nonatomic, strong) ZBNShoppingCartModel *shoppingCartModel;
/*! 代理对象 */
@property (nonatomic, weak) id <ZBNShoppingCartCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
