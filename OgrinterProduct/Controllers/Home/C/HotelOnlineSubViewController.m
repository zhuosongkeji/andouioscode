//
//  HotelOnlineSubViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/17.
//  Copyright © 2020 RXF. All rights reserved.
//


#define gourmet_dishtype @"gourmet/dishtype"//菜品类别

#define gourmet_upd_foods @"gourmet/upd_foods"//加入购物车

#define gourmet_comment @"gourmet/comment"


#import "HotelOnlineSubViewController.h"
#import "HolteOnlineSubViewTableViewCell.h"
#import "HotelOnlinesModel.h"
#import "HotelOnlinesListModel.h"
#import "CresTwoTableViewCell.h"
#import "CommentModel.h"
#import <WebKit/WebKit.h>


@interface HotelOnlineSubViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>{
    NSInteger page;
}

@property(nonatomic,strong)NSMutableArray *leftArr;

@property(nonatomic,strong)NSMutableArray *rightArr;

@property (nonatomic, assign) BOOL fingerIsTouch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lefttop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *righttop;

@property (nonatomic,strong)WKWebView *webView;


@end

@implementation HotelOnlineSubViewController

-(WKWebView *)webView {
    if (!_webView) {
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        
        wkWebConfig.userContentController = wkUController;
        
        //自适应屏幕的宽度js
        
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        //添加js调用
        
        [wkUController addUserScript:wkUserScript];
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH-120) configuration:wkWebConfig];
        
        _webView.UIDelegate = self;
        _webView.scrollView.delegate = self;
    }
    
    return _webView;
}


-(NSMutableArray *)leftArr{
    if (!_leftArr) {
        _leftArr = [NSMutableArray array];
    }
    return _leftArr;
}

-(NSMutableArray *)rightArr{
    if (!_rightArr) {
        _rightArr = [NSMutableArray array];
    }
    return _rightArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{

    if ([self.title isEqualToString:HotelDetalsListArr[0]]){
        [self reserve];
    }else if ([self.title isEqualToString:HotelDetalsListArr[1]]){
        [self comment];
    }else if ([self.title isEqualToString:HotelDetalsListArr[2]]){
        [self introduce];
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
    [self loadgourmetdishtype];
}


//MARK:- 评论
-(void)comment{
//    gourmet_comment
    page = 0;
    
    if (self.lefttableView)
        [self.lefttableView removeFromSuperview];
    
    self.righttableView.delegate = self;
    self.righttableView.dataSource = self;
    
    [self.righttableView registerNib:[UINib nibWithNibName:@"CresTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresTwoTableViewCell"];
    
    self.righttableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        page += 1;
        [self loadcommNetWork:[NSString stringWithFormat:@"%ld",page]];
    }];
    
    [self.righttableView.mj_footer setHidden:YES];
    
    [self loadcommNetWork:[NSString stringWithFormat:@"%ld",page]];
}


//MARK:-
-(void)introduce{
    
    if (self.lefttableView)
        [self.lefttableView removeFromSuperview];
    
    self.righttableView.delegate = self;
    self.righttableView.dataSource = self;
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

//MARK:- 评论
-(void)loadcommNetWork:(NSString *)pages{
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_comment] params:@{@"id":self.merchants_id,@"page":pages} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSArray *datArr = serverInfo.response[@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < [datArr  count]; i ++) {
                CommentModel *model = [[CommentModel alloc]initWithDict:datArr[i]];
                [array addObject:model];
            }
            if([self.righttableView.mj_footer isRefreshing]){
                if ([array count] == 0) {
                    [self.righttableView.mj_footer endRefreshing];
                    [self.righttableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.rightArr addObjectsFromArray:array];
                    [self.righttableView.mj_footer endRefreshing];
                }
            }else{
                [self.rightArr addObjectsFromArray:array];
            }
            [self.righttableView reloadData];
            
        }else {
            [HUDManager showTextHud:loadError];
        }

    }];
}


