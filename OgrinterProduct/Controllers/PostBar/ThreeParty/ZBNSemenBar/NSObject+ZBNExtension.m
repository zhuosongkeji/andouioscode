//
//  NSObject+ZBNExtension.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "NSObject+ZBNExtension.h"

@implementation NSObject (ZBNExtension)
+ (NSInteger) zbn_randomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}
@end
