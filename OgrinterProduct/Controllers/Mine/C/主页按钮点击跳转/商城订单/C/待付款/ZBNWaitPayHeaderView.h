//
//  ZBNWaitPayHeaderView.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNWaitPayHeaderView : UIView

/*! 设置大文字内容 */
- (ZBNWaitPayHeaderView *(^)(NSString *labelText))setLabelOneText;
/*! 设置小文字内容 */
- (ZBNWaitPayHeaderView *(^)(NSString *labelText))setSubLabelOneText;
/*! 设置图片 */
- (ZBNWaitPayHeaderView *(^)(NSString *labelText))setImageVImage;

@end

NS_ASSUME_NONNULL_END
