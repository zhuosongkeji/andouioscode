//
//  SeckillTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShopSeckillDetailsTypeKill,//秒杀
    ShopSeckillDetailsTypeOrder,//普通商品
    ShopSeckillDetailsTypeOther,//其他
    
} ShopSeckillDetailsType;


typedef void(^ScBtnClickBlock)(UIButton *btn);

NS_ASSUME_NONNULL_BEGIN

@class ShopDetalisModel,KillModelt;

@interface SeckillTableViewCell : UITableViewCell


@property (nonatomic) ShopSeckillDetailsType SeckillType;

@property(nonatomic,strong) ShopDetalisModel *dmodelist;
@property(nonatomic,strong) KillModelt *kmodelist;

@property (nonatomic,copy)ScBtnClickBlock selectBlock;

+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath type:(ShopSeckillDetailsType)type;

- (void)configTempCellWith:(NSIndexPath *)indexPath;


@end


NS_ASSUME_NONNULL_END
