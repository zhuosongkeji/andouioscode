//
//  HotelDetlisSubViewOneController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//

#define room_list @"details/room_list"//酒店房间
#define details_hotelSel @"details/hotelSel"//房间配置

#define htorder_settlement @"htorder/settlement"//酒店结算

#define details_commnets @"details/commnets"

#define bottomH 420

#import "HotelDetlisSubViewOneController.h"
#import "OnlineBookingViewController.h"
#import "ScanSelectedImgViewController.h"
#import "HotelDetailsBottomView.h"
#import "CresTableViewCell.h"
#import "CresTwoTableViewCell.h"
#import "CresThirdTableViewCell.h"
#import "CresFouthTableViewCell.h"
#import <WebKit/WebKit.h>
#import "MsgModel.h"
#import "HoleggModel.h"
#import "CommentModel.h"


@interface HotelDetlisSubViewOneController ()<UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>{
    NSInteger page;
}

@property (nonatomic, assign) BOOL fingerIsTouch;

@property (nonatomic,strong)WKWebView *webView;

@property (strong, nonatomic) NSMutableArray *data;

@property (nonatomic,strong)HotelDetailsBottomView *bottomView;

@property (weak,nonatomic)HDragItemListView *itemView;

@property (nonatomic,weak)UIButton *bjbtn;

@property(nonatomic,strong)NSMutableArray *listArr;

@property(nonatomic,strong)NSString *roomId;



@end

@implementation HotelDetlisSubViewOneController


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
        
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-kStatusBarAndNavigationBarH-76) configuration:wkWebConfig];
        
        _webView.UIDelegate = self;
        _webView.scrollView.delegate = self;
    }
    
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家详情";
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.SubViewOnemTableView.tableFooterView = [UILabel new];
    self.SubViewOnemTableView.delegate = self;
    self.SubViewOnemTableView.dataSource = self;
    
    if ([self.title isEqualToString:HotelDetailsListArr[0]]){
        
        page = 0;
        [self reserve];

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
    [btn setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-bottomH+20)];
    [btn addTarget:self action:@selector(dissView:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor colorWithWhite:0.4 alpha:0.4]];
    [btn setHidden:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.bjbtn = btn];
    
    _bottomView = [[NSBundle mainBundle]loadNibNamed:@"HotelDetailsBottomView" owner:self options:nil].lastObject;
    [_bottomView setFrame:CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH,bottomH)];
    [_bottomView setBackgroundColor:KSRGBA(255, 255, 255, 1)];
    
    __weak typeof(&*self)WeakSelf = self;
    
    _bottomView.reserveBlock = ^(UIButton *btn) {
        [WeakSelf dissView:@"10"];
    };
    
     [[UIApplication sharedApplication].keyWindow addSubview:_bottomView];
}


//MARK:-预定
-(void)reserve{
    
    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresTableViewCell"];
    
    [self createBottomView];
    
//    __weak typeof(self) weakSelf = self;
    self.SubViewOnemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page +=1;
        [self loadshoperlist];
    }];
    
    [self.SubViewOnemTableView.mj_footer setHidden:YES];
    
    [self loadshoperlist];
}


//MARK:- comment
-(void)comment {

    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresTwoTableViewCell"];
    
    __weak typeof(self) weakSelf = self;
    self.SubViewOnemTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf insertRowAtBottom];
        page += 1;
        [weakSelf loadcommentNetWork:[NSString stringWithFormat:@"%ld",(long)page]];
    }];
    [self loadcommentNetWork:[NSString stringWithFormat:@"%ld",(long)page]];
}


//MARK:- introduce
-(void)introduce {
    
    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresThirdTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresThirdTableViewCell"];
    
//    [self.SubViewOnemTableView reloadData];
}


//MARK:- 环境设施
-(void)environmental {
    
    [self.SubViewOnemTableView registerNib:[UINib nibWithNibName:@"CresFouthTableViewCell" bundle:nil] forCellReuseIdentifier:@"CresFouthTableViewCell"];
    
    [self createBaseView];
    [self createImgViewItems];
    [self createTextView];
    
    [self addobjectWith:self.imgArr];
    
}


-(void)loadshoperlist{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,room_list];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"merchant_id":@([self.sid intValue]),@"page":@(page)} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            
            NSArray *array = [serverInfo.response[@"data"] objectForKey:@"hotel_room"];
            for (int i = 0; i < [array  count]; i ++ ) {
                MsgModel *model = [[MsgModel alloc]initWithDict:array[i]];
                [self.listArr addObject:model];
            }
            
            [self.SubViewOnemTableView reloadData];
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


