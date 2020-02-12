//
//  ZBNMyIntegerHeadView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/11.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMyIntegerHeadView.h"
#import "ZBNMyIntegralModel.h"

@interface ZBNMyIntegerHeadView ()
/*! 我的积分 */
@property (weak, nonatomic) IBOutlet UILabel *myIntegerLabel;
/*! 模型 */
@property (nonatomic, strong) ZBNMyIntegralModel *integerM;
@end

@implementation ZBNMyIntegerHeadView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 加载数据
    [self loadData];
    
}

/*! 加载数据 */
- (void)loadData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNIntegerURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.integerM = [ZBNMyIntegralModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
        if (weakSelf.integerM.integral) {
            weakSelf.myIntegerLabel.text = weakSelf.integerM.integral;
        } else {
            weakSelf.myIntegerLabel.text = @"您没得积分喔";
        }
    }];
}

@end
