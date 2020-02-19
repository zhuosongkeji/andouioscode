//
//  ZBNPostComModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNPostComModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userIcon;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, assign) CGFloat cellHeight;


@end

NS_ASSUME_NONNULL_END
