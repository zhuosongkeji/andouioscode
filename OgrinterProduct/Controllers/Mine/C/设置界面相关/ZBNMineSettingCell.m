//
//  ZBNMineSettingCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineSettingCell.h"

#import "ZBNMineSettingModel.h"

@interface ZBNMineSettingCell ()
/*! 关于我们 */
@property (weak, nonatomic) IBOutlet UIView *aboutUsView;
/*! 意见反馈 */
@property (weak, nonatomic) IBOutlet UIView *feedbackView;
/*! 用户的头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userIconV;
/*! 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/*! 用户电话 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
/*! 用户密码 */
@property (weak, nonatomic) IBOutlet UILabel *pwdLabel;
/*! 新消息通知的开关 */
@property (weak, nonatomic) IBOutlet UISwitch *newsSwitch;
/*! 各种网络下载的开关 */
@property (weak, nonatomic) IBOutlet UISwitch *downLoadSwitch;
/*! 清空缓存 */
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
/*! 版本号 */
@property (weak, nonatomic) IBOutlet UILabel *editionLabel;


@end


@implementation ZBNMineSettingCell

/*! 设置模型数据 */
- (void)setSettingM:(ZBNMineSettingModel *)settingM
{
    // 设置数据
    _settingM = settingM;
//    [self.userIconV sd_setImageWithURL:[NSURL URLWithString:settingM.avator]];
    self.userName.text = settingM.name;
    self.phoneNumber.text = settingM.mobile;
//    self.pwdLabel.text = [NSString stringWithFormat:@"%@",settingM.password];
}


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
