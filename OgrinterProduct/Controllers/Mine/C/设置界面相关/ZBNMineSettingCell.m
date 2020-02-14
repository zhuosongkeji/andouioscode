//
//  ZBNMineSettingCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/27.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineSettingCell.h"

#import "ZBNMineSettingModel.h"


#import <SDImageCache.h>




@interface ZBNMineSettingCell ()

// ------------------------用户的头像begin------------------------------->
/*! 用户的头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userIconV;
// ------------------------用户的头像end--------------------------------->

// ------------------------用户的昵称begin------------------------------->
/*! 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userName;
/*! 用户昵称view */
@property (weak, nonatomic) IBOutlet UIView *nameView;

// ------------------------用户的昵称end--------------------------------->

// ------------------------用户的密码begin------------------------------->
/*! 用户密码 */
@property (weak, nonatomic) IBOutlet UILabel *pwdLabel;
// ------------------------用户的密码end--------------------------------->

// ------------------------消息开关与网络播放begin------------------------->
/*! 新消息通知的开关 */
@property (weak, nonatomic) IBOutlet UISwitch *newsSwitch;
/*! 各种网络下载的开关 */
@property (weak, nonatomic) IBOutlet UISwitch *downLoadSwitch;
// ------------------------消息开关与网络播放end--------------------------->

// ------------------------版本号begin----------------------------------->
/*! 版本号 */
@property (weak, nonatomic) IBOutlet UILabel *editionLabel;

// ------------------------版本号end------------------------------------->

// ------------------------清除缓存begin--------------------------------->
/// /*! 清除缓存 */
@property (weak, nonatomic) IBOutlet UIView *cacheView;
/*! 显示缓存大小的label */
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeL;
// ------------------------清除缓存end----------------------------------->

// ---------------------电话号码的begin----------------------------------->
/*! 电话号码 */
@property (weak, nonatomic) IBOutlet UIView *phoneView;
/*! 用户电话 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
// ---------------------电话号码的end---------------------------------->
/*! 关于我们 */
@property (weak, nonatomic) IBOutlet UIView *aboutUsView;
/*! 意见反馈 */
@property (weak, nonatomic) IBOutlet UIView *feedbackView;
/*! 修改密码 */
@property (weak, nonatomic) IBOutlet UIView *changePwdView;


@end


@implementation ZBNMineSettingCell



/*! 设置模型数据 */
- (void)setSettingM:(ZBNMineSettingModel *)settingM
{
    // 设置数据
    _settingM = settingM;

    [self.userIconV setHeader:[NSString stringWithFormat:@"%@%@",imgServer,settingM.avator]];
    self.userName.text = settingM.name;
    self.phoneNumber.text = [NSString returnImportentNum:settingM.mobile];
}


///MARK: 生命周期方法
/*! 从xib中加载 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置手势
    [self setupGes];
    // 计算缓存大小
    [self countCacheSize];
    
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
    // 电话号码修改
    UITapGestureRecognizer *phoneGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhoneNum)];
    [self.phoneView addGestureRecognizer:phoneGes];
    // 修改密码
    UITapGestureRecognizer *changeGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePwd)];
    [self.changePwdView addGestureRecognizer:changeGes];
    // 清除缓存
    UITapGestureRecognizer *cacheGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cacheClear)];
    [self.cacheView addGestureRecognizer:cacheGes];
    // 用户昵称
    UITapGestureRecognizer *nameGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nameChange)];
    [self.nameView addGestureRecognizer:nameGes];
    // 头像
    UITapGestureRecognizer *userIconGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconUpload)];
    self.userIconV.userInteractionEnabled = YES;
    [self.userIconV addGestureRecognizer:userIconGes];
}


///MARK: 事件监听

- (void)iconUpload
{
    if (self.iconChangeTask) {
        self.iconChangeTask();
    }
}

- (void)nameChange
{
    if (self.nameChangeTask) {
        self.nameChangeTask();
    }
}

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

- (void)changePhoneNum
{
    if (self.changePhoneNumClickTask) {
        self.changePhoneNumClickTask();
    }
}

- (void)changePwd
{
    if (self.changePwdClickTask) {
        self.changePwdClickTask();
    }
}

- (void)cacheClear
{
    if ([self.cacheSizeL.text  isEqual: @"缓存大小(0B)"]) {
        [HUDManager showTextHud:@"没有缓存"];
        return;
    }
    
    [ZBNAlertTool zbn_alertTitle:@"清除缓存?" type:UIAlertControllerStyleAlert message:nil didTask:^{
        // 清除缓存
        [self clearCache];
    }];
    
    if (self.cacheClearClickTask) {
        self.cacheClearClickTask();
    }
}




#pragma mark -- 清除缓存相关
/*! */
- (void)countCacheSize
{
    self.cacheSizeL.text = @"正在计算缓存大小...";
    ADWeakSelf;
     // 在子线程计算缓存大小
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //#warning 睡眠
    //            [NSThread sleepForTimeInterval:5];
                
                // 获得所有缓存的总大小
                unsigned long long fileSize = ZBNSDWebImageCachePath.zbn_fileSize + ZBNCustomCachePath.zbn_fileSize;
                
                // 如果cell已经死了，那么后面的任务就没有意义
                if (weakSelf == nil) return;
                
                // 根据缓存大小生成字符串
                NSString *fileSizeText = nil;
                
                // pow(10, 9) == 10的9次方
                if (fileSize >= pow(10, 9)) { // fileSize >= 1GB
                    fileSizeText = [NSString stringWithFormat:@"%.1fGB", fileSize / pow(10, 9)];
                } else if (fileSize >= pow(10, 6)) { // fileSize >= 1MB
                    fileSizeText = [NSString stringWithFormat:@"%.1fMB", fileSize / pow(10, 6)];
                } else if (fileSize >= pow(10, 3)) { // fileSize >= 1KB
                    fileSizeText = [NSString stringWithFormat:@"%.1fKB", fileSize / pow(10, 3)];
                } else { // fileSize < 1KB
                    fileSizeText = [NSString stringWithFormat:@"%lluB", fileSize];
                }
                
                // 回到主线程设置文字
                               NSString *text = [NSString stringWithFormat:@"缓存大小(%@)", fileSizeText];
                               dispatch_async(dispatch_get_main_queue(), ^{
                                 
                                   // 显示文字
                                   weakSelf.cacheSizeL.text = text;
                               });
                           });
}

- (void)clearCache
{
    ADWeakSelf;
    
    
    
    self.cacheSizeL.text = @"正在清除缓存";
        // 在子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //#warning 睡眠
    //        [NSThread sleepForTimeInterval:2];
            
            // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
            // 删除文件夹
    [mgr removeItemAtPath:ZBNSDWebImageCachePath error:nil];
    [mgr removeItemAtPath:ZBNCustomCachePath error:nil];
    [mgr createDirectoryAtPath:ZBNCustomCachePath withIntermediateDirectories:YES attributes:nil error:nil];
            
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏弹框
                
                [HUDManager showTextHud:@"清除缓存成功"];
                // 文字
                weakSelf.cacheSizeL.text = @"暂无缓存";
                
               
            });
        });
}


@end
