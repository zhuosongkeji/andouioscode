//
//  HotelDetlisSubViewOneController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "BaseViewController.h"
#import "HDragItemListView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotelDetlisSubViewOneController : BaseViewController


@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UITextView *describeContent;
@property (nonatomic, strong) HDragItemListView *itemList;
@property (nonatomic, assign) NSInteger tapIndex;


@property (nonatomic, assign) BOOL vcCanScroll;

@property (weak, nonatomic) IBOutlet UITableView *SubViewOnemTableView;

@property (nonatomic, assign) BOOL isRefresh;

@property (nonatomic, strong)NSString *str;

@property (nonatomic,strong)NSArray *imgArr;
@property (nonatomic, strong)NSString *desc;
@property (nonatomic,strong)NSString *sid;//商户id

@end

NS_ASSUME_NONNULL_END
