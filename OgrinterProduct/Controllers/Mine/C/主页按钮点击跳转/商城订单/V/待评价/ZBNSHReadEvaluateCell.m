//
//  ZBNSHReadEvaluateCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/6.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHReadEvaluateCell.h"
#import "TggStarEvaluationView.h"

@interface ZBNSHReadEvaluateCell ()

@property (weak, nonatomic) IBOutlet UIView *starBackView;

@property (nonatomic, weak) TggStarEvaluationView *starV;

@end


@implementation ZBNSHReadEvaluateCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupStartView];
}


- (void)setupStartView
{
    TggStarEvaluationView *starV = [TggStarEvaluationView evaluationViewWithChooseStarBlock:nil];
    starV.starCount = 4;
    starV.tapEnabled = NO;
    self.starV = starV;
    [self.starBackView addSubview:self.starV];
    self.starV.frame = CGRectMake(0, 0, self.starBackView.width , self.starBackView.height);
}


+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNSHReadEvaluateCellID = @"ZBNSHReadEvaluateCellID";
    ZBNSHReadEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNSHReadEvaluateCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNSHReadEvaluateCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
