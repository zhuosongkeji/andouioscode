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


@interface ZBNSquareVC () <ZBNPostCommentDelegate,ZBNPostBarHeaderDelegate,ZBNPostBarHeaderDelegate>
/*! 保存数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataArr;
/*! squareFrame 模型 */
@property (nonatomic , strong) NSMutableArray *squareFrames;
/** users */
@property (nonatomic , strong) NSMutableArray *users;
/** textString */
@property (nonatomic , copy) NSString *textString;

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

- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
        
        ZBNPostUserModel *user0 = [[ZBNPostUserModel alloc] init];
        user0.userId = @"1000";
        user0.nickname = @"CoderMikeHe";
        user0.avatarUrl = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1206211006,1884625258&fm=58";
        [_users addObject:user0];
        
        
        ZBNPostUserModel *user1 = [[ZBNPostUserModel alloc] init];
        user1.userId = @"1001";
        user1.nickname = @"吴亦凡";
        user1.avatarUrl = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2625917416,3846475495&fm=58";
        [_users addObject:user1];
        
        
        ZBNPostUserModel *user2 = [[ZBNPostUserModel alloc] init];
        user2.userId = @"1002";
        user2.nickname = @"杨洋";
        user2.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=413353707,3948222604&fm=58";
        [_users addObject:user2];
        
        
        ZBNPostUserModel *user3 = [[ZBNPostUserModel alloc] init];
        user3.userId = @"1003";
        user3.nickname = @"陈伟霆";
        user3.avatarUrl = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=3937650650,3185640398&fm=58";
        [_users addObject:user3];
        
        
        ZBNPostUserModel *user4 = [[ZBNPostUserModel alloc] init];
        user4.userId = @"1004";
        user4.nickname = @"张艺兴";
        user4.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1691925636,1723246683&fm=58";
        [_users addObject:user4];
        
        
        ZBNPostUserModel *user5 = [[ZBNPostUserModel alloc] init];
        user5.userId = @"1005";
        user5.nickname = @"鹿晗";
        user5.avatarUrl = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=437161406,3838120455&fm=58";
        [_users addObject:user5];
        
        
        ZBNPostUserModel *user6 = [[ZBNPostUserModel alloc] init];
        user6.userId = @"1006";
        user6.nickname = @"杨幂";
        user6.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1663450221,575161902&fm=58";
        [_users addObject:user6];
        
        
        ZBNPostUserModel *user7 = [[ZBNPostUserModel alloc] init];
        user7.userId = @"1007";
        user7.nickname = @"唐嫣";
        user7.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1655233011,1466773944&fm=58";
        [_users addObject:user7];
        
        
        ZBNPostUserModel *user8 = [[ZBNPostUserModel alloc] init];
        user8.userId = @"1008";
        user8.nickname = @"刘亦菲";
        user8.avatarUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=3932899473,3078920054&fm=58";
        [_users addObject:user8];
        
        
        ZBNPostUserModel *user9 = [[ZBNPostUserModel alloc] init];
        user9.userId = @"1009";
        user9.nickname = @"林允儿";
        user9.avatarUrl = @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2961367360,923857578&fm=58";
        [_users addObject:user9];
        
    }
    return _users;
}

- (void)_setup
{
    _textString = @"孤独之前是迷茫，孤独之后是成长；孤独没有不好，不接受孤独才不好；不合群是表面的孤独，合群了才是内心的孤独。那一天，在图书馆闲逛，书从中，这本书吸引了我，从那以后，睡前总会翻上几页。或许与初到一个陌生城市有关，或许因为近三十却未立而惆怅。孤独这个字眼对我而言，有着异常的吸引力。书中，作者以33段成长故事，描述了33种孤独，也带给了我们33次感怀。什么是孤独？孤独不仅仅是一个人，一间房，一张床。对未来迷茫，找不到前进的方向，是一种孤独；明知即将失去，徒留无奈，是一种孤独；回首来时的路，很多曾经在一起人与物，变得陌生而不识，这是一种孤独；即使心中很伤痛，却还笑着对身边人说，没事我很好，这也是一种孤独——第一次真正意识到，孤独与青春同在，与生活同在！孤独可怕吗？以前很害怕孤独，于是不断改变自己，去适应不同的人不同的事。却不曾想到，孤独也是需要去体验的。正如书中所说，孤独是你终将学会的相处方式。孤独，带给自己的是平静，是思考，而后是成长。于是开始懂得，去学会接受孤独，也接受内心中的自己，成长过程中的自己。我希望将来有一天，回首曾经过往时，可以对自己说，我的孤独，虽败犹荣！";
}

