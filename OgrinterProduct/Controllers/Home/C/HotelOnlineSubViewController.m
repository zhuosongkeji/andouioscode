//
//  HotelOnlineSubViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//


#define gourmet_dishtype @"gourmet/dishtype"//菜品类别

#define gourmet_upd_foods @"gourmet/upd_foods"//加入购物车


#import "HotelOnlineSubViewController.h"
#import "HolteOnlineSubViewTableViewCell.h"
#import "HotelOnlinesModel.h"
#import "HotelOnlinesListModel.h"


@interface HotelOnlineSubViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *leftArr;

@property (nonatomic, assign) BOOL fingerIsTouch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lefttop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *righttop;


@end

@implementation HotelOnlineSubViewController


-(NSMutableArray *)leftArr{
    if (!_leftArr) {
        _leftArr = [NSMutableArray array];
    }
    return _leftArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{

    if ([self.title isEqualToString:HotelDetalsListArr[0]]){
        
//        page = 0;
        [self reserve];
        [self loadgourmetdishtype];
    }else if ([self.title isEqualToString:HotelDetalsListArr[1]]){
//        [self comment];
    }else if ([self.title isEqualToString:HotelDetalsListArr[2]]){
//        [self introduce];
    }else{
        
    }
    
}


-(void)reserve{
    
    self.lefttableView.tableFooterView = [UILabel new];
    self.righttableView.tableFooterView = [UILabel new];
    self.lefttableView.delegate = self;
    self.lefttableView.dataSource = self;
    
    self.righttableView.delegate = self;
    self.righttableView.dataSource = self;
    
    [self.righttableView registerNib:[UINib nibWithNibName:@"HolteOnlineSubViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"HolteOnlineSubViewTableViewCell"];
}

//MARK:- 菜品类别
-(void)loadgourmetdishtype{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_dishtype] params:@{@"merchants_id":self.merchants_id} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSArray *datArr = serverInfo.response[@"data"];
            
            for (int i = 0; i < [datArr  count]; i ++) {
                HotelOnlinesModel *model = [[HotelOnlinesModel alloc]initWithDict:datArr[i]];
                [self.leftArr addObject:model];
            }
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        [self.righttableView reloadData];
        [self.lefttableView reloadData];
    }];
    
}


//MARK:- 加入购物车
-(void)sgourmetupdfoods:(NSString *)type withID:(NSString *)cid{
    
    UIWindow *win = [self getWindow];
    
    [HUDManager showLoadingHud:loading onView:win];
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_upd_foods] params:@{@"uid":unmodel.uid,@"id":cid,@"type":type,@"merchant_id":self.merchants_id} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            [HUDManager hidenHudFromView:win];
        }else {
            [HUDManager showTextHud:loadError];
        }
    }];
}


#pragma mark - tableView 数据源代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.lefttableView)
        return [self.leftArr count];
    else if (tableView == self.righttableView){
        if ([_leftArr count] > 0) {
            HotelOnlinesModel *model = _leftArr[section];
            
            return [model.information count];
        }
        return 0;
    }
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.lefttableView)
        return 1;
    return [self.leftArr count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 左边的 view
    if (tableView == self.lefttableView) {
        
        static NSString *idfier = @"idfier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        if ([_leftArr count]>0) {
            HotelOnlinesModel *model = _leftArr[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = model.name;
        }
        
        
        return cell;
        // 右边的 view
    } else {
        
        HolteOnlineSubViewTableViewCell *cell = [HolteOnlineSubViewTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
        [cell configTempCellWith:indexPath];
        
        if ([_leftArr count] > 0) {
            HotelOnlinesModel *model = _leftArr[indexPath.section];
            HotelOnlinesListModel *mode = model.information[indexPath.row];
            cell.listmodel = mode;
            
        }
        
        cell.clickBlock = ^(NSInteger idx, UIButton * _Nonnull btn) {
            NSString *type = nil;
            
            HolteOnlineSubViewTableViewCell *mCell = (HolteOnlineSubViewTableViewCell *)btn.superview.superview;
            NSIndexPath *path = [self.righttableView indexPathForCell:mCell];
            HotelOnlinesModel *model = _leftArr[path.section];
            HotelOnlinesListModel *mode = model.information[path.row];
            NSInteger numb = [mCell.numberlabel.text integerValue];
            if (btn.tag == 1000) {
                numb-=1;
                if (numb <= 0) {
                    numb = 0;
                }
                type = @"0";
            }else{numb+=1;type = @"1";}
            
            mode.munbert = [NSString stringWithFormat:@"%ld",numb];
            mCell.numberlabel.text = mode.munbert;
            KPost_Notify(@"addCarNoft", nil,[self gettatolnomey]);
            [self sgourmetupdfoods:type withID:mode.hid];
            
        };
        
        return cell;
    }
    
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.righttableView){
        HotelOnlinesModel *model = _leftArr[section];
        return model.name;
        
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.lefttableView) {
        return 50;
    }
    return 105;
}


//MARK: - 一个方法就能搞定 右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }else{
        if (scrollView == self.lefttableView)
            return;
        NSIndexPath *topHeaderViewIndexpath = [[self.righttableView indexPathsForVisibleRows] firstObject];
        NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
        [self.lefttableView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    if (scrollView.contentOffset.y <= 0) {
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HotelTop" object:nil];//到顶通知父视图改变状态
    }
    self.righttableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
    
}


//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.lefttableView
        ) {
        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        [self.righttableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.righttableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
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



- (void)setIsRefresh:(BOOL)isRefresh{
    _isRefresh = isRefresh;
    //    [self insertRowAtTop];
}



//MARK:-
-(NSDictionary *)gettatolnomey{
    
    NSDictionary *dic = nil;
    
    NSMutableArray *count = [NSMutableArray array];
    NSMutableArray *money = [NSMutableArray array];
    
    
    for (int i = 0; i<[self.leftArr count]; i++) {
        HotelOnlinesModel *m = self.leftArr[i];
        for (HotelOnlinesListModel *mm in m.information) {
            if ([mm.munbert integerValue] != 0) {
                NSNumber *numb = @([mm.price floatValue]*[mm.munbert integerValue]);
                NSNumber *totalNum = @([mm.munbert integerValue]);
                [count addObject:totalNum];
                [money addObject:numb];
            }
        }
    }
    
    NSNumber *sum = [money valueForKeyPath:@"@sum.self"];
    NSNumber *tatol = [count valueForKeyPath:@"@sum.self"];
    
    return dic = @{@"nomey":[NSString stringWithFormat:@"%@",sum],@"num":[NSString stringWithFormat:@"%@",tatol]};
    
}


-(UIWindow *)getWindow {
    UIWindow* win = nil;
    for (id item in [UIApplication sharedApplication].windows) {
        if([item class] == [UIWindow class]) {
            if(!((UIWindow*)item).hidden) {
                win = item;
                break;
            }
        }
    }
    return win;
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
