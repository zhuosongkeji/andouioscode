//
//  ZBNMyNewsCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyNewsCell.h"
#import "UIImage+ZBNExtension.h"

@interface ZBNMyNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userIconView;


@end

@implementation ZBNMyNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userIconView.image = [UIImage circleImageNamed:@"yxj"];
}

/*! 注册cell */
+ (instancetype)registerCellForTable:(UITableView *)tableView
{
    static NSString  * const ZBNMyNewsCellID = @"news";
    ZBNMyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMyNewsCellID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMyNewsCell" owner:nil options:nil].lastObject;
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
