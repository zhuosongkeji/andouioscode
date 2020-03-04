//
//  ZBNPostDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostDetailVC.h"

#import "ZBNSquareModel.h"
#import "ZBNPostShareView.h"
#import "ZBNPostDetailVC.h"
#import "ZBNPostUserModel.h"
#import "NSDate+Extension.h"
#import "ZBNPostComModel.h"
#import "ZBNSquareFrame.h"
#import "ZBNPostCommentCell.h"
#import "ZBNPostBarHeader.h"
#import "ZBNSquareModel.h"
#import "WMZDialog.h"
#import "ZBNPostComLineCell.h"
#import "ZBNPostNoDataCell.h"

@interface ZBNPostDetailVC () <UITableViewDelegate, UITableViewDataSource,ZBNPostBarHeaderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableV;
/*! 评论框 */
@property (weak, nonatomic) IBOutlet UITextField *commentTextF;

@property (nonatomic, strong) ZBNSquareFrame *squareFrame;
@property (nonatomic, strong) ZBNSquareModel *squareM;
@property (nonatomic, strong) NSNumber *commnetID;

@end

@implementation ZBNPostDetailVC

static NSString * const ZBNCommentCellId = @"com";

- (NSNumber *)commnetID
{
    if (!_commnetID) {
        _commnetID = [[NSNumber alloc] init];
    }
    return _commnetID;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置table
    [self setupTable];
    
    [self loadRuqest];
}

/*! 发送安妮的点击 */
- (IBAction)commentBtnClick:(id)sender {
    if (self.commentTextF.text.length > 0) {
         [self commentRequest];
    } else {
        [HUDManager showTextHud:@"请输入评论内容"];
    }
}

// 设置table
- (void)setupTable
{
    self.myTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableV.contentInset =UIEdgeInsetsMake(-36, 0, 0, 0);
    self.view.backgroundColor = KSRGBA(241, 241, 241, 1);
    [self.myTableV registerNib:[UINib nibWithNibName:NSStringFromClass([ZBNPostCommentCell class]) bundle:nil] forCellReuseIdentifier:ZBNCommentCellId];
    // 设置代理和数据源
    self.myTableV.delegate = self;
    self.myTableV.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.myTableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}


- (void)commentRequest
{
    [FKHRequestManager cancleRequestWork];
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = unmodel.uid;
    param[@"post_id"] = self.squareFrame.squareM.ID;
    param[@"content"] = self.commentTextF.text;
    param[@"comment_id"] = self.commnetID;
    ADWeakSelf;
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/index.php/api/tieba/comment" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] intValue] == 200) {
            [HUDManager showTextHud:@"回复成功"];
            [weakSelf loadRuqest];
            weakSelf.commnetID = nil;
        } else {
            [HUDManager showTextHud:@"回复失败"];
        }
        
    }];
}






- (void)loadRuqest
{
        [FKHRequestManager cancleRequestWork];
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"post_id"] = self.post_id;
        //    param[@"comment_id"] = ;
        ADWeakSelf;
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:@"http://andou.zhuosongkj.com/index.php/api/tieba/detail" params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {
            weakSelf.squareM = [ZBNSquareModel mj_objectWithKeyValues:serverInfo.response[@"data"]];
            weakSelf.squareFrame = [self _topicFrameWithSquare:weakSelf.squareM];
            [weakSelf.myTableV reloadData];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.squareFrame.commentFrames.count>0) {
        return self.squareFrame.commentFrames.count + 1;
    } else {
        return 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.squareFrame.commentFrames.count > 0) {
        if (indexPath.row == 0) {
            ZBNPostComLineCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ZBNPostComLineCell" owner:nil options:nil].lastObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            ZBNPostCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNCommentCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.commentFrame = self.squareFrame.commentFrames[indexPath.row - 1];
            return cell;
        }
    } else {
        ZBNPostNoDataCell *cell = [[NSBundle mainBundle]loadNibNamed:@"ZBNPostNoDataCell" owner:nil options:nil].lastObject ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZBNPostBarHeader *headerV = [ZBNPostBarHeader headerViewWithTableView:tableView];
    headerV.squareFrame = self.squareFrame;
    headerV.delegate = self;
    return headerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.squareFrame.commentFrames.count>0) {
        if (indexPath.row == 0) {
            return 40;
        } else {
            ZBNCommentFrame *commentFrame = self.squareFrame.commentFrames[indexPath.row - 1];
            return commentFrame.cellHeight;
        }
    } else {
        return 48;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.squareFrame.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.squareFrame.commentFrames.count>0) {
        if (indexPath.row == 0) {
            
        } else {
            ZBNCommentFrame *commentFrame = self.squareFrame.commentFrames[indexPath.row - 1];
            ZBNPostComModel *model = commentFrame.comment;
            self.commnetID = model.ID;
            [self.commentTextF becomeFirstResponder];
            self.commentTextF.placeholder = [NSString stringWithFormat:@"回复%@:",model.name];
        }
    } else {
        
    }
    
}

#pragma mark -- ZBNHeaderViewDelegate

// 点击分享
- (void)squareHeaderDidClickShareBtn:(ZBNPostBarHeader *)postHeader
{
    WMZDialog *alert = Dialog();
               alert.wTypeSet(DialogTypeShare)
               .wTitleSet(@"分享")
               .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
                   NSLog(@"%@ %ld %ld",anyID,section,row);
               })
               .wDataSet(@[
                           @{@"name":@"微信",@"image":@"weiin"},
                           @{@"name":@"朋友圈",@"image":@"wexinPen"},
                           ]).wStart();
}

// 评论
- (void)squareHeaderDidClickCommentBtn:(ZBNPostBarHeader *)postHeader
{
    [self.commentTextF becomeFirstResponder];
}


@end
