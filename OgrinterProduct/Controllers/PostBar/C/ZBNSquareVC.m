//
//  ZBNSquareVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSquareVC.h"

#import "ZBNPostBarCell.h"
#import "ZBNSquareModel.h"
#import "ZBNPostShareView.h"
#import "ZBNPostDetailVC.h"


@interface ZBNSquareVC ()
/*! 保存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ZBNSquareVC

static NSString * const ZBNPostBarCellId = @"post";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZBNPostBarCell class]) bundle:nil] forCellReuseIdentifier:ZBNPostBarCellId];
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
            model.isDing = YES;
            model.time = @"1999:6:17 16:32";
            model.title = @"屌";
            model.contentL = @"无情哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈嗝";
            model.userName = @"大总";
            model.hasImg = YES;
            model.userIcon = @"农家乐入驻";
        } else if (i == 5){
            model.isDing = NO;
            model.userIcon = @"农家乐入驻";
            model.time = @"2020:6:17 16:32";
            model.title = @"不是很屌";
            model.contentL = @"无情嘻嘻嘻嘻嘻嘻我嘻嘻嘻嘻嘻嘻嘻嗝";
            model.hasImg = NO;
            model.userName = @"小总";
            model.cComCount = @"3";
            model.cUserIcon = @"农家乐入驻";
            model.cUserCom = @"laji";
            model.cUserName = @"hehe";
            model.cUserCom = @"农家乐入驻";
        } else {
            model.isDing = NO;
            model.userIcon = @"农家乐入驻";
            model.time = @"2090:42:43 99:00";
            model.title = @"gege";
            model.contentL = @"hohohhohodhawdhoahdoahofhoahwfoa";
            model.hasImg = YES;
            model.userName = @"jj";
            model.cComCount = @"9090";
            model.cUserCom = @"lajidjiahduhafhahwfawf";
            model.cUserName = @"hehedafahfahfahfiua";
            model.cUserIcon = @"农家乐入驻";
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
   
    ZBNPostBarCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNPostBarCellId];
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
    NSLog(@"height00----");
    return model.cellHeight;
}

#pragma mark -- delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNPostDetailVC *vc = [[ZBNPostDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
