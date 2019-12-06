//
//  PacketModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PacketModel : NSObject

@property (nonatomic, assign) float     money;
@property (nonatomic, strong) UIImage   *avatarImage;
@property (nonatomic, copy  ) NSString  *content;
@property (nonatomic, copy  ) NSString  *userName;

@end

NS_ASSUME_NONNULL_END
