//
//  CaseCluessKeybordCollectionHeadView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CaseCluessKeybordCollectionHeadView.h"

@interface CaseCluessKeybordCollectionHeadView()
@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation CaseCluessKeybordCollectionHeadView


-(void)setTitStr:(NSString *)titStr{
    _titStr = titStr;
    self.title.text = _titStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
