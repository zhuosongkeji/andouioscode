//
//  ZBNMyNewsModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMyNewsModel : NSObject

/*! 标题id */
@property (nonatomic, copy) NSString *ID;
/*! 公告标题" */
@property (nonatomic, copy) NSString *title;
/*! 已读消息用户id */
@property (nonatomic, copy) NSString *message;
/*! 公告状态 1已读 0未读" */
@property (nonatomic, copy) NSString *messageStatus;
/*! 发布时间 */
@property (nonatomic, copy) NSString *created_at;

@end

NS_ASSUME_NONNULL_END
