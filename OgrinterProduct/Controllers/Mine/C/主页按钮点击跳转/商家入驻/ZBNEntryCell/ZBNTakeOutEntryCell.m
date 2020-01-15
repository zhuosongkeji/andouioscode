//
//  ZBNTakeOutEntryCell.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNTakeOutEntryCell.h"

#import "YNImageUploadView.h"
#import "Masonry.h"


@interface ZBNTakeOutEntryCell ()
/*! 酒店门头图 */
@property (weak, nonatomic) IBOutlet UIView *doorImgV;
@property (nonatomic, weak) YNImageUploadView *upLoadViewOne;
/*! 营业执照 */
@property (weak, nonatomic) IBOutlet UIView *yyzzImg;
@property (nonatomic, weak) YNImageUploadView *upLoadViewTWo;
/*! 选择地址的label */
@property (weak, nonatomic) IBOutlet UILabel *chooseAddressL;


@end

@implementation ZBNTakeOutEntryCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupLabelGes];
    [self setUpLoadViewOne];
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

- (ZBNTakeOutEntryCell * _Nonnull (^)(NSString * _Nonnull))setLabelText
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

              [weakSelf.doorImgV addSubview:imageView];
                self.upLoadViewOne = imageView;
              [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.equalTo(weakSelf.doorImgV);
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
    static NSString * const ZBNTakeOutEntryCellID = @"ZBNTakeOutEntryCellID";
    ZBNTakeOutEntryCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNTakeOutEntryCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNTakeOutEntryCell" owner:nil options:nil].lastObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}





@end
