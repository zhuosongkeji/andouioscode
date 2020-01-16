//
//  RetrievepsdViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RetrievepsdViewControllerBlock)(BOOL idx);

typedef enum : NSUInteger {
    RetrievepsdViewControllerOne,//找回密码
    RetrievepsdViewControllerTwo,//帮定手机号码
    RetrievepsdViewControllerOther,
} RetrievepsdViewControllertype;

NS_ASSUME_NONNULL_BEGIN

@interface RetrievepsdViewController : UIViewController

@property(nonatomic)RetrievepsdViewControllertype type;

@property (nonatomic,strong)NSDictionary *wxdict;

@property(nonatomic,copy)RetrievepsdViewControllerBlock successBlock;

@end

NS_ASSUME_NONNULL_END
