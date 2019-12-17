//
//  ZBNRechargeCellFour.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/16.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNRechargeCellFour.h"


@interface ZBNRechargeCellFour ()

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;


@end

@implementation ZBNRechargeCellFour
- (IBAction)selectedBtnClick:(UIButton *)sender {
}

+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNRechargeCellFourID = @"fourCell";
    ZBNRechargeCellFour *cell = [tableView dequeueReusableCellWithIdentifier:ZBNRechargeCellFourID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNRechargeCellFour" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
