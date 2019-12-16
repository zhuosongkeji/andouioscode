//
//  ZBNShoppingCartModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/13.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNShoppingCartModel : NSObject

@property (copy, nonatomic) NSString *money;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *image;
/*! 数量 */
@property (nonatomic, assign) int count;
/*! 是否被选中 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;
/*! 是否删除 */
@property (nonatomic, assign) BOOL isDelete;
@end

NS_ASSUME_NONNULL_END
