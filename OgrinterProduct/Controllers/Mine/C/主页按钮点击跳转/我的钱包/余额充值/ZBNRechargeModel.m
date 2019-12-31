//
//  ZBNRechargeModel.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/30.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeModel.h"

@implementation ZBNRechargeModel

+ (instancetype)initModelWithMoney:(NSString *)money phone:(NSString *)phone payNumber:(NSString *)payNumber accountNumber:(NSString *)accountNumber
{
    ZBNRechargeModel *model = [[self alloc] init];
    model.moneyNumber = money;
    model.phoneNumber = phone;
    model.payNumber = payNumber;
    model.accountNumber = accountNumber;
    return model;
}

@end
