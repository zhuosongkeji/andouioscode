//
//  ZBNPostPayHeader.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/22.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostPayHeader : UIView

- (ZBNPostPayHeader *(^)(NSString *headerText))setHeaderText;
@end

NS_ASSUME_NONNULL_END
