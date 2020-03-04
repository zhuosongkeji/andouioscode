//
//  ZBNPostBarHeader.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNSquareFrame,ZBNPostBarHeader,ZBNPostUserModel,ZBNSquareModel;

@protocol ZBNPostBarHeaderDelegate <NSObject>

/*! 点击头像 */
- (void)squareHeaderDidClickUserIcon:(ZBNPostBarHeader *)postHeader;
/*! 点赞 */
- (void)squareHeaderDidClickDingBtn:(ZBNPostBarHeader *)postHeader dingBtn:(UIButton *)dingBtn;
/*! 点击分享 */
- (void)squareHeaderDidClickShareBtn:(ZBNPostBarHeader *)postHeader;
/*! 点击评论 */
- (void)squareHeaderDidClickCommentBtn:(ZBNPostBarHeader *)postHeader;

@end

@interface ZBNPostBarHeader : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

/*! 模型 */
@property (nonatomic, strong) ZBNSquareFrame *squareFrame;
/*! 代理 */
@property (nonatomic, weak) id <ZBNPostBarHeaderDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
