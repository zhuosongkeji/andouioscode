//
//  ZBNSquareFrame.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBNSquareModel.h"
#import "ZBNCommentFrame.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZBNSquareFrame : NSObject

/*! 头像 */
@property (nonatomic , assign , readonly) CGRect avatarFrame;
/*! 标题 */
@property (nonatomic , assign , readonly) CGRect titleFrame;
/*! 内容 */
@property (nonatomic , assign , readonly) CGRect contentFrame;
/*! 中间图片 */
@property (nonatomic , assign , readonly) CGRect imageFrame;
/*! 整个高度 */
@property (nonatomic , assign ) CGFloat cellHeight;
/** 评论尺寸模型 由于后期需要用到，所以不涉及为只读 */
@property (nonatomic , strong ,readonly) NSMutableArray *commentFrames;
@property (nonatomic , strong , readonly) NSMutableArray *imageFrames;
/*! 整个header模型 */
@property (nonatomic, strong) ZBNSquareModel *squareM;

@end

NS_ASSUME_NONNULL_END
