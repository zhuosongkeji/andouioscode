//
//  ShopSeckillDetailsSubViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ShopSeckillDetailsSubViewController.h"
#import "CresTwoTableViewCell.h"


@interface ShopSeckillDetailsSubViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic, assign) BOOL fingerIsTouch;

@end


@implementation ShopSeckillDetailsSubViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.smTableView.tableFooterView = [UILabel new];
    
    if ([self.title isEqualToString:SeckillDetailsListArr[0]]) {
        [self details];
    }else{
        [self comment];
    }
}


//MARK:- cp details
-(void)details {
    
}


//MARK:- comment
-(void)comment {
    
    [self.smTableView registerNib:[UINib nibWithNibName:@"CresTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresTwoTableViewCell"];
    
    __weak typeof(self) weakSelf = self;
    self.smTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf insertRowAtBottom];
    }];
}


- (void)insertRowAtBottom {
    for (int i = 0; i<20; i++) {
        [self.data addObject:@"1"];
    }
    __weak UITableView *tableView = self.smTableView;
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
    
    if ([self.title isEqualToString:SeckillDetailsListArr[0]]) {
        return 3;
    }else {
        return [self.data count];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.title isEqualToString:SeckillDetailsListArr[0]]){
        static NSString *idfier = @"idfier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idfier];
        }
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, KSCREEN_WIDTH-20, 420)];
        [imgView setImage:[UIImage imageNamed:@"spDetails"]];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        
        [cell.contentView addSubview:imgView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else {
        
        
        CresTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresTwoTableViewCell"];
        if (!cell) {
            
            NSLog(@"chuangjian");
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.title isEqualToString:SeckillDetailsListArr[0]]) {
        return 420;
    }else {
        return 206;
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
        
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OtherTop" object:nil];
    }
    self.smTableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
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
