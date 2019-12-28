//
//  ZBNSHApplyForRefundCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNSHApplyForRefundCell.h"


@interface ZBNSHApplyForRefundCell ()

/*! 选择退款原因的cell */
@property (weak, nonatomic) IBOutlet UIView *twoCellView;


@end


@implementation ZBNSHApplyForRefundCell




- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupGes];
}


- (void)setupGes
{
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoCellClick)];
    [self.twoCellView addGestureRecognizer:tapGes1];
}


/*! 第二个cell的点击 */
- (void)twoCellClick
{
    if (self.twoCellClickTask) {
        self.twoCellClickTask();
    }
}








+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHApplyForRefundCellID = @"ZBNSHApplyForRefundCellID";
    ZBNSHApplyForRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHApplyForRefundCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHApplyForRefundCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
