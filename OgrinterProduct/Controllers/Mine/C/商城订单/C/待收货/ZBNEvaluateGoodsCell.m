//
//  ZBNEvaluateGoodsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNEvaluateGoodsCell.h"
#import "TggStarEvaluationView.h"

@interface ZBNEvaluateGoodsCell ()


@property (weak, nonatomic) IBOutlet TggStarEvaluationView *starView;

@end


@implementation ZBNEvaluateGoodsCell

+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNEvaluateGoodsCellID = @"ZBNEvaluateGoodsCellID";
    ZBNEvaluateGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNEvaluateGoodsCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNEvaluateGoodsCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
