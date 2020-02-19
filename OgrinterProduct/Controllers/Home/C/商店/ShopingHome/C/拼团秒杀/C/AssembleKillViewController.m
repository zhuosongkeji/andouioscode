//
//  AssembleKillViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AssembleKillViewController.h"
#import "HotelBottomTableViewCell.h"
#import "AssembleKillSubViewController.h"

@interface AssembleKillViewController ()<UITableViewDelegate,UITableViewDataSource,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@property (nonatomic, strong) HotelBottomTableViewCell *contentCell;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) FSSegmentTitleView *titleView;


@end


@implementation AssembleKillViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setNavBarBackgroundAlpha:0];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setup];
    // Do any additional setup after loading the view from its nib.
}

-(void)setup{
    
    KAdd_Observer(@"AOtherTop", self, hangeScroll, nil);
    self.canScroll = YES;
    self.mTableView.tableFooterView = [UILabel new];
    
}


//MARK:-
-(void)hangeScroll {
    self.canScroll = YES;
    self.contentCell.cellCanScroll = NO;
}


//MARK:-UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _contentCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!_contentCell) {
        _contentCell = [[HotelBottomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" withtype:HotelBottomTableViewCellTypeFouth];
        _contentCell.contentView.backgroundColor = [UIColor redColor];
        
        NSMutableArray *contentVCs = [NSMutableArray array];
        for (int i = 0 ; i < ASeckilAlDetailsListArr.count; i++) {
            AssembleKillSubViewController *vc = [[AssembleKillSubViewController alloc]init];
            vc.title = ASeckilAlDetailsListArr[i];
            vc.str = vc.title;
//            vc.cp_id = self.cpid;

            [contentVCs addObject:vc];
            
        }
        _contentCell.viewControllers = contentVCs;
        _contentCell.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH) childVCs:contentVCs parentVC:self delegate:self];
        [_contentCell.contentView addSubview:_contentCell.pageContentView];
    }
    return _contentCell;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50) titles:ASeckilAlDetailsListArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.backgroundColor = KSRGBA(255, 255, 255, 255);
    
    return self.titleView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return KSCREEN_HEIGHT-kStatusBarAndNavigationBarH;
}



//MARK:- UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat bottomCellOffset = [self.mTableView rectForSection:0].origin.y-kStatusBarAndNavigationBarH;
    CGFloat conOffY = scrollView.contentOffset.y;
    CGFloat maxAlphaOffset = 168;
    
    CGFloat alpha = (conOffY) / (maxAlphaOffset);
    
    [self wr_setNavBarBackgroundAlpha:alpha];
    
    if (conOffY >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.contentCell.cellCanScroll = YES;
        }
    }else{
        if (!self.canScroll) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    self.mTableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AOtherTop" object:nil];
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
