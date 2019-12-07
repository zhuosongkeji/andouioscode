//
//  SearchResrultViewController.h
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//

typedef enum : NSUInteger {
    SearchTableViewList,
    SearchCollectionViewtypeOne,
    SearchCollectionViewtypeTwo,
    searchOtherResult,
} SearchResultType;

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResrultViewController : BaseViewController

@property (nonatomic)SearchResultType type;

@end

NS_ASSUME_NONNULL_END
