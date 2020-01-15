//
//  HotelViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#define hotel_cate @"hotel/cate"//酒店分类

#define hotel_hotellist @"hotel/hotellist"//酒店商家


#import "HotelViewController.h"
#import "HotolListViewController.h"
#import "HotelDetlisViewController.h"
#import "THDatePickerView.h"
#import "MsgViewCell.h"
#import "MsgModel.h"
#import "UIButton+Ex.h"


@interface HotelViewController ()<UITableViewDelegate,UITableViewDataSource,THDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UIView *topbjView;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (weak, nonatomic) IBOutlet UIButton *checkDate;

@property (weak, nonatomic) IBOutlet UIButton *leveDate;

@property (weak, nonatomic) IBOutlet UIButton *setSetbtn;

@property (weak, nonatomic) THDatePickerView *dateView;

@property(nonatomic,strong)UIScrollView *mScroller;

@property (nonatomic,weak) UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *categroybjView;

@property(nonatomic,strong)NSString *datatype;

@property (nonatomic,strong)NSMutableArray *categoryArr;

@property (nonatomic,strong)NSMutableArray *listArr;

@end

@implementation HotelViewController



-(NSMutableArray *)categoryArr{
    if (!_categoryArr) {
        _categoryArr = [NSMutableArray array];
    }
    return _categoryArr;
}



-(UIScrollView *)mScroller{
    if (!_mScroller) {
        _mScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 88)];
        _mScroller.showsHorizontalScrollIndicator = NO;
    }
    return _mScroller;
}

-(NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc]init];
    }
    return _listArr;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"酒店住宿";
    
//    self.toTop.constant = kStatusBarAndNavigationBarHeight;
    
    [self setloadsubViews];
    [self createDatePicker];
    
    [self loadNetWork];
    [self loadlistNetWork];
    // Do any additional setup after loading the view from its nib.
}


-(void)loadNetWork {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,hotel_cate];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            if ([_categoryArr count])
                [_categoryArr removeAllObjects];
            
            NSArray *array = serverInfo.response[@"data"];
            for (int i = 0; i < [array  count]; i ++ ) {
                MsgModel *model = [[MsgModel alloc]initWithDict:array[i]];
                [self.categoryArr addObject:model];
            }
            [self creatbtns:self.categoryArr];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
    }];
}


-(void)loadlistNetWork{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,hotel_hotellist];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            if ([_listArr count])
                [_listArr removeAllObjects];
            
            NSArray *array = serverInfo.response[@"data"] ;
            for (int i = 0; i < [array  count]; i ++ ) {
                MsgModel *model = [[MsgModel alloc]initWithDict:array[i]];
                [self.listArr addObject:model];
            }
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        [self.mTableView reloadData];
    }];
    
}


//MARK:-loadsubViews
-(void)setloadsubViews {
    
    [self wr_setNavBarBackgroundAlpha:0];
    
    self.searchBtn.layer.cornerRadius = 6;
    self.topbjView.layer.cornerRadius = 6;
    
    [self buttonEdgeInsets:self.checkDate width:KSCREEN_WIDTH/5];
    [self buttonEdgeInsets:self.leveDate width:KSCREEN_WIDTH/5-5];
    [self buttonEdgeInsets:self.searchBtn width:20];
    
    self.mTableView.tableFooterView = [UILabel new]; self.mTableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.mTableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:@"MsgViewCell"];
    
    [self.categroybjView addSubview:self.mScroller];
    
}


-(void)createDatePicker {
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, KSCREEN_WIDTH, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT-100)];
    [v setBackgroundColor:[UIColor grayColor]];
    [v setHidden:YES];
    [v setAlpha:0.4];
    self.topView = v;
    [self.view addSubview:v];
    self.dateView = dateView;
    [self.view addSubview:dateView];
    
}

