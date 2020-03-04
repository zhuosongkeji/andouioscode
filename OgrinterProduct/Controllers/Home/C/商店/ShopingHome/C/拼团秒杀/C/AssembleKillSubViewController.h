//
//  AssembleKillSubViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssembleKillSubViewController : BaseViewController

@property (nonatomic,strong)NSString *str;
@property (nonatomic, assign) BOOL vcCanScroll;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

@property (nonatomic, assign) BOOL isRefresh;
@property(nonatomic,strong)NSString *aid;


@end

NS_ASSUME_NONNULL_END
