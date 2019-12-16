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


NS_ASSUME_NONNULL_BEGIN


@interface SeckillTableViewCell : UITableViewCell


@property (nonatomic) ShopSeckillDetailsType SeckillType;


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath type:(ShopSeckillDetailsType)type;

- (void)configTempCellWith:(NSIndexPath *)indexPath;

@end


NS_ASSUME_NONNULL_END
