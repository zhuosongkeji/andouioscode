//
//  ZBNPostComReplyFrame.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNPostComReplyM;
@interface ZBNPostComReplyFrame : NSObject
/** 头像frame */
@property (nonatomic , assign , readonly) CGRect avatarFrame;
/*! 标题 */
@property (nonatomic , assign , readonly) CGRect titleFrame;
/** 时间frame */
@property (nonatomic , assign , readonly) CGRect createTimeFrame;
@property (nonatomic , assign, readonly) CGFloat cellHeight;
@property (nonatomic, strong) ZBNPostComReplyM *reM;
@end

NS_ASSUME_NONNULL_END
