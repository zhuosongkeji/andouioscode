//
//  ADCommonStaticCell.m
//  AnDouBusiness
//
//  Created by 周芳圆 on 2019/12/6.
//  Copyright © 2019 ZhouBunian. All rights reserved.
//

#import "ADCommonStaticCell.h"



@implementation ADCommonStaticCell

+ (instancetype)ad_initWithTableView:(UITableView *)tableView cellStyle:(UITableViewCellStyle)style
{
    static NSString *ID = @"businessCell";
    ADCommonStaticCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ADCommonStaticCell alloc] initWithStyle:style reuseIdentifier:ID];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineView = [[UIView alloc] init];
        CGFloat lineX = 0;
        CGFloat lineW = KSCREEN_WIDTH;
        CGFloat lineH = 1;
        CGFloat lineY = cell.height - 1;
        lineView.backgroundColor = [UIColor lightGrayColor];
        lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
        [cell.contentView addSubview:lineView];
        }
    return cell;
}


- (void)setRowItemModel:(ADCellRowItemModel *)rowItemModel
{
    _rowItemModel = rowItemModel;
    [self setData:rowItemModel];
    [self setAssoryView:rowItemModel];
}

- (void)setData:(ADCellRowItemModel *)rowModel
{
  
    
}

//设置辅助视图
- (void)setAssoryView:(ADCellRowItemModel *)rowModel
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect accesoryViewFrame = self.accessoryView.frame;
    accesoryViewFrame.origin.x -= 5;
    self.accessoryView.frame = accesoryViewFrame;
}

@end
