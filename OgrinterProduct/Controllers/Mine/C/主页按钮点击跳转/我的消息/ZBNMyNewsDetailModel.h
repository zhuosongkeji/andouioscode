//
//  ZBNMyNewsDetailModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMyNewsDetailModel : NSObject

/*! 标题id */
@property (nonatomic, copy) NSString *ID;
/*! 公告标题 */
@property (nonatomic, copy) NSString *title;
/*! 公告内容 */
@property (nonatomic, copy) NSString *content;
/*! 创建时间 */
@property (nonatomic, copy) NSString *created_at;

@end

NS_ASSUME_NONNULL_END
