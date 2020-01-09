//
//  ZBNMyAllNewsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/9.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNMyAllNewsCell.h"

#import "ZBNMyAllNewsModel.h"


@interface ZBNMyAllNewsCell ()
/*! 图标 */
@property (weak, nonatomic) IBOutlet UIImageView *iconV;
/*! 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameL;
/*! 红色背景 */
@property (weak, nonatomic) IBOutlet UIView *redBackV;
/*! 消息条数 */
@property (weak, nonatomic) IBOutlet UILabel *countL;
@end

@implementation ZBNMyAllNewsCell


- (void)setAllM:(ZBNMyAllNewsModel *)allM
{
    self.iconV.image = [UIImage imageNamed:allM.iconV];
    self.countL.text = allM.count;
    self.nameL.text = allM.nameL;
    if ([allM.state isEqualToString:@"0"]) {
        self.redBackV.hidden = NO;
    } else if ([allM.state isEqualToString:@"1"]) {
        self.redBackV.hidden = YES;
    }
}


/*! 注册cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNMyAllNewsCellID = @"ZBNMyAllNewsCellID";
    ZBNMyAllNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyAllNewsCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMyAllNewsCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.redBackV.layer.cornerRadius = self.redBackV.height * 0.5;
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    [super setFrame:frame];
}

@end
