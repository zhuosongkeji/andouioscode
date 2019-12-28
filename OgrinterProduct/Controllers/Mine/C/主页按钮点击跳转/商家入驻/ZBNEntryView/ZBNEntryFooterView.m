//
//  ZBNEntryFooterView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/12.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNEntryFooterView.h"

@interface ZBNEntryFooterView ()


@property (weak, nonatomic) IBOutlet UIButton *middleBtn;

@end

@implementation ZBNEntryFooterView

- (IBAction)middleBtnClick:(UIButton *)sender {
    
    if (self.middleBtnClickTask) {
        self.middleBtnClickTask();
    }
}

- (ZBNEntryFooterView * _Nonnull (^)(NSString * _Nonnull))setButtonText
{
    return ^(NSString *buttonText) {
        [self.middleBtn setTitle:buttonText forState:UIControlStateNormal];
        return self;
    };
}

@end
