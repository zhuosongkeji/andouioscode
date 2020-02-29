//
//  ZBNRTPayCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/28.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNRTComDetailModel;
@interface ZBNRTPayCell : UITableViewCell
/*! 模型数据 */
@property (nonatomic, strong) ZBNRTComDetailModel *detailM;
/*! 微信 */
@property (nonatomic, copy) void(^weixinBtnClickTask)(UIButton *weixinBtn);
/*! 余额 */
@property (nonatomic, copy) void(^yueBtnClickTask)(UIButton *yueBtn);

@end

NS_ASSUME_NONNULL_END
