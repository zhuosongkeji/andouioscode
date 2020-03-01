//
//  ZBNPostPayWayModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/22.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostPayWayModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign, getter=isSelcted) BOOL selected;
@end

NS_ASSUME_NONNULL_END
