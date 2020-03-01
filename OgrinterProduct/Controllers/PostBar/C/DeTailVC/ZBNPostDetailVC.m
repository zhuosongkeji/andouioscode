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

@interface ZBNPostDetailVC () <UITableViewDelegate, UITableViewDataSource,ZBNPostBarHeaderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableV;

@end

@implementation ZBNPostDetailVC

static NSString * const ZBNCommentCellId = @"com";

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置table
    [self setupTable];
}


// 设置table
- (void)setupTable
{

    self.myTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.myTableV registerNib:[UINib nibWithNibName:NSStringFromClass([ZBNPostCommentCell class]) bundle:nil] forCellReuseIdentifier:ZBNCommentCellId];
    // 设置代理和数据源
    self.myTableV.delegate = self;
    self.myTableV.dataSource = self;
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.squareFrame.commentFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    ZBNPostCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNCommentCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.commentFrame = self.squareFrame.commentFrames[indexPath.row];
    return cell;
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
    ZBNCommentFrame *commentFrame = self.squareFrame.commentFrames[indexPath.row];
    return commentFrame.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.squareFrame.height;
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

@end
