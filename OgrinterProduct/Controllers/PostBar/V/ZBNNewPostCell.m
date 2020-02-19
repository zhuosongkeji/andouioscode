//
//  ZBNNewPostCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNNewPostCell.h"

#import "YNImageUploadView.h"
#import "Masonry.h"


@interface ZBNNewPostCell ()

/*! 标题 */
@property (weak, nonatomic) IBOutlet UITextField *titleT;
/*! 内容 */
@property (weak, nonatomic) IBOutlet UITextView *contentT;
/*! 图片上传的backView */
@property (weak, nonatomic) IBOutlet UIView *imgUpLoadView;
@property (nonatomic, weak) YNImageUploadView *upLoadView;
/*! 分类信息 */
@property (weak, nonatomic) IBOutlet UILabel *categaryL;
/*! 电话 */
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberL;
/*! 置顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/*! 不置顶 */
@property (weak, nonatomic) IBOutlet UIButton *notDingBtn;

@end

@implementation ZBNNewPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置图片上传控件
    [self setCellUpLoadView];
}


// 置顶点击
- (IBAction)dingBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.notDingBtn.selected = NO;
    }
    
}
// 不指定点击
- (IBAction)notDingBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.dingBtn.selected = NO;
    }
}

- (void)setCellUpLoadView
{
    __weak typeof(self)weakSelf = self;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
       YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
           config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
           config.photoCount = 1;
           config.autoHeight = YES;
           config.isNeedUpload = YES;
           config.uploadUrl = @"http://andou.zhuosongkj.com/index.php/api/goods/uploads";
           config.parameter = param;
       }];

           [weakSelf.imgUpLoadView addSubview:imageView];
             self.upLoadView = imageView;
           [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(weakSelf.imgUpLoadView);
           make.height.equalTo(@(80));
           }];
}


@end
