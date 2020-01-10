//
//  ShoperListModel.h
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/8.
//  Copyright © 2020 RXF. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoperListModel : NSObject

@property(nonatomic,strong)NSString *type_Name;
@property(nonatomic,strong)NSString *type_Id;


@property(nonatomic,strong)NSString *goods_Id;
@property(nonatomic,strong)NSString *goods_Img;
@property(nonatomic,strong)NSString *goods_Name;
@property(nonatomic,strong)NSString *goods_price;

@property(nonatomic)BOOL iselect;

@end

NS_ASSUME_NONNULL_END
