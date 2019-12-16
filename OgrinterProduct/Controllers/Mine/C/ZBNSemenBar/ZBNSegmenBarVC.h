//
//  ZBNSegmenBarVC.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNSegmenBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSegmenBarVC : UIViewController

@property (nonatomic, strong) ZBNSegmenBar *segmentBar;

@property (nonatomic ,assign) BOOL *segmentIndicatorViewIsHidden;

- (void)setUpWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;

@end

NS_ASSUME_NONNULL_END
