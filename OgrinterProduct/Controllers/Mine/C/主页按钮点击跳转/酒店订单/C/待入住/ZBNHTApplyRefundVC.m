//
//  ZBNHTApplyRefundVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/1/14.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTApplyRefundVC.h"
#import "ZBNSHReCellM.h"
#import "ZBNSHReturnGoodsComM.h"
#import "WMZDialog.h"

@interface ZBNHTApplyRefundVC ()

@property (weak, nonatomic) IBOutlet UILabel *moneyL;
@property (weak, nonatomic) IBOutlet UILabel *reasonL;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) NSString *reason_id;
@property (weak, nonatomic) IBOutlet UITextField *remarkT;

@end

@implementation ZBNHTApplyRefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.moneyL setText:[NSString stringWithFormat:@"¥%@",self.money]];
    
    // 设置手势
    [self setupGes];
}

/*! 申请退款 */
- (IBAction)refundBtnClick:(UIButton *)sender {
    if (self.remarkT.text.length > 0) {
        [self loadData];
    } else {
        [HUDManager showTextHud:@"请填写备注"];
    }
    
}

- (void)setupGes
{
    UITapGestureRecognizer *reasonGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reasonClick)];
    self.reasonL.userInteractionEnabled = YES;
    [self.reasonL addGestureRecognizer:reasonGes];
    
}

- (void)reasonClick
{
    Dialog().
       wTypeSet(DialogTypeSheet).
       wDataSet(@[@"行程冲突",@"临时变动",@"其他"]).
       wTitleSet(@"请选择").
       wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type){
           if ([anyID isEqualToString:@"行程冲突"]) {
               self.reason_id = @"8";
           }
           if ([anyID isEqualToString:@"临时变动"]) {
               self.reason_id = @"9";
           }
           if ([anyID isEqualToString:@"其他"]) {
               self.reason_id = @"10";
           }
       }).
       wStart();
    
}

- (void)loadData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"book_sn"] = self.order_sn;
    params[@"refund_id"] = self.reason_id;
    params[@"refund_msg"] = self.remarkT.text;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/htorder/refund" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] intValue] == 200) {
            [HUDManager showStateHud:@"申请成功" state:HUDStateTypeSuccess];
        } else {
            [HUDManager showStateHud:@"申请失败" state:HUDStateTypeFail];
        }
    }];
}




@end
