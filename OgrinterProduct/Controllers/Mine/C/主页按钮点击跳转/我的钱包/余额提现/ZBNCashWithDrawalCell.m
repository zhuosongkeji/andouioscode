//
//  ZBNCashWithDrawalCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNCashWithDrawalCell.h"


@interface ZBNCashWithDrawalCell ()

@property (weak, nonatomic) IBOutlet UIView *labelView;


@end

@implementation ZBNCashWithDrawalCell


+ (instancetype)regiserCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNCashWithDrawalCellID = @"cashCell";
    ZBNCashWithDrawalCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNCashWithDrawalCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNCashWithDrawalCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.labelView.layer.cornerRadius = self.labelView.height * 0.5;
}

@end
