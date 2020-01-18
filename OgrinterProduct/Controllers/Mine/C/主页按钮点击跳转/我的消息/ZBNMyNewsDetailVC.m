//
//  ZBNMyNewsDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNMyNewsDetailVC.h"
#import "ZBNMyNewsDetailModel.h"

@interface ZBNMyNewsDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsContent;
@property (strong, nonatomic) ZBNMyNewsDetailModel *detailM;
@end

@implementation ZBNMyNewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通知信息";
    // 加载数据
    [self loadData];
    
}

- (void)loadData
{
        [FKHRequestManager cancleRequestWork];
       NSMutableDictionary *params = [NSMutableDictionary dictionary];
       NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
       userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
       params[@"uid"] = unmodel.uid;
        params[@"id"] = self.get_id;
       ADWeakSelf;
       [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNInformationURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
           
           if ([serverInfo.response[@"code"] intValue] == 200) {
               weakSelf.detailM = [ZBNMyNewsDetailModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
               [weakSelf.newsTitle setText:weakSelf.detailM.title];
               [weakSelf.newsContent setText:weakSelf.detailM.content];
           } else {
               [HUDManager showTextHud:[NSString stringWithFormat:@"%@",serverInfo.response[@"msg"]]];
           }
       }];
}


@end
