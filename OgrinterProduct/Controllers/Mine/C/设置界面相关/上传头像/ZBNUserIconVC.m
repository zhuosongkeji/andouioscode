//
//  ZBNUserIconVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNUserIconVC.h"
#import "YNImageUploadView.h"
#import "Masonry.h"
#import "ZBNMallEntryModel.h"


@interface ZBNUserIconVC ()

@property (weak, nonatomic) IBOutlet UIView *iconBackView;
@property (nonatomic, weak) YNImageUploadView *upLoadView;
@property (nonatomic, strong) ZBNMallEntryModel *model;

@end

@implementation ZBNUserIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置图片上传的view
    [self setUpLoadView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"头像修改";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLoadNote) name:@"getURLOne" object:nil];
    
}

- (void)upLoadNote
{
    ZBNMallEntryModel *model = [ZBNMallEntryModel sharedInstance];
    [model setUrlOne:model.upURLOne];
}

- (IBAction)changeBtnClick:(id)sender {
        [self loadRequest];
}


- (void)loadRequest
{
    // 拿到uid 和 token
    [FKHRequestManager cancleRequestWork];
        ZBNMallEntryModel *model = [ZBNMallEntryModel sharedInstance];
       NSMutableDictionary *params = [NSMutableDictionary dictionary];
       NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
       userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
       params[@"id"] = unmodel.uid;
       params[@"token"] = unmodel.token;
        params[@"avator"] = model.upURLOne;

       // 发送网络请求
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/modification/user_pictures" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           if ([serverInfo.response[@"code"] intValue] == 200) {
               [HUDManager showStateHud:@"确认修改成功,等待系统审核" state:HUDStateTypeSuccess];
               // 发送通知
               [[NSNotificationCenter defaultCenter] postNotificationName:@"iconChangeOK" object:nil];
           } else {
               [HUDManager showStateHud:@"修改失败" state:HUDStateTypeFail];
           }
       }];
}

- (void)setUpLoadView
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

              [weakSelf.iconBackView addSubview:imageView];
                self.upLoadView = imageView;
              [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.equalTo(weakSelf.iconBackView);
              make.height.equalTo(@(80));
              
              }];
}

@end
