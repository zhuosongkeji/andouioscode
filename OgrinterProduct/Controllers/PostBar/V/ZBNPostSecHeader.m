//
//  ZBNPostSecHeader.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostSecHeader.h"

@interface ZBNPostSecHeader ()
@property (weak, nonatomic) IBOutlet UILabel *textL;
@end


@implementation ZBNPostSecHeader

- (ZBNPostSecHeader * _Nonnull (^)(NSString * _Nonnull))setlabelText
{
    return ^(NSString *labelText) {
        [self.textL setText:labelText];
        return self;
    };
}

@end