- (void)setupData
{
    NSDate *date = [NSDate date];
    // 初始化100条数据
    for (NSInteger i = 20; i>0; i--) {
        
        // 话题
        ZBNSquareModel *topic = [[ZBNSquareModel alloc] init];
        topic.SquareId = [NSString stringWithFormat:@"%zd",i];
        topic.thumbNums = [NSString stringWithFormat:@"%zd",[NSObject zbn_randomNumber:10 to:100]];
        if (i == 3) {
            topic.isTop = YES;
            [topic.images addObjectsFromArray:@[@"yxj",@"yxj",@"yxj",@"yxj",@"yxj",@"yxj",@"yxj"]];
               }
        // 构建时间假数据
        NSTimeInterval t = date.timeIntervalSince1970 - 1000 *(30-i) - 60;
        NSDate *d = [NSDate dateWithTimeIntervalSince1970:t];
        NSDateFormatter *formatter = [NSDateFormatter zbn_defaultDateFormatter];
        NSString *creatTime = [formatter stringFromDate:d];
        // 标题
        topic.title = @"卓松科技好";
        // 时间
        topic.create_time = creatTime;
        // 评论
        topic.content = [self.textString substringFromIndex:[NSObject zbn_randomNumber:0 to:self.textString.length-1]];
        // 图片
        [topic.images addObject:@"yxj"];
        [topic.images addObject:@"yxj"];
        // 用户
        topic.userM = self.users[[NSObject zbn_randomNumber:0 to:9]];
        // 点赞数
        topic.thumbNums = [NSString stringWithFormat:@"%zd",[NSNumber zbn_randomNumber:9 to:99]];
        // 分享数
        topic.shareCount = [NSString stringWithFormat:@"%zd",[NSNumber zbn_randomNumber:9 to:999]];
        // 评论数
        NSInteger commentsCount = [NSObject zbn_randomNumber:0 to:10];
        topic.commentCount = [NSString stringWithFormat:@"%zd",commentsCount];
        for (NSInteger j = 0; j<commentsCount; j++) {
            ZBNPostComModel  *comment = [[ZBNPostComModel alloc] init];
            comment.commentId = [NSString stringWithFormat:@"%zd%zd",i,j];
            comment.creatTime = [NSDate zbn_currentTimestamp];
            comment.text = [self.textString substringToIndex:[NSObject zbn_randomNumber:0 to:20]];
            if (j%3==0) {
                ZBNPostUserModel *toUser = self.users[[NSObject zbn_randomNumber:0 to:5]];
                comment.toUser = toUser;
            }
            ZBNPostUserModel *fromUser = self.users[[NSObject zbn_randomNumber:6 to:9]];
            comment.fromUser = fromUser;
            [topic.conments addObject:comment];
        }
        if (i == 3) {
            [self.squareFrames insertObject:[self _topicFrameWithSquare:topic] atIndex:0];
        }
        [self.squareFrames addObject:[self _topicFrameWithSquare:topic]];
    }
    
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
    
    [self _setup];
    
    [self setupData];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBNPostCommentCell" bundle:nil] forCellReuseIdentifier:ZBNPostComCellId];
    
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
    ZBNPostShareView *shareV = [ZBNPostShareView viewFromXib];
    shareV.width = KSCREEN_WIDTH;
    QWAlertView *alertView = [QWAlertView sharedMask];
    [alertView show:shareV withType:0 animationFinish:^{
        
    } dismissHandle:^{
            
    }];
}

// 点击评论
- (void)squareHeaderDidClickCommentBtn:(ZBNPostBarHeader *)postHeader
{
    ZBNPostDetailVC *detailVC = [[ZBNPostDetailVC alloc] init];
    detailVC.squareFrame = postHeader.squareFrame;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
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
