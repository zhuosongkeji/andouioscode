//
//  CommentModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property (nonatomic,strong) NSString *avator;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *uid;

@property (nonatomic,strong) NSString *stars;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *created_at;


@property(nonatomic,strong)NSArray *listArr;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)initWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
