//
//  ZBNPostMyReplyedVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/3/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostMyReplyedVC.h"
#import "ZBNPostComReplyCell.h"
#import "ZBNPostComReplyM.h"
#import "ZBNPostComReplyFrame.h"
#import "ZBNRefreshHeader.h"
#import "ZBNPostDetailVC.h"
#import "ZBNComDataNilCell.h"

@interface ZBNPostMyReplyedVC ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *frames;
@property (nonatomic, copy) NSString *nextPage;
@end

@implementation ZBNPostMyReplyedVC

- (NSMutableArray *)frames
{
    if (!_frames) {
        _frames = [NSMutableArray array];
    }
    return _frames;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
    self.navigationItem.title = @"收到的回复";
       self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       if (@available(iOS 11.0, *)) {
           self.tableView  .contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
       }else {
           self.automaticallyAdjustsScrollViewInsets = YES;
       }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:@"Dismiss" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)readRequestWithInfoID:(NSString *)infoId
{
    [FKHRequestManager cancleRequestWork];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = unmodel.uid;
    params[@"info_id"] = infoId;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/info/read" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
       
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.frames.count > 0) {
        return self.frames.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.frames.count > 0) {
        ZBNPostComReplyCell *cell = [ZBNPostComReplyCell cellWithTableView:tableView];
        cell.commentFrame = self.frames[indexPath.row];
        return cell;
    } else {
        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.frames.count > 0) {
        ZBNPostComReplyFrame *frame = self.frames[indexPath.row];
        return frame.cellHeight;
    } else {
        return self.view.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.frames.count > 0) {
        ZBNPostDetailVC *vc = [[ZBNPostDetailVC alloc] init];
        ZBNPostComReplyFrame *frame = self.frames[indexPath.row];
        vc.post_id = frame.reM.post_id;
        [self readRequestWithInfoID:frame.reM.info_id];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
    }
}


#pragma mark - 辅助方法
/** topic --- topicFrame */
- (ZBNPostComReplyFrame *)_topicFrameWithSquare:(ZBNPostComReplyM *)reM
{
    ZBNPostComReplyFrame *frame = [[ZBNPostComReplyFrame alloc] init];
    // 传递微博模型数据，计算所有子控件的frame
    frame.reM = reM;
    
    return frame;
}

- (void)setupRefresh
{
    // 下拉刷新
    self.tableView.mj_header = [ZBNRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadNewData
{
    self.nextPage = @"2";
    [FKHRequestManager cancleRequestWork];
    [self.frames removeAllObjects];
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = unmodel.uid;
    params[@"level"] = @"3";
    params[@"type_id"] = @"5";
    params[@"page"] = @"1";
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:@"http://andou.zhuosongkj.com/index.php/api/info/list" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNPostComReplyM mj_objectArrayWithKeyValuesArray:[serverInfo.response[@"data"][@"list"] objectForKey:@"list"]];
        for (ZBNPostComReplyM *reM in weakSelf.dataArr) {
             [weakSelf.frames addObject: [self _topicFrameWithSquare:reM]];
        }
        if (weakSelf.dataArr.count < 10) {
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

- (void)loadMoreData
{
    [FKHRequestManager cancleRequestWork];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = unmodel.uid;
    params[@"level"] = @"3";
    params[@"type_id"] = @"5";
    params[@"page"] = self.nextPage;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:@"http://andou.zhuosongkj.com/index.php/api/info/list" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNPostComReplyM mj_objectArrayWithKeyValuesArray:[serverInfo.response[@"data"][@"list"] objectForKey:@"list"]];
        for (ZBNPostComReplyM *reM in weakSelf.dataArr) {
             [weakSelf.frames addObject: [self _topicFrameWithSquare:reM]];
        }
        if (weakSelf.dataArr.count < 10) {
            weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView reloadData];
        self.nextPage = [NSString stringWithFormat:@"%d",(self.nextPage.intValue + 1)];
    }];
    
}

@end
