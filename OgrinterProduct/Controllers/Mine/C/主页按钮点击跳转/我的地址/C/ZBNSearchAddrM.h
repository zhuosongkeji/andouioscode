//
//  ZBNSearchAddrM.h
//  Gaode
//
//  Created by 周芳圆 on 2020/3/1.
//  Copyright © 2020 ZhouBunian. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNSearchAddrM : NSObject

/*! 省 */
@property (nonatomic, copy) NSString *province;
/*! 市 */
@property (nonatomic, copy) NSString *city;
/*! 区 */
@property (nonatomic, copy) NSString *district;
/*! name */
@property (nonatomic, copy) NSString *name;
/*! address */
@property (nonatomic, copy) NSString *address;
/*! 省编码 */
@property (nonatomic, copy) NSString *pcode;
/*! 市编码 */
@property (nonatomic, copy) NSString *citycode;
/*! 区域编码 */
@property (nonatomic, copy) NSString *adcode;
/*! 是否选中 */
@property (nonatomic, assign) BOOL isSelected;
/*! 商圈 businessArea*/ 
@property (nonatomic, copy) NSString *businessArea;



@end

NS_ASSUME_NONNULL_END
