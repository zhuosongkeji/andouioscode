//
//  ZBNPostMineVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostMineVC.h"

#import "ZBNSquareModel.h"
#import "ZBNPostDetailVC.h"
#import "ZBNPostUserModel.h"
#import "NSDate+Extension.h"
#import "ZBNPostComModel.h"
#import "ZBNSquareFrame.h"
#import "ZBNPostCommentCell.h"
#import "ZBNRefreshHeader.h"
#import "WMZDialog.h"
#import "ZBNTopicCell.h"
#import "ZBNTopicCommentCell.h"
#import "ZBNTopicComFrame.h"
#import "ZBNTopicFrame.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "ZBNComDataNilCell.h"

@interface ZBNPostMineVC () <ZBNTopicDelegate>
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

@implementation ZBNPostMineVC

static NSString * const ZBNPostMineCellId = @"com";

- (NSMutableArray *)squareFrames
{
    if (!_squareFrames) {
        _squareFrames = [NSMutableArray array];
    }
    return _squareFrames;
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
    param[@"type"] = @"mine";
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
    param[@"type"] = @"mine";
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


#pragma mark - 辅助方法
/** topic --- topicFrame */
- (ZBNTopicFrame *)_topicFrameWithSquare:(ZBNSquareModel *)square
{
    ZBNTopicFrame *squareFrame = [[ZBNTopicFrame alloc] init];
    // 传递微博模型数据，计算所有子控件的frame
    squareFrame.topic = square;
    
    return squareFrame;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNPostCommentCell" bundle:nil] forCellReuseIdentifier:ZBNPostMineCellId];
      
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.squareFrames.count > 0) {
        return self.squareFrames.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.squareFrames.count > 0) {
        ADWeakSelf;
        ZBNTopicFrame *frame = self.squareFrames[indexPath.row];
        ZBNTopicCell *cell = [ZBNTopicCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.topicFrame = frame;
        cell.cellIncellDidClick = ^(ZBNTopicCell * _Nonnull cell) {
            ZBNPostDetailVC *vc = [[ZBNPostDetailVC alloc] init];
            vc.post_id = cell.topicFrame.topic.ID;
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    } else {
        ZBNComDataNilCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNComDataNilCell" owner:nil options:nil].lastObject;
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.squareFrames.count > 0) {
        ZBNTopicFrame *frame = self.squareFrames[indexPath.row];
           if (frame.tableViewFrame.size.height == 0) {
               return frame.topicHeight + frame.tableViewFrame.size.height;
           } else {
               return frame.topicHeight + frame.tableViewFrame.size.height + 30;
           }
    } else {
        return self.view.height;
    }
}

- (void)topicCellDidClickUser:(ZBNTopicCell *)cell
{
    ZBNPostDetailVC *vc = [[ZBNPostDetailVC alloc] init];
    vc.post_id = cell.topicFrame.topic.ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)topicDidClickShareBtn:(ZBNTopicCell *)cell
{
    WMZDialog *alert = Dialog();
       alert.wTypeSet(DialogTypeShare).wTitleSet(@"分享到").wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row){

           if ([anyID isEqualToString:@"微信"]) {
               UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

               UMShareWebpageObject*shareObject = [UMShareWebpageObject shareObjectWithTitle:@"挑战你的记忆力"descr:@"鱼的记忆有七秒，你的呢？"thumImage:[UIImage imageNamed:@"loginIcon"]];

               shareObject.webpageUrl = @"www.baidu.com";
               messageObject.shareObject= shareObject;

               [[UMSocialManager defaultManager]shareToPlatform:UMSocialPlatformType_WechatSession  messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
                   if (error) {
                       NSLog(@"分享失败：%@",error);
                       [HUDManager showTextHud:@"分享失败!未安装应用"];
                   }else{
                       NSLog(@"分享 result = %@",result);
                   }
               }];
           }


       }).wDataSet(@[@{@"name":@"微信",@"image":@"weiin"},
                     @{@"name":@"朋友圈",@"image":@"wexinPen"}]).wStart();
}

- (void)topicDidClickCommentBtn:(ZBNTopicCell *)cell
{
    ZBNPostDetailVC *vc = [[ZBNPostDetailVC alloc] init];
    vc.post_id = cell.topicFrame.topic.ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)topicDidClickThumbBtn:(ZBNTopicCell *)cell
{
   if (cell.topicFrame.topic.is_vote == 1) {
       [self dingRequest:@"0" cell:cell];
   } else {
       [self dingRequest:@"1" cell:cell];
   }
}

//// 点赞请求
- (void)dingRequest:(NSString *)vote cell:(ZBNTopicCell *)cell
{
    [FKHRequestManager cancleRequestWork];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"post_id"] = cell.topicFrame.topic.ID;
    param[@"vote"] = vote;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/tieba/upvote" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        [HUDManager showTextHud:serverInfo.response[@"msg"]];
    }];
}



@end
