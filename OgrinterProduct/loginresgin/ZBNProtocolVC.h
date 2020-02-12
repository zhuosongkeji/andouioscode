//
//  ZBNProtocolVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/12.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNProtocolVC : UIViewController
@property (nonatomic, copy) void(^agreeBtnClickTask)(void);
@end

NS_ASSUME_NONNULL_END
