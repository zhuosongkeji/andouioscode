//
//  HotelDetailsBottomView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^reserveClickBlock)(UIButton *btn);

@class HoleggModel;

NS_ASSUME_NONNULL_BEGIN

@interface HotelDetailsBottomView : UIView

@property(nonatomic,strong)HoleggModel *gglist;

@property (nonatomic,copy) reserveClickBlock reserveBlock;

@end

NS_ASSUME_NONNULL_END
