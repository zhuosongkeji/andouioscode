//
//  ZBNReturnGoodsReasonCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNReturnGoodsReasonCell.h"

@interface ZBNReturnGoodsReasonCell ()
@property (weak, nonatomic) IBOutlet UILabel *reasonL;
@property (weak, nonatomic) IBOutlet UIButton *selctedBtn;
@end


@implementation ZBNReturnGoodsReasonCell

- (void)setReturnM:(ZBNSHReCellM *)returnM
{
    _returnM = returnM;
    self.reasonL.text = returnM.name;
    self.selctedBtn.selected = returnM.is_selected;
    
}


- (IBAction)selctedBtnClick:(UIButton *)sender {
    if (self.selctedBtnClickTask) {
        self.selctedBtnClickTask(self);
    }
}

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNReturnGoodsReasonCellID = @"ZBNReturnGoodsReasonCellID";
    ZBNReturnGoodsReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNReturnGoodsReasonCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNReturnGoodsReasonCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


@end
