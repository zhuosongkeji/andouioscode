//
//  ZBNSegmenBar.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNSegmenBarConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class ZBNSegmenBar;
@protocol ZBNSegmenBarDelegate <NSObject>

/**
 代理方法, 告诉外界, 内部的点击数据

 @param segmentBar segmentBar
 @param toIndex    选中的索引(从0开始)
 @param fromIndex  上一个索引
 */
- (void)segmentBar: (ZBNSegmenBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end


@interface ZBNSegmenBar : UIView
/**
 快速创建一个选项卡控件

 @param frame frame

 @return 选项卡控件
 */
+ (instancetype)segmentBarWithFrame: (CGRect)frame;
/** 代理 */
@property (nonatomic, weak) id<ZBNSegmenBarDelegate> delegate;
/** 数据源 */
@property (nonatomic, strong) NSArray <NSString *>*items;
/** 当前选中的索引, 双向设置 */
@property (nonatomic, assign) NSInteger selectIndex;

//样式颜色更新
- (void)updateWithConfig: (void(^)(ZBNSegmenBarConfig *config))configBlock;


/** 标签是否平分 */
@property (nonatomic,assign) BOOL isDivideEqually;

@end

NS_ASSUME_NONNULL_END
