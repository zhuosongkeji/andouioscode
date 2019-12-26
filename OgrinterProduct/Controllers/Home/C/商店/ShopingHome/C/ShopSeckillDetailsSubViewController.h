//
//  ShopSeckillDetailsSubViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopSeckillDetailsSubViewController : BaseViewController

@property (nonatomic, assign) BOOL vcCanScroll;


@property (weak, nonatomic) IBOutlet UITableView *smTableView;


@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) NSString *str;
@property (nonatomic,strong)NSString *cp_id;

@end

NS_ASSUME_NONNULL_END
