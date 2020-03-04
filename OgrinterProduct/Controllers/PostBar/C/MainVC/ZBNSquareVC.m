//
//  ZBNSquareVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNSquareVC.h"

#import "ZBNSquareModel.h"
#import "ZBNPostShareView.h"
#import "ZBNPostDetailVC.h"
#import "ZBNPostUserModel.h"
#import "NSDate+Extension.h"
#import "ZBNPostComModel.h"
#import "ZBNSquareFrame.h"
#import "ZBNPostCommentCell.h"
#import "ZBNPostBarHeader.h"
#import "WMZDialog.h"
#import "ZBNRefreshHeader.h"

@interface ZBNSquareVC () <ZBNPostCommentDelegate,ZBNPostBarHeaderDelegate,ZBNPostBarHeaderDelegate>
/*! 保存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! squareFrame 模型 */
@property (nonatomic , strong) NSMutableArray *squareFrames;
/** users */
@property (nonatomic , strong) NSMutableArray *users;
/** textString */
@property (nonatomic , copy) NSString *textString;
@property (nonatomic, copy) NSString *nextPage;
@end

@implementation ZBNSquareVC

static NSString * const ZBNPostComCellId = @"com";

- (NSMutableArray *)squareFrames
{
    if (!_squareFrames) {
        _squareFrames = [NSMutableArray array];
    }
    return _squareFrames;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)loadNewData
{
    self.nextPage = @"2";
    [FKHRequestManager cancleRequestWork];
    [self.squareFrames removeAllObjects];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"type"] = @"public";
    param[@"page"] = @"1";
    ADWeakSelf;
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:@"http://andou.zhuosongkj.com/index.php/api/tieba/list" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNSquareModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        for (ZBNSquareModel *model in weakSelf.dataArr) {
         [weakSelf.squareFrames addObject: [weakSelf _topicFrameWithSquare:model]];
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
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"type"] = @"public";
    param[@"page"] = self.nextPage;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:@"http://andou.zhuosongkj.com/index.php/api/tieba/list" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        weakSelf.dataArr = [ZBNSquareModel mj_objectArrayWithKeyValuesArray:serverInfo.response[@"data"]];
        for (ZBNSquareModel *model in weakSelf.dataArr) {
         [self.squareFrames addObject: [self _topicFrameWithSquare:model]];
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



#pragma mark - 辅助方法
/** topic --- topicFrame */
- (ZBNSquareFrame *)_topicFrameWithSquare:(ZBNSquareModel *)square
{
    ZBNSquareFrame *squareFrame = [[ZBNSquareFrame alloc] init];
    // 传递微博模型数据，计算所有子控件的frame
    squareFrame.squareM = square;
    
    return squareFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupRefresh];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNPostCommentCell" bundle:nil] forCellReuseIdentifier:ZBNPostComCellId];
    
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


// 设置tableView样式
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.squareFrames.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZBNSquareFrame *squareFrame = self.squareFrames[section];
    return squareFrame.commentFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNPostCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNPostComCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZBNSquareFrame *squareM = self.squareFrames[indexPath.section];
    ZBNCommentFrame *conmenFrame = squareM.commentFrames[indexPath.row];
    cell.commentFrame = conmenFrame;
    cell.delegate = self;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZBNPostBarHeader *headerV = [ZBNPostBarHeader headerViewWithTableView:tableView];
    ZBNSquareFrame *squareM = self.squareFrames[section];
    headerV.squareFrame = squareM;
    headerV.delegate = self;
    return headerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNSquareFrame *squareM = self.squareFrames[indexPath.section];
    ZBNCommentFrame *commentFrame = squareM.commentFrames[indexPath.row];
    return commentFrame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    ZBNSquareFrame *squareFrame = self.squareFrames[section];
    return squareFrame.height;
}


#pragma mark -- ZBNHeaderViewDelegate
// 点击分享
- (void)squareHeaderDidClickShareBtn:(ZBNPostBarHeader *)postHeader
{
    WMZDialog *alert = Dialog();
    alert.wTypeSet(DialogTypeShare).wTitleSet(@"分享到").wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row){
        
    }).wDataSet(@[@{@"name":@"微信",@"image":@"weiin"},
                  @{@"name":@"朋友圈",@"image":@"wexinPen"}]).wStart();
}

// 点击评论
- (void)squareHeaderDidClickCommentBtn:(ZBNPostBarHeader *)postHeader
{
    ZBNPostDetailVC *detailVC = [[ZBNPostDetailVC alloc] init];
    detailVC.post_id = postHeader.squareFrame.squareM.ID;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

// 点赞
- (void)squareHeaderDidClickDingBtn:(ZBNPostBarHeader *)postHeader dingBtn:(UIButton *)dingBtn
{
     [FKHRequestManager cancleRequestWork];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"post_id"] = postHeader.squareFrame.squareM.ID;
        if (dingBtn.selected) {
            param[@"vote"] = @0;
        } else {
            param[@"vote"] = @1;
        }
        ADWeakSelf;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/tieba/upvote" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
            
        }];
}

// 点赞请求
- (void)dingRequest
{
    
}

@end
