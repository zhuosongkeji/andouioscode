//
//  ZBNPostPayHeader.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/22.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostPayHeader.h"

@interface ZBNPostPayHeader ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ZBNPostPayHeader

- (ZBNPostPayHeader * _Nonnull (^)(NSString * _Nonnull))setHeaderText
{
    return ^(NSString *headerText) {
        [self.label setText:headerText];
        return self;
    };
}




@end
