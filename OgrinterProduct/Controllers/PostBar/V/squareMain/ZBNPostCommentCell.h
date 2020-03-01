//
//  ZBNPostCommentCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNCommentFrame,ZBNPostCommentCell,ZBNPostUserModel;

@protocol ZBNPostCommentDelegate <NSObject>
/*! 点击评论的昵称 */
- (void)commentCell:(ZBNPostCommentCell *)commentCell didClickedUserName:(ZBNPostUserModel *)user;
/*! 点击评论的头像 */
- (void)commentCell:(ZBNPostCommentCell *)commentCell didClickedUserIcon:(ZBNPostUserModel *)user;

@end

@interface ZBNPostCommentCell : UITableViewCell

@property (nonatomic, strong) ZBNCommentFrame *commentFrame;
/*! 代理 */
@property (nonatomic, weak) id <ZBNPostCommentDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
