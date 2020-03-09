//
//  ZBNTopicCell.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/5.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZBNPostUserModel,ZBNTopicCell,ZBNTopicFrame;

@protocol ZBNTopicDelegate <NSObject>

/*! 点击昵称或头像的回调 */
- (void)topicCellDidClickUser:(ZBNTopicCell *)cell;
/*! 点击顶部的回调 */
//- (void)topicDidClickTopContent:(ZBNTopicCell *)cell;
/*! 点赞的回调 */
- (void)topicDidClickThumbBtn:(ZBNTopicCell *)cell;
/*! 评论的回调 */
- (void)topicDidClickCommentBtn:(ZBNTopicCell *)cell;
/*! 分享的回调 */
- (void)topicDidClickShareBtn:(ZBNTopicCell *)cell;

@end


@interface ZBNTopicCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 话题模型数据源 */
@property (nonatomic , strong) ZBNTopicFrame *topicFrame;
/** 代理 */
@property (nonatomic , weak) id <ZBNTopicDelegate> delegate;

@property (nonatomic, copy) void(^cellIncellDidClick)(ZBNTopicCell *cell);
@property (nonatomic, copy) void(^dingBtnClick)(ZBNTopicCell *cell);

@end

NS_ASSUME_NONNULL_END
