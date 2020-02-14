//
//  ZBNHTReasonView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/13.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNHTReasonView.h"
#import "ZBNSHReturnGoodsComM.h"
#import "ZBNReturnGoodsReasonCell.h"

@interface ZBNHTReasonView () <UITableViewDelegate, UITableViewDataSource>
/*! 记录被选中的按钮 */
@property (nonatomic, strong) UIButton *selctedBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableV;

@end

@implementation ZBNHTReasonView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSHReturnGoodsComM *comM = [ZBNSHReturnGoodsComM sharedInstance];
    ZBNReturnGoodsReasonCell *cell = [ZBNReturnGoodsReasonCell regiserCellForTable:tableView];
    cell.returnM = self.dataArr[indexPath.row];
    ADWeakSelf;
    cell.selctedBtnClickTask = ^(ZBNReturnGoodsReasonCell * _Nonnull cell) {
        for (ZBNSHReCellM *model in self.dataArr) {
            if (model == cell.returnM) {
                model.is_selected = YES;
                [comM setReason_id:model.ID];
                [comM setContent:model.name];
            } else {
                model.is_selected = NO;
            }
        }
        [weakSelf.myTableV reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.myTableV.delegate = self;
    self.myTableV.dataSource = self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

     [self laodData];
}


- (void)laodData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"merchants_id"]  = self.merchants_id;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNHTReasonURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        weakSelf.dataArr = [ZBNSHReCellM mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [weakSelf.myTableV reloadData];
    }];
}

@end
