//
//  ZBNMineSettingCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineSettingCell.h"


@interface ZBNMineSettingCell ()
/*! 关于我们 */
@property (weak, nonatomic) IBOutlet UIView *aboutUsView;
/*! 意见反馈 */
@property (weak, nonatomic) IBOutlet UIView *feedbackView;



@end


@implementation ZBNMineSettingCell




///MARK: 生命周期方法
/*! 从xib中加载 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置手势
    [self setupGes];
}

/*! 注册cell */
+ (instancetype)regiserCellForTable:(UITableView *)tableView
{
    static NSString * const ZBNMineSettingCellID = @"ZBNMineSettingCellID";
    ZBNMineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNMineSettingCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNMineSettingCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}



///MARK: 设置手势
- (void)setupGes
{
    // 关于我们
    UITapGestureRecognizer *aboutUsGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aboutUsClick)];
    [self.aboutUsView addGestureRecognizer:aboutUsGes];
    // 意见反馈
    UITapGestureRecognizer *feedbackGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedbackClick)];
    [self.feedbackView addGestureRecognizer:feedbackGes];
}


///MARK: 事件监听
- (void)aboutUsClick
{
    if (self.aboutUsCellClickTask) {
        self.aboutUsCellClickTask();
    }
}

- (void)feedbackClick
{
    if (self.feedbackClickTask) {
        self.feedbackClickTask();
    }
}


@end
