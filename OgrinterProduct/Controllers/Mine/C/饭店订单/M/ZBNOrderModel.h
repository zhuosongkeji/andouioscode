//
//  ZBNOrderModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNOrderModel : NSObject




/***** 额外增加的属性 ******/
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;


@end

NS_ASSUME_NONNULL_END
