//
//  HotelDetlisSubViewOneController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//


#define bottomH 420


#import "HotelDetlisSubViewOneController.h"
#import "OnlineBookingViewController.h"
#import "HotelDetailsBottomView.h"
#import "CresTableViewCell.h"
#import "CresTwoTableViewCell.h"
#import "CresThirdTableViewCell.h"
#import "CresFouthTableViewCell.h"
#import "MsgModel.h"

@interface HotelDetlisSubViewOneController ()

@property (nonatomic, assign) BOOL fingerIsTouch;

@property (strong, nonatomic) NSMutableArray *data;

@property (nonatomic,strong)HotelDetailsBottomView *bottomView;

@property (nonatomic,weak)UIButton *bjbtn;

@end

@implementation HotelDetlisSubViewOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商家详情";
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    if ([self.title isEqualToString:HotelDetailsListArr[0]]) {
        [self reserve];
        [self createBottomView];
    }else if ([self.title isEqualToString:HotelDetailsListArr[1]]){
        [self comment];
    }else if ([self.title isEqualToString:HotelDetailsListArr[2]]){
        [self introduce];
    }else if ([self.title isEqualToString:HotelDetailsListArr[3]]){
        [self environmental];
    }else{
        
    }
    
}


//MARK:-createBottomView
-(void)createBottomView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-bottomH)];
    [btn setBackgroundColor:[UIColor colorWithWhite:.5 alpha:.4]];
    [btn setHidden:YES];
    
    [btn addTarget:self action:@selector(dissView) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self.bjbtn = btn];
    
    _bottomView = [[NSBundle mainBundle]loadNibNamed:@"HotelDetailsBottomView" owner:self options:nil].lastObject;
    [_bottomView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH,bottomH)];
    [_bottomView setBackgroundColor:KSRGBA(255, 255, 255, 1)];
    
    __weak typeof(&*self)WeakSelf = self;
    
    _bottomView.reserveBlock = ^(UIButton *btn) {
        
        [WeakSelf dissView];
        [WeakSelf performSelector:@selector(pushToController) withObject:nil afterDelay:0.5];
    };
    
     [[UIApplication sharedApplication].keyWindow addSubview:_bottomView];
}


//MARK:-预定
-(void)reserve{
    
    self.SubViewOnemTableView.tableFooterView = [UILabel new];
    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresTableViewCell"];
    
    __weak typeof(self) weakSelf = self;
    self.SubViewOnemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf insertRowAtBottom];
    }];
}


//MARK:- comment
-(void)comment {
    self.SubViewOnemTableView.tableFooterView = [UILabel new];
    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresTwoTableViewCell"];
    
    __weak typeof(self) weakSelf = self;
    self.SubViewOnemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf insertRowAtBottom];
    }];
}


//MARK:- introduce
-(void)introduce {
    
    self.SubViewOnemTableView.tableFooterView = [UILabel new];
    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresThirdTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresThirdTableViewCell"];
}


//MARK:- 环境设施
-(void)environmental {
    self.SubViewOnemTableView.tableFooterView = [UILabel new];
    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresFouthTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresFouthTableViewCell"];
}



- (void)insertRowAtBottom {
    for (int i = 0; i<20; i++) {
        [self.data addObject:@"1"];
    }
    __weak UITableView *tableView = self.SubViewOnemTableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tableView reloadData];
        [tableView.mj_footer endRefreshing];
    });
}

//MARK:- Setter
- (void)setIsRefresh:(BOOL)isRefresh{
    _isRefresh = isRefresh;
    //    [self insertRowAtTop];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.title isEqualToString:HotelDetailsListArr[0]] || [self.title isEqualToString:HotelDetailsListArr[1]]) {
        return [self.data count];
    }else if ([self.title isEqualToString:HotelDetailsListArr[2]] || [self.title isEqualToString:HotelDetailsListArr[3]]){
        return 1;
    }else
        return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.title isEqualToString:HotelDetailsListArr[0]]) {
        CresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresTableViewCell"];
        if (!cell) {
            
            NSLog(@"chuangjian");
        }
        
        cell.selectbtnBlock = ^(UIButton *btn) {
            [self showView];
        };
        
        return cell;
    }else if ([self.title isEqualToString:HotelDetailsListArr[1]]){
        CresTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresTwoTableViewCell"];
        if (!cell) {
            
            NSLog(@"chuangjian");
        }
        
        return cell;
        
    }else if ([self.title isEqualToString:HotelDetailsListArr[2]]){
        CresThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresThirdTableViewCell"];
        if (!cell) {
            
            NSLog(@"chuangjian");
        }
        
        return cell;
    }else if ([self.title isEqualToString:HotelDetailsListArr[3]]){
        CresFouthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresFouthTableViewCell"];
        if (!cell) {
            
            NSLog(@"chuangjian");
        }
        
        return cell;
        
    }else
        return nil;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.title isEqualToString:HotelDetailsListArr[0]]) {
        return 105;
    }else if ([self.title isEqualToString:HotelDetailsListArr[1]]){
        return 206;
    }else if ([self.title isEqualToString:HotelDetailsListArr[2]]){
        return KSCREEN_HEIGHT;
    }else if ([self.title isEqualToString:HotelDetailsListArr[3]]){
        return KSCREEN_HEIGHT;
    }else{
        return 0;
    }
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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"leaveTop" object:nil];//到顶通知父视图改变状态
    }
    self.SubViewOnemTableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
}

//MARK:- view消失
-(void)dissView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, bottomH);
        [self.bjbtn setHidden:YES];
    }];
}

-(void)showView{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT-bottomH, self.view.frame.size.width, bottomH);
        [self.bjbtn setHidden:NO];
    }];
}


-(void)pushToController {
    
    OnlineBookingViewController *online = [[OnlineBookingViewController alloc]init];
    [self.navigationController pushViewController:online animated:YES];
}


- (NSMutableArray *)data {
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [self.data addObject:@"2"];
        }
    }
    return _data;
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
