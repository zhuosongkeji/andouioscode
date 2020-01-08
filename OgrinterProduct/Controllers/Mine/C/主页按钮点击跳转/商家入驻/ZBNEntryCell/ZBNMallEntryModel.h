//
//  ZBNMallEntryModel.h
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/8.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBNMallEntryModel : NSObject

@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *detailAdd;
@property (nonatomic, copy) NSString *shopIntrol;
@property (nonatomic, copy) NSString *urlOne;
@property (nonatomic, copy) NSString *urlTwo;
@property (nonatomic, copy) NSString *urlThree;

@property (nonatomic, assign) NSNumber *IDPro;
@property (nonatomic, assign) NSNumber *IDCity;
@property (nonatomic, assign) NSNumber *IDArea;

+ (ZBNMallEntryModel *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
