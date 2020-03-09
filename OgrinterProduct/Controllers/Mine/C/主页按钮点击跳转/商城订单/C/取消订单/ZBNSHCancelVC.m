//
//  ZBNSHCancelVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/5.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSHCancelVC.h"
#import "WMZDialog.h"


@interface ZBNSHCancelVC () <UITextViewDelegate>
/*! 选择理由按钮 */
@property (weak, nonatomic) IBOutlet UIButton *reasonBtn;
/*! 详细描述 */
@property (weak, nonatomic) IBOutlet UITextView *detailReasonT;
@property (nonatomic, strong) NSNumber *reason_id;
@property (nonatomic, copy) NSString *detailR;
@end

@implementation ZBNSHCancelVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.detailReasonT.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.detailReasonT.text.length <= 3) {
        self.detailReasonT.text = nil;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.detailR = self.detailReasonT.text;
}


/*! 选择理由点击 */
- (IBAction)reasonBtnClick:(UIButton *)sender {
    ADWeakSelf;
    self.reason_id = nil;
    Dialog().
    wTypeSet(DialogTypeSheet).
    wDataSet(@[@"我不想买了",@"信息填写错误重拍",@"卖家缺货",@"其他原因"]).
    wTitleSet(@"请选择").
    wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type){
        if ([anyID isEqualToString:@"我不想买了"]) {
            [weakSelf.reasonBtn setTitle:anyID forState:UIControlStateNormal];
            weakSelf.reason_id = @1;
        } else if ([anyID isEqualToString:@"信息填写错误重拍"]) {
            [weakSelf.reasonBtn setTitle:anyID forState:UIControlStateNormal];
            weakSelf.reason_id = @2;
        } else if ([anyID isEqualToString:@"卖家缺货"]) {
            [weakSelf.reasonBtn setTitle:anyID forState:UIControlStateNormal];
            weakSelf.reason_id = @3;
        } else if ([anyID isEqualToString:@"其他原因"]) {
            [weakSelf.reasonBtn setTitle:anyID forState:UIControlStateNormal];
            weakSelf.reason_id = @4;
        }
    }).
    wStart();
}
/*! 取消订单点击 */
- (IBAction)cancelBtnClick:(UIButton *)sender {
    
    if ([self.reasonBtn.titleLabel.text isEqualToString:@"选择取消订单的原因"]) {
        [HUDManager showTextHud:@"选择取消订单的原因"];
        return;
    }
    
    [self loadRequest];
}


- (void)loadRequest
{
    ADWeakSelf;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"order_sn"] = self.order_sn;
    params[@"reason_id"] = self.reason_id;
    params[@"reason"] = self.detailR;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/order/cancel" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            
        }];
}


@end
