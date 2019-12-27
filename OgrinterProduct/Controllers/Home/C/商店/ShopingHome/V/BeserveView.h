//
//  BeserveView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/17.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoToPayButtonBlock)(UIButton *btn);

NS_ASSUME_NONNULL_BEGIN

@interface BeserveView : UIView

@property(nonatomic,strong)NSDictionary *dataDic;

@property (nonatomic,copy)GoToPayButtonBlock payBlock;

@end

NS_ASSUME_NONNULL_END
