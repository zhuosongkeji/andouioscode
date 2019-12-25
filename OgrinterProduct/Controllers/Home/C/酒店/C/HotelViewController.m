//
//  HotelViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/6.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotelViewController.h"
#import "HotolListViewController.h"
#import "HotelDetlisViewController.h"
#import "THDatePickerView.h"
#import "MsgViewCell.h"
#import "MsgModel.h"


@interface HotelViewController ()<UITableViewDelegate,UITableViewDataSource,THDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UIView *topbjView;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (weak, nonatomic) IBOutlet UIButton *checkDate;

@property (weak, nonatomic) IBOutlet UIButton *leveDate;

@property (weak, nonatomic) IBOutlet UIButton *setSetbtn;

@property (weak, nonatomic) THDatePickerView *dateView;

@property (nonatomic,weak) UIView *topView;

@end

@implementation HotelViewController


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
    // Do any additional setup after loading the view from its nib.
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
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    
    if (!cell) {
        NSLog(@"创建");
    }
    
    cell.selectBlock = ^(UIButton *button) {
        
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HotelDetlisViewController *holel = [[HotelDetlisViewController alloc]init];
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
        HotolListViewController *listView = [[HotolListViewController alloc]init];
        [self.navigationController pushViewController:listView animated:YES];
    }else {
        
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


-(NSString *)getNowtime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSDate *nowDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMT];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    NSString *nowDateString = [dateFormatter stringFromDate:nowDate];
    
    return nowDateString;
}



//MARK:- datePicker
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        [self.topView setHidden:YES];
    }];
    
}


// MARK:- 取消按钮代理方法
- (void)datePickerViewCancelBtnClickDelegate {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        [self.topView setHidden:YES];
    }];
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
