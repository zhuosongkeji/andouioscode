//
//  ZBNReturnGoodsReasonView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNReturnGoodsReasonView.h"



@interface ZBNReturnGoodsReasonView ()



@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *selectedBtnArray;




@end


@implementation ZBNReturnGoodsReasonView



- (IBAction)selctedBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (self.selectedBtnClickTask) {
        self.selectedBtnClickTask();
    }
}

@end
