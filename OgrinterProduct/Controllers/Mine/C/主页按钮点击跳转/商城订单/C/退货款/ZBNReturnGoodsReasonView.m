//
//  ZBNReturnGoodsReasonView.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/20.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNReturnGoodsReasonView.h"
#import "ZBNSHReCellM.h"
#import "ZBNReturnGoodsReasonCell.h"
#import "ZBNSHReturnGoodsComM.h"

@interface ZBNReturnGoodsReasonView () <UITableViewDelegate, UITableViewDataSource>


/*! 记录被选中的按钮 */
@property (nonatomic, strong) UIButton *selctedBtn;
/*! table */
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end


@implementation ZBNReturnGoodsReasonView

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
        [weakSelf.myTable reloadData];
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
    // 加载数据
    [self laodData];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
}

- (void)laodData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNReasonURL params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        weakSelf.dataArr = [ZBNSHReCellM mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        [weakSelf.myTable reloadData];
    }];
}

@end
