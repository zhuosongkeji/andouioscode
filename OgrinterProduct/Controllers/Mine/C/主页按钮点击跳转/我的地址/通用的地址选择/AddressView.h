//
//  AddressView.h
//  SPPickerView
//
//  Created by Libo on 2018/8/31.
//  Copyright © 2018年 Cookie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBNProvince.h"
#import "ZBNCity.h"
#import "ZBNArea.h"

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface AddressView : UIView

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, copy) void(^lastComponentClickedBlock)(ZBNProvince *selectedProvince ,ZBNCity *selectedCity,ZBNArea *selectedArea);

@end
