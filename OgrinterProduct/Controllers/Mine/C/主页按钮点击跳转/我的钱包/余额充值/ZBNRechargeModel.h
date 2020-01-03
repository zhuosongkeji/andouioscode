//
//  ZBNRechargeModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/30.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNRechargeModel : NSObject

/*! 充值金额 */
@property (nonatomic, copy) NSString *moneyNumber;
/*! 联系方式 */
@property (nonatomic, copy) NSString *phoneNumber;
/*! 充值方式 */
@property (nonatomic, copy) NSString *payNumber;
/*! 账号 */
@property (nonatomic, copy) NSString *accountNumber;

+ (instancetype)initModelWithMoney:(NSString *)money phone:(NSString *)phone payNumber:(NSString *)payNumber accountNumber:(NSString *)accountNumber;

@end

NS_ASSUME_NONNULL_END
