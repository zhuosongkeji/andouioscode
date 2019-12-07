//
//  ADCellGroupItemModel.m
//  AnDouBusiness
//
//  Created by 周芳圆 on 2019/12/4.
//  Copyright © 2019 ZhouBunian. All rights reserved.
//

#import "ADCellGroupItemModel.h"

@implementation ADCellGroupItemModel

+ (instancetype)ad_settingGroupItemWithRowArray:(NSArray *)array headerTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
    ADCellGroupItemModel *groupModel = [[self alloc] init];
    groupModel.rowArray = array;
    groupModel.headerTitle = headerTitle;
    groupModel.footerTitle = footerTitle;
    return groupModel;
}

@end
