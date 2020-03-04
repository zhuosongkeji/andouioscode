//
//  AssembleKillSubViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#define groupgroup_list @"group/group_list"

#import "AssembleKillSubViewController.h"
#import "AssemTableViewCell.h"
#import "AsseBlModel.h"

@interface AssembleKillSubViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger page;
}

@property (nonatomic, assign) BOOL fingerIsTouch;

@property(nonatomic,strong)NSMutableArray *listArr;

@end

@implementation AssembleKillSubViewController


-(NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    [self setup];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.subTableView.delegate = self;
    self.subTableView.dataSource = self;
    self.subTableView.tableFooterView = [UILabel new];
    [self.subTableView registerNib:[UINib nibWithNibName:@"AssemTableViewCell" bundle:nil] forCellReuseIdentifier:@"AssemTableViewCell"];
    
    self.subTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page += 1;
        [self loadNetWork];
    }];
    
    [self.subTableView.mj_footer setHidden:YES];
    [self loadNetWork];
    
    
}


-(void)loadNetWork{
    
    NSString *url1 = [NSString stringWithFormat:@"%@%@/%@/%@",API_BASE_URL_STRING,groupgroup_list,self.aid,[NSString stringWithFormat:@"%ld",page]];
    
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:url1 params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSArray *arr = serverInfo.response[@"data"];
            
            for (int i = 0; i < [arr count];i ++) {
                NSDictionary *dic = arr[i];
                AsseBlModel *model = [[AsseBlModel alloc]initWithDict:dic];
                [self.listArr addObject:model];
            }
            
            [self.subTableView reloadData];
        }else {
            
            [HUDManager showTextHud:loadError];
        }
        
        
    }];
}



//MARK: -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.subTableView.mj_footer.hidden = [self.listArr count]<10;
    return [self.listArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AssemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssemTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"AssemTableViewCell" owner:self options:nil].lastObject;
    }
    
    if ([self.listArr count]) {
        AsseBlModel *mode = self.listArr[indexPath.row];
        cell.modelist = mode;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}



//MARK:- UIScrollView
//判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.fingerIsTouch = YES;
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.fingerIsTouch = NO;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AOtherTop" object:nil];//到顶通知父视图改变状态
    }
    self.subTableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
