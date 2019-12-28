//
//  ZBNEntryFooterView.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBNEntryFooterView;
@interface ZBNEntryFooterView : UIView

@property (nonatomic, copy) void(^middleBtnClickTask)(void);

- (ZBNEntryFooterView *(^)(NSString *buttonText))setButtonText;

@end

NS_ASSUME_NONNULL_END