//MARK:-tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArr count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    
    if (!cell) {
        NSLog(@"创建");
    }
    
    cell.selectBlock = ^(UIButton *button) {
        
    };
    
    if ([self.listArr count]) {
        MsgModel *model = _listArr[indexPath.row];
        cell.listmodel = model;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgModel *model = _listArr[indexPath.row];
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HotelDetlisViewController *holel = [[HotelDetlisViewController alloc]init];
    holel.navigationItem.title = model.name;
    holel.jid = model.uid;
    
    [self.navigationController pushViewController:holel animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
    v.backgroundColor = KSRGBA(255, 255, 255, 1);
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(16, 12, KSCREEN_WIDTH-32, 20)];
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = [UIColor blackColor];
    title.text = GuessYlike;
    
    [v addSubview:title];
    
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;

}


//MARK:-
- (IBAction)selectdata:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    if (sender.tag == 2002) {
        
        NSString *msgStr = nil;
        if ([self.checkDate.titleLabel.text isEqualToString:@"入住日期"])
            msgStr = @"请选择入住时间";
        else if ([self.checkDate.titleLabel.text isEqualToString:@"离开日期"])
            msgStr = @"请选择离开时间";
        else if ([self.setSetbtn.titleLabel.text isEqualToString:@"设置我喜欢的星级/价格"]){
            //msgStr = @"请设置能星级/价格";
        }else{}
        
        
        if (msgStr.length) {
            [HUDManager showTextHud:msgStr];
            return;
        }
        
        HotolListViewController *listView = [[HotolListViewController alloc]init];
        [self.navigationController pushViewController:listView animated:YES];
    }else {
        
        if (sender.tag == 2000)
            self.datatype = @"1";
        else if (sender.tag == 2001)
            self.datatype = @"2";
        
        [UIView animateWithDuration:0.3 animations:^{
            self.dateView.frame = CGRectMake(0, self.view.height - 300, self.view.width, 300);
            [self.dateView show];
            [self.topView setHidden:NO];
        }];
        
        if (sender.tag == 2000) {
            
        }else{
            
        }
    }
}


- (IBAction)selectSet:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    
}

//MARK:- buttonEdgeInsets
-(void)buttonEdgeInsets:(UIButton *)button width:(CGFloat)width{
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.bounds.size.width + 2, 0, button.imageView.bounds.size.width + 10)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width + width, 0, -button.titleLabel.bounds.size.width + 2)];
    
}


//MARK:- datePicker
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        [self.topView setHidden:YES];
    }];
    
    NSArray *array = [timer componentsSeparatedByString:@" "];
    
    if ([self.datatype isEqualToString:@"1"])
        [self.checkDate setTitle:[NSString stringWithFormat:@"%@",array[0]] forState:0];
    else if ([self.datatype isEqualToString:@"2"])
        [self.leveDate setTitle:[NSString stringWithFormat:@"%@",array[0]] forState:0];
    else{}

}


// MARK:- 取消按钮代理方法
- (void)datePickerViewCancelBtnClickDelegate {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        [self.topView setHidden:YES];
    }];
}


-(void)creatbtns:(NSArray *)array{
    
    for (int i = 0; i < [array count]; i ++) {
        MsgModel *model = array[i];
        UIView *imgView = [self createBtns:CGRectMake(i*88, 0, 88, 88) imgStr:model.img title:model.name];
        
        [imgView setTag:100+i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vatag:)];
        [imgView addGestureRecognizer:tap];
        
        [self.mScroller addSubview:imgView];
    }
    self.mScroller.contentSize = CGSizeMake([array count]*88,0);
}


-(UIView *)createBtns:(CGRect)frame imgStr:(NSString *)imgStr title:(NSString *)title {
    
    UIView *v = [[UIView alloc]initWithFrame:frame];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 14, v.height-46, v.height-46)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+5, CGRectGetWidth(v.frame), 20)];
    lable.textColor = UIColor.darkGrayColor;
    lable.font = [UIFont systemFontOfSize:12];
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.text = title;
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:nil];
    
    [v addSubview:imgView];
    [v addSubview:lable];
    
    return v;
}


-(void)vatag:(UITapGestureRecognizer *)tap {
    UIView *v = tap.view;
    NSLog(@"%ld",v.tag);
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
