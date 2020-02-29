//
//  ZBNRTCommentM.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNRTCommentM : NSObject

@property (nonatomic, copy) NSString *order_id;
@property (nonatomic, copy) NSString *merchants_id;
+ (ZBNRTCommentM *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
