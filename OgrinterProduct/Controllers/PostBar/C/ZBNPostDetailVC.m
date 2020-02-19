//
//  ZBNPostDetailVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNPostDetailVC.h"
#import "ZBNPostBarCell.h"
#import "ZBNPostCommentCell.h"
#import "ZBNSquareModel.h"
#import "ZBNPostComModel.h"
#import "ZBNPostSecHeader.h"

@interface ZBNPostDetailVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableV;
@property (nonatomic, strong) ZBNSquareModel *squareM;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ZBNPostDetailVC

static NSString * const ZBNCommentCellId = @"com";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initModel];
    
    [self initModel1];
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
    // 处理模型
    if (self.squareM.cUserIcon) {
        self.squareM.cUserIcon = nil;
    }
    // 设置头部视图
    ZBNPostBarCell *cell = [ZBNPostBarCell viewFromXib];
    cell.squareM = self.squareM;
    cell.frame = CGRectMake(0, 0, KSCREEN_WIDTH, self.squareM.cellHeight);
    
    UIView *header = [[UIView alloc] init];
    header.height = self.squareM.cellHeight + 30;
    [header addSubview:cell];
    
    self.myTableV.tableHeaderView = header;
}

- (void)initModel
{
    ZBNSquareModel *model = [[ZBNSquareModel alloc] init];
    model.cUserIcon = @"yjx";
    model.hasImg = YES;
    model.time = @"2020:43:32";
    model.title = @"heheheheheheh";
    model.userName = @"Wuqing";
    model.userIcon = @"yxj";
    self.squareM = model;
}

- (void)initModel1
{
    for (int i = 0; i < 3; i++) {
        ZBNPostComModel *model = [[ZBNPostComModel alloc] init];
        model.comment = @"laji";
        model.count = @"2";
        model.userIcon = @"yxj";
        model.userName = @"gouzi";
        [self.dataArr addObject:model];
    }
     
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNPostCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ZBNCommentCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.comM = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZBNPostComModel *model = self.dataArr[indexPath.row];
    return model.cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZBNPostSecHeader *header = [ZBNPostSecHeader viewFromXib];
    header.setlabelText(@"评论");
    return header;
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