//MARK:- 加入购物车
-(void)sgourmetupdfoods:(NSString *)type withID:(NSString *)cid{
    
    UIWindow *win = [self getWindow];
    
//    [HUDManager showLoadingHud:loading onView:win];
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:[NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,gourmet_upd_foods] params:@{@"uid":unmodel.uid,@"id":cid,@"type":type,@"merchant_id":self.merchants_id} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
        }else {
            [HUDManager showTextHud:loadError];
        }
//        [HUDManager hidenHudFromView:win];
    }];
}


#pragma mark - tableView 数据源代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.title isEqualToString:HotelDetalsListArr[0]]){
        if (tableView == self.lefttableView)
            return [self.leftArr count];
        else if (tableView == self.righttableView){
            if ([_leftArr count] > 0) {
                HotelOnlinesModel *model = _leftArr[section];
                return [model.information count];
            }
            return 0;
        }
        return 0;
    }else if ([self.title isEqualToString:HotelDetalsListArr[1]]){
        self.righttableView.mj_footer.hidden = [self.rightArr count]<10;
        return [self.rightArr count];
    }else if ([self.title isEqualToString:HotelDetalsListArr[2]]){
        return 1;
    }else{
        return 0;
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.title isEqualToString:HotelDetalsListArr[0]]){
        if (tableView == self.lefttableView)
            return 1;
        else if (tableView == self.righttableView){
            return [self.leftArr count];
        }
        return 0;
    }else if ([self.title isEqualToString:HotelDetalsListArr[1]]){
        return 1;
    }else if ([self.title isEqualToString:HotelDetalsListArr[2]]){
        return 1;
    }else{
        return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.title isEqualToString:HotelDetalsListArr[0]]){
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
    }else if ([self.title isEqualToString:HotelDetalsListArr[1]]){
        CresTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresTwoTableViewCell"];
        if (!cell) {
            NSLog(@"创建新的cell");
        }
        
        if ([self.rightArr count]>0) {
            cell.clistmodel = self.rightArr[indexPath.row];
            
        }
        
        return cell;
    }else if ([self.title isEqualToString:HotelDetalsListArr[2]]){
        NSString *idfier = @"idfier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idfier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idfier];
        }
        
        [cell.contentView addSubview:self.webView];
        [self.webView loadHTMLString:[NSString stringWithFormat:@"%@",self.hdesc] baseURL:nil];
        
        return cell;
    }else{
        return nil;
    }

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([self.title isEqualToString:HotelDetalsListArr[0]]){
        if (tableView == self.righttableView){
            HotelOnlinesModel *model = _leftArr[section];
            return model.name;
        }else{return nil;}
    }else{
        return nil;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.title isEqualToString:HotelDetalsListArr[0]]){
        if (tableView == self.lefttableView) {
            return 50;
        }
        return 105;
    }else if ([self.title isEqualToString:HotelDetalsListArr[1]]){
        return 147;
    }else if ([self.title isEqualToString:HotelDetalsListArr[2]]){
        return KSCREEN_HEIGHT-kStatusBarAndNavigationBarH-120;
    }else{
        return 0;
    }
    
}


//MARK: - 一个方法就能搞定 右边滑动时跟左边的联动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }else{
        
        if ([self.title isEqualToString:HotelDetalsListArr[0]]){
            
            if (scrollView == self.lefttableView)
                return;
            NSIndexPath *topHeaderViewIndexpath = [[self.righttableView indexPathsForVisibleRows] firstObject];
            NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
            [self.lefttableView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }else{
            
        }
    }
    if (scrollView.contentOffset.y <= 0) {
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


//MARK:-WKWebView
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //    NSLog(@"html加载完成");
    //    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'" completionHandler:nil];
    //
    //    //修改字体颜色  #9098b8
    //    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#0078f0'" completionHandler:nil];
    //禁止用户选择
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
    // 适当增大字体大小
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '105%'" completionHandler:nil];
    
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