-(void)loadhotel_condition:(NSString *)fid{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,details_hotelSel];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"id":@([fid intValue])} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            HoleggModel *model = [[HoleggModel alloc]initWithDict:serverInfo.response[@"data"]];
            [_bottomView setGglist:model];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


-(void)loadcommentNetWork:(NSString *)pages{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,details_commnets];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"id":self.sid,@"page":pages} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSArray *array = serverInfo.response[@"data"];
            for (int i = 0; i < [array count]; i ++) {
                CommentModel *comm = [[CommentModel alloc]initWithDict:array[i]];
                [self.data addObject:comm];
            }
            
            [self.SubViewOnemTableView reloadData];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


-(void)loadhtordersettlement{
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSString *uidStr = nil;
    
    if (!unmodel)
        uidStr = @"";
    else
        uidStr = unmodel.uid;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,htorder_settlement];
    
    NSString *nowStr = [NSObject getNowtime];
    NSString *nextStr = [NSObject getnextDate];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"uid":uidStr,@"start":nowStr,@"end":nextStr,@"id":self.roomId} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            [self pushToController];
        }else if ([serverInfo.response[@"code"] integerValue] == 201){
            
        }else{
            [HUDManager showTextHud:loadError];
        }
        
    }];
}


#pragma mark - createBaseView
- (void)createBaseView {
    
    self.baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0 , self.view.frame.size.width, 360)];
    self.baseScrollView.contentSize = CGSizeMake(KSCREEN_WIDTH, 340);
    self.baseScrollView.showsVerticalScrollIndicator = NO;
    self.baseScrollView.showsHorizontalScrollIndicator = NO;
    self.baseScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(16, kItemListLeft, KSCREEN_WIDTH-2*kItemListLeft, 2*kItemListLeft)];
//    lable.textColor = [UIColor blackColor];
//    lable.font = [UIFont systemFontOfSize:14];
//    lable.text = @"借条文件";
//    [self.baseScrollView addSubview:lable];
    self.SubViewOnemTableView.tableFooterView = self.baseScrollView;
}


#pragma mark - createImgViewItems
- (void)createImgViewItems {
    
    HDragItem *item = [[HDragItem alloc] init];
    item.backgroundColor = [UIColor clearColor];
    item.image = [UIImage imageNamed:@""];
    item.isAdd = YES;
    
    HDragItemListView *itemList = [[HDragItemListView alloc] initWithFrame:CGRectMake(kItemListLeft, 4*kItemListTop, KSCREEN_WIDTH-2*kItemListLeft, 0)];
    
    self.itemView = itemList;
    self.itemList = itemList;
    itemList.scaleItemInSort = 1.3;
    // 需要排序
    itemList.isSort = YES;
    itemList.isFitItemListH = YES;
    itemList.showDeleteView = NO;
    
    [itemList addItem:item];
    
    __weak typeof(self) weakSelf = self;
    [itemList setClickItemBlock:^(HDragItem *item) {
        if (!item.isAdd) {
            [weakSelf handleItemClikEvent:item];
        }
    }];
    
    itemList.deleteItemBlock = ^(HDragItem *item) {
        
    };
    
    [self.baseScrollView addSubview:itemList];
}


- (void)addImg:(UIImage *)selectedImg {
    HDragItem *item = [[HDragItem alloc] init];
    item.image = selectedImg;
    [self.itemList addItem:item];
}


- (void)handleItemClikEvent:(HDragItem *)item {
    UIImageView *imgView = item;
    for (UIImageView *sub in self.itemList.itemArray) {
        if ([imgView.image isEqual:sub.image]) {
            self.tapIndex = [self.itemList.itemArray indexOfObject:sub];
            
            break;
        }
    }
    
    ScanSelectedImgViewController *scan = [[ScanSelectedImgViewController alloc]init];
    scan.itemArr = self.imgArr;
    [self.navigationController pushViewController:scan animated:YES];
    
}

