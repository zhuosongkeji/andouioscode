//
//  LoginViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (nonatomic, copy) void(^loginBtnClickTask)(void);

@end

NS_ASSUME_NONNULL_END
