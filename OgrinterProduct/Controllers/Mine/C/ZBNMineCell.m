//
//  ZBNMineCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNMineCell.h"

@implementation ZBNMineCell

- (IBAction)telBtn:(id)sender {
    
    NSLog(@"click");
    NSString *telephoneNumber = @"4008-789-809";
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    [[UIApplication   sharedApplication] openURL:[NSURL URLWithString:str]];

}


@end