#pragma mark -createTextView
- (void)createTextView {
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(self.itemView.frame)+kItemListLeft, KSCREEN_WIDTH-2*kItemListLeft, 20)];
    lable.textColor = [UIColor blackColor];
    lable.font = [UIFont systemFontOfSize:14];
    lable.text = @"备注：";
    
    self.describeContent = [[UITextView alloc] initWithFrame:CGRectMake(kItemListLeft, CGRectGetMaxY(self.itemView.frame)+4*kItemListLeft, KSCREEN_WIDTH-2*kItemListLeft, kDescribeContentHeight)];
    self.describeContent.font = [UIFont systemFontOfSize:kDescribeContentFont];
    self.describeContent.text = @"暂无";
    self.describeContent.userInteractionEnabled = NO;
    [self.baseScrollView addSubview:lable];
    [self.baseScrollView addSubview:self.describeContent];
}

//- (void)insertRowAtBottom {
//    for (int i = 0; i<20; i++) {
//        [self.data addObject:@"1"];
//    }
//    __weak UITableView *tableView = self.SubViewOnemTableView;
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
    
    if ([self.title isEqualToString:HotelDetailsListArr[0]] ) {
        self.SubViewOnemTableView.mj_footer.hidden = [self.listArr count]<10;
        return [self.listArr count];
    }else if ([self.title isEqualToString:HotelDetailsListArr[1]] ){
        self.SubViewOnemTableView.mj_footer.hidden = [self.data count]<10;
        return [self.data count];
    }else if ([self.title isEqualToString:HotelDetailsListArr[2]] || [self.title isEqualToString:HotelDetailsListArr[3]]){
        return 1;
    }else{return 0;}
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.title isEqualToString:HotelDetailsListArr[0]]) {
        CresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresTableViewCell"];
        if (!cell) {
            NSLog(@"chuangjian");
        }
        
        cell.selectbtnBlock = ^(UIButton *btn) {
            CresTableViewCell *mcell = (CresTableViewCell *)[btn superview].superview;
            NSIndexPath *path = [self.SubViewOnemTableView indexPathForCell:mcell];
            MsgModel *mol = _listArr[path.row];
            self.roomId = mol.uid;
            [self showView:mol.uid];
        };
        
        if ([self.listArr count]) {
            cell.listmodels = _listArr[indexPath.row];
        }
        
        return cell;
    }else if ([self.title isEqualToString:HotelDetailsListArr[1]]){
        CresTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresTwoTableViewCell"];
        if (!cell) {
            
            NSLog(@"chuangjian");
        }
        
        if ([self.data count]) {
            cell.clistmodel = self.data[indexPath.row];
        }
        
        return cell;
        
    }else if ([self.title isEqualToString:HotelDetailsListArr[2]]){
        CresThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CresThirdTableViewCell"];
        if (!cell) {
            NSLog(@"chuangjian");
        }
        
//        cell.cdesc.text = [NSString stringWithFormat:@"商家介绍：%@",self.desc];
        
        [cell.contentView addSubview:self.webView];
        [self.webView loadHTMLString:[NSString stringWithFormat:@"%@",self.desc] baseURL:nil];
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
        return 147;
    }else if ([self.title isEqualToString:HotelDetailsListArr[2]]){
        return kStatusBarAndNavigationBarH-76;
    }else if ([self.title isEqualToString:HotelDetailsListArr[3]]){
        return 0;
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
-(void)dissView:(NSString *)type {
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, bottomH);
        [self.bjbtn setHidden:YES];
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT, KSCREEN_WIDTH, bottomH);
        [self.bjbtn setHidden:YES];
    } completion:^(BOOL finished) {
        if ([type isKindOfClass:[UIButton class]])
            return ;
        if ([type isEqualToString:@"10"]) {
            [self loadhtordersettlement];
        }
    }];
    
}


-(void)showView:(NSString *)fid{
    [UIView animateWithDuration:0.3 animations:^{
        _bottomView.frame = CGRectMake(0, KSCREEN_HEIGHT-bottomH, self.view.frame.size.width, bottomH);
        [self.bjbtn setHidden:NO];
    } completion:^(BOOL finished) {
        [self loadhotel_condition:fid];
    }];
}

-(void)addobjectWith:(NSArray *)imgArray{
    for (int i = 0; i < [imgArray count]; i ++) {
        UIImage *img = [NSObject getImageFromURL:imgArray[i]];
//        [self.imgArray addObject:_imgStr];
        [self addImg:img];
    }
}


-(void)pushToController {
    
    OnlineBookingViewController *online = [[OnlineBookingViewController alloc]init];
    online.payType = OnlineBookingViewHotelPay;
    online.fjid = self.roomId;
    [self.navigationController pushViewController:online animated:YES];
}


- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];

    }
    return _data;
}


-(NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
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
