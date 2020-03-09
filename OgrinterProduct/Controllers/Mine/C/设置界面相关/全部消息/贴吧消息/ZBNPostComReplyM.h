//
//  ZBNPostComReplyM.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostComReplyM : NSObject

@property (nonatomic, copy) NSString *info_id;
@property (nonatomic, strong) NSNumber *post_id;
@property (nonatomic, copy) NSString *avator;
@property (nonatomic, copy) NSString *from_user;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *read;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *join_msg;
/** 赞富文本 */
- (NSAttributedString *)attributedText;
/** 回复富文本 */
- (NSAttributedString *)attributedTextRe;

@end

NS_ASSUME_NONNULL_END
