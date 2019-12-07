//
//  ADCellRowItemModel.h
//  AnDouBusiness
//
//  Created by 周芳圆 on 2019/12/4.
//  Copyright © 2019 ZhouBunian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADCellRowItemModel : NSObject
/*!
 图标
 */
@property (nonatomic, strong) UIImage *image;
/*!
 标题
 */
@property (nonatomic, copy) NSString *title;
/*!
 子标题
 */
@property (nonatomic, copy) NSString *subTitle;
/*!
 根据图片和标题快速创建行模型

 @param image 图片
 @param title 标题
 @return 行模型
 */
+ (instancetype)ad_settingRowItemWithImage:(UIImage *)image title:(NSString *)title;
/*!
 点击cell执行的代码块
 */
@property (nonatomic, copy) void(^myTask)(NSIndexPath *indexPath);
/*!
 跳转的控制器
 */
@property (nonatomic, assign) Class desClass;

@end

NS_ASSUME_NONNULL_END
