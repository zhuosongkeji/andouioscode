//
//  HotelDetailsBottomView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef void(^reserveClickBlock)(UIButton *btn);

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotelDetailsBottomView : UIView

@property (nonatomic,copy) reserveClickBlock reserveBlock;

@end

NS_ASSUME_NONNULL_END
