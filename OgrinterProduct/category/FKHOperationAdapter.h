//
//  FKHOperationAdapter.h
//  FKHProduct
//
//  Created by mac on 2019/8/21.
//  Copyright © 2019 fkh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FKHOperationAdapter <NSObject>

@required

- (nullable instancetype)initOperationWithTask:(void (^)(void))taskBlock;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END
