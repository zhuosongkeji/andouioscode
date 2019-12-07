//
//  ADCellRowItemModel.m
//  AnDouBusiness
//
//  Created by 周芳圆 on 2019/12/4.
//  Copyright © 2019 ZhouBunian. All rights reserved.
//

#import "ADCellRowItemModel.h"

@implementation ADCellRowItemModel

+ (instancetype)ad_settingRowItemWithImage:(UIImage *)image title:(NSString *)title
{
    ADCellRowItemModel *rowModel = [[self alloc] init];
    rowModel.image = image;
    rowModel.title = title;
 
    return rowModel;
}

@end
