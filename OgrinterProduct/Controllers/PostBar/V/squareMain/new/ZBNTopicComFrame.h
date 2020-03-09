//
//  ZBNTopicComFrame.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/8.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBNPostComModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBNTopicComFrame : NSObject
/** 内容尺寸 */
@property (nonatomic , assign , readonly) CGRect textFrame;
@property (nonatomic, assign, readonly) CGRect userIconFrame;
/** cell高度 */
@property (nonatomic , assign , readonly) CGFloat cellHeight;
/** 最大宽度 外界传递 */
@property (nonatomic , assign) CGFloat maxW;
/** 评论模型 外界传递 */
@property (nonatomic , strong) ZBNPostComModel *comment;

@end

NS_ASSUME_NONNULL_END
