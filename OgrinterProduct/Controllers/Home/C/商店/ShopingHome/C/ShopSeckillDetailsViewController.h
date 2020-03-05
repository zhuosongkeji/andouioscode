//
//  ShopSeckillDetailsViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SeckillTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopSeckillDetailsViewController : UIViewController

@property (nonatomic)ShopSeckillDetailsType seckillType;
@property (nonatomic,strong)NSString *cpid;

@property (nonatomic,strong)NSString *sec_id;

@end

NS_ASSUME_NONNULL_END
