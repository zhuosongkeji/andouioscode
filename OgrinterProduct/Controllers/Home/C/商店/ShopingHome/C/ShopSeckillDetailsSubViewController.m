//
//  ShopSeckillDetailsSubViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/14.
//  Copyright © 2019 RXF. All rights reserved.
//

#define shopDeatils @"goods/details"
#define shopComment @"goods/comment"

#import "ShopSeckillDetailsSubViewController.h"
#import "CresTwoTableViewCell.h"
#import "CommentModel.h"


@interface ShopSeckillDetailsSubViewController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>{
    int page;
}

@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic, assign) BOOL fingerIsTouch;

@end


@implementation ShopSeckillDetailsSubViewController


-(NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}


-(WKWebView *)webView {
    if (!_webView) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc]init];
        configuration.userContentController = userContentController;
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 10.0;
        configuration.preferences = preferences;
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 12, self.view.bounds.size.width, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH-96) configuration:configuration];
        
        _webView.UIDelegate = self;
        _webView.scrollView.delegate = self;
    }
    
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.view.backgroundColor = KSRGBA(255, 255, 255, 1);
    
    if ([self.title isEqualToString:SeckillDetailsListArr[0]]) {
        
        [self details];
        
    }else{
        
        [self comment];
    }
}


//MARK:- cp details
-(void)details {
    
    [self.smTableView removeFromSuperview];
    self.smTableView.delegate = nil;
    self.smTableView.dataSource = nil;
    
    [self loadcpdetails];
}


//MARK:- comment
-(void)comment {
    
    self.smTableView.tableFooterView = [UILabel new];
    self.smTableView.delegate = self;
    self.smTableView.dataSource = self;
    
    [self.smTableView registerNib:[UINib nibWithNibName:@"CresTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresTwoTableViewCell"];
    
    page = 1;
    
    __weak typeof(self) weakSelf = self;
    self.smTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page += 1;
        [weakSelf loadCommectList];
    }];
    
    [self.smTableView.mj_footer setHidden:YES];
    
    [self loadCommectList];
    
}


-(void)loadcpdetails{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopDeatils];
    NSDictionary *dict = @{@"id":self.cp_id};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSString *strHTML = [NSString stringWithFormat:@"%@",[serverInfo.response[@"data"] objectForKey:@"details"]];
            [self.view addSubview:self.webView];
            [self.webView loadHTMLString:strHTML baseURL:nil];
        }else {
            [HUDManager showTextHud:loadError];
        }
    }];
}


-(void)loadCommectList {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopComment];
    NSDictionary *dict = @{@"id":self.cp_id,@"page":[NSString stringWithFormat:@"%d",page]};
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:dict complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSArray *array = [serverInfo.response objectForKey:@"data"];
            for (int i = 0; i < [array count]; i ++) {
                CommentModel *model = [[CommentModel alloc]init];
                [self.data addObject:model];
            }
        }else {
            [HUDManager showTextHud:loadError];
        }
        
        [self.smTableView.mj_footer endRefreshing];
    }];
}


//- (void)insertRowAtBottom {
//    for (int i = 0; i<20; i++) {
//        [self.data addObject:@"1"];
//    }
//    __weak UITableView *tableView = self.smTableView;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [tableView reloadData];
//        [tableView.mj_footer endRefreshing];
//    });
//}


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
        return 0;
    }else {
        self.smTableView.mj_footer.hidden = [self.data count]<10;
        return [self.data count];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.title isEqualToString:SeckillDetailsListArr[0]]){
        return nil;
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
        return 0;
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


//MARK:-WKWebView
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"html加载完成");
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '300%'" completionHandler:nil];
    
    //修改字体颜色  #9098b8
    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#0078f0'" completionHandler:nil];
    
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
