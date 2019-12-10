//
//  CustomAlterView.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef void(^ClickWithAgreeBtnBlock)(void);

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomAlterView : UIView

@property (nonatomic,copy) ClickWithAgreeBtnBlock btnBlcok;

@end

NS_ASSUME_NONNULL_END
