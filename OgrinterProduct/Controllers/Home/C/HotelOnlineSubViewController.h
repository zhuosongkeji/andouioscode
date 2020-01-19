//
//  HotelOnlineSubViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
//反向block
typedef NSInteger(^CaReverseBlock)(void);

@interface HotelOnlineSubViewController : BaseViewController

@property (nonatomic, assign) BOOL vcCanScroll;

@property (weak, nonatomic) IBOutlet UITableView *lefttableView;
@property (weak, nonatomic) IBOutlet UITableView *righttableView;

@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong)NSString *str;

@property (nonatomic, strong)NSString *merchants_id;

@property(nonatomic,copy)CaReverseBlock resBlocik;

@end

NS_ASSUME_NONNULL_END
