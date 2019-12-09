//
//  HotelBottomTableViewCell.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSScrollContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotelBottomTableViewCell : UITableViewCell

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) BOOL cellCanScroll;
@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong) NSString *currentTagStr;


@end

NS_ASSUME_NONNULL_END
