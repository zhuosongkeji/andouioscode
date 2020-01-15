//
//  ZBNHotelEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNHotelEntryCell.h"

#import "AddressView.h"
#import "SPModalView.h"
#import "YNImageUploadView.h"
#import "Masonry.h"

@interface ZBNHotelEntryCell ()
/*! 酒店门头图 */
@property (weak, nonatomic) IBOutlet UIView *hotelDoorImg;
@property (nonatomic, weak) YNImageUploadView *upLoadViewOne;
/*! 营业执照图 */
@property (weak, nonatomic) IBOutlet UIView *yyzzImg;
@property (nonatomic, weak) YNImageUploadView *upLoadViewTWo;
/*! 选择地址的label */
@property (weak, nonatomic) IBOutlet UILabel *chooseAddressL;
@end


@implementation ZBNHotelEntryCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 设置手势
    [self setupLabelGes];
    
    // 设置酒店图片上传
    [self setUpLoadViewOne];
    
    // 设置酒店图片上传
    [self setUpLoadViewTwo];
    
}

- (void)setupLabelGes
{
    self.chooseAddressL.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    [self.chooseAddressL addGestureRecognizer:labelGes];
}

- (void)labelClick
{
    if (self.chooseAddressLTask) {
        self.chooseAddressLTask();
    }
}

- (ZBNHotelEntryCell * _Nonnull (^)(NSString * _Nonnull))setLabelText
{
    return ^(NSString *text) {
        [self.chooseAddressL setText:text];
        return self;
    };
}


- (void)setUpLoadViewOne
{
    __weak typeof(self)weakSelf = self;
       NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
       userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
       NSMutableDictionary *param = [NSMutableDictionary dictionary];
           param[@"uid"] = unmodel.uid;
           param[@"token"] = unmodel.token;
          YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
              config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
              config.autoHeight = YES;
              config.isNeedUpload = YES;
              config.uploadUrl = @"http://andou.zhuosongkj.com/index.php/api/goods/uploads";
              config.parameter = param;
          }];

              [weakSelf.hotelDoorImg addSubview:imageView];
                self.upLoadViewOne = imageView;
              [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.equalTo(weakSelf.hotelDoorImg);
              make.height.equalTo(@(80));
              
              }];
}

- (void)setUpLoadViewTwo
{
    __weak typeof(self)weakSelf = self;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"token"] = unmodel.token;
       YNImageUploadView *imageView = [[YNImageUploadView alloc] initWithConfig:^(YNImageUploadViewConfig * _Nonnull config) {
           config.insets = UIEdgeInsetsMake(5, 10, 5, 10);
           config.autoHeight = YES;
           config.isNeedUpload = YES;
           config.uploadUrl = @"http://andou.zhuosongkj.com/index.php/api/goods/uploads";
           config.parameter = param;
       }];

           [weakSelf.yyzzImg addSubview:imageView];
             self.upLoadViewTWo = imageView;
           [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(weakSelf.yyzzImg);
           make.height.equalTo(@(80));
           }];
}




+ (instancetype)registerCellForTableView:(UITableView *)tableView
{
    static NSString * const ZBNHotelEntryCellID = @"ZBNHotelEntryCellID";
    ZBNHotelEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNHotelEntryCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNHotelEntryCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
