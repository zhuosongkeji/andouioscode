//
//  ZBNPostSecHeader.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostSecHeader : UIView
- (ZBNPostSecHeader *(^)(NSString *labelText))setlabelText;
@end

NS_ASSUME_NONNULL_END
