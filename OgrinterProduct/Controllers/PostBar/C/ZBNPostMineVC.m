//
//  ZBNPostMineVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostMineVC.h"

#import "ZBNPostBarCell.h"
#import "ZBNSquareModel.h"
#import "ZBNPostShareView.h"

@interface ZBNPostMineVC ()
/*! 保存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ZBNPostMineVC

static NSString * const ZBNPostMineCellId = @"post";

- (void)viewDidLoad {
    [super viewDidLoad];
    
       // 注册
       [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZBNPostBarCell class]) bundle:nil] forCellReuseIdentifier:ZBNPostMineCellId];
       self.navigationController.navigationBar.translucent = NO;
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    
       [self initModel];
}

- (void)initModel
{
    for (int i = 0; i < 10; i ++) {
        ZBNSquareModel *model = [[ZBNSquareModel alloc] init];
        if (i == 3) {
            model.userIcon = @"yxj";
            model.isDing = YES;
            model.time = @"1999:6:17 16:32";
            model.title = @"屌";
            model.contentL = @"无情哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈嗝";
            model.userName = @"大总";
            model.hasImg = YES;
        } else if (i == 5){
            model.isDing = NO;
            model.time = @"2020:6:17 16:32";
            model.title = @"不是很屌";
            model.contentL = @"无情嘻嘻嘻嘻嘻嘻我嘻嘻嘻嘻嘻嘻嘻嗝";
            model.hasImg = NO;
            model.userName = @"小总";
            model.cComCount = @"3";
            model.cUserIcon = @"yxj";
            model.cUserCom = @"laji";
            model.cUserName = @"hehe";
            model.userIcon = @"yxj";
        } else {
            model.isDing = NO;
            model.time = @"2090:42:43 99:00";
            model.title = @"gege";
            model.contentL = @"hohohhohodhawdhoahdoahofhoahwfoa";
            model.hasImg = YES;
            model.userName = @"jj";
            model.cComCount = @"9090";
            model.cUserIcon = @"yxj";
            model.cUserCom = @"lajidjiahduhafhahwfawf";
            model.cUserName = @"hehedafahfahfahfiua";
            model.userIcon = @"yxj";
        }
        if (model.isDing) {
            [self.dataArr insertObject:model atIndex:0];
        } else {
            [self.dataArr addObject:model];
        }
    }
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ZBNPostBarCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNPostMineCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.squareM = self.dataArr[indexPath.row];
    ADWeakSelf;
    // 分享点击
    cell.shareBtnClickTask = ^(ZBNSquareModel * _Nonnull model) {
        ZBNPostShareView *shareView = [ZBNPostShareView viewFromXib];
        shareView.width = KSCREEN_WIDTH;
        QWAlertView *alertV = [QWAlertView sharedMask];
        [alertV show:shareView withType:0 animationFinish:^{
            
        } dismissHandle:^{
            
        }];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSquareModel *model = self.dataArr[indexPath.row];
    return model.cellHeight;
}

#pragma mark -- lazy

- (NSMutableArray *)dataArr
{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
