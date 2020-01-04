//
//  ZBNSHCommonHeadV.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/3.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSHCommonHeadV : UIView

/*! 设置大文字内容 */
- (ZBNSHCommonHeadV *(^)(NSString *labelText))setLabelOneText;
/*! 设置小文字内容 */
- (ZBNSHCommonHeadV *(^)(NSString *labelText))setSubLabelOneText;
/*! 设置图片 */
- (ZBNSHCommonHeadV *(^)(NSString *labelText))setImageVImage;


@end

NS_ASSUME_NONNULL_END
