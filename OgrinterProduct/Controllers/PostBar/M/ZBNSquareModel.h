//
//  ZBNSquareModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSquareModel : NSObject
/*! cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/*! 是否有图片 */
@property (nonatomic, assign) BOOL hasImg;
/*! 图片数组 */
@property (nonatomic, strong) NSMutableArray *imgArr;
/*! 评论数组 */
@property (nonatomic, strong) NSMutableArray *commentArr;

@property (nonatomic, copy) NSString *userIcon;


@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) BOOL isDing;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *contentL;



@property (nonatomic, copy) NSString *cUserIcon;
@property (nonatomic, copy) NSString *cUserName;
@property (nonatomic, copy) NSString *cUserCom;
@property (nonatomic, copy) NSString *cComCount;



@end

NS_ASSUME_NONNULL_END
