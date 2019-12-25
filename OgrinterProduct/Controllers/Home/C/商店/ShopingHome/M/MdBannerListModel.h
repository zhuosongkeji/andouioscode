//
//  MdBannerListModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/24.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MdBannerListModel : NSObject

@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *bgImg;

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *url;

@end

NS_ASSUME_NONNULL_END
