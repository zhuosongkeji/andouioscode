//
//  OnlineBookingViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "OnlineBookingViewController.h"
#import "CustomAlterView.h"
#import "OnlineTableViewCell.h"
#import "PaySuccessViewController.h"


@interface OnlineBookingViewController ()<UITableViewDelegate,UITableViewDataSource,OnlineTableViewCellDelegate>{
    
    BOOL HHR;
}


@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(nonatomic,strong)CustomAlterView *alterView;

@property (nonatomic,weak)UIButton *bjbtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@property (assign, nonatomic) NSIndexPath *selectedIndexPath;//单选，当前选中的行

@end

@implementation OnlineBookingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    if (self.payType == OnlineBookingViewHotelPay) {
        self.navigationItem.title = OnlinTitleArr[0];
         [self createAlter];
    }else if (self.payType == OnlineBookingViewProductPay){
        self.navigationItem.title = OnlinTitleArr[1];
    }else if (self.payType == OnlineBookingViewOrderPay){
        
    }else{}
    
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.toTop.constant = kStatusBarAndNavigationBarH;
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"OnlineTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnlineTableViewCell"];
}


-(void)createAlter{
    _alterView = [[[NSBundle mainBundle]loadNibNamed:@"CustomAlterView" owner:self options:nil]lastObject];
    [_alterView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH-64, KSCREEN_HEIGHT-280)];
    _alterView.btnBlcok = ^{
        HHR = YES;
    };
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.payType == 0) {
            return 7;
        }else if (self.payType == 1){
            return 4;
        }else if (self.payType == 2){
            return 0;
        }else{return 0;}
    }
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OnlineTableViewCell *cell = [OnlineTableViewCell tempTableViewCellWith:self.mTableView indexPath:indexPath withTpye:self.payType];
    
    [cell configTempCellWith:indexPath];
    
    cell.xlDelegate = self;
    
    
    cell.selectedIndexPath = indexPath;
    if (_selectedIndexPath == indexPath)
        cell.selectBtn.selected = YES;
    else
        cell.selectBtn.selected = NO;
    
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH,44)];
    v.backgroundColor = KSRGBA(255, 255, 255, 1);
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(16, 11, KSCREEN_WIDTH-32, 21)];
    lable.textColor = [UIColor lightGrayColor];
    lable.font = [UIFont systemFontOfSize:14];
    
    lable.text = selectpayStyle;
    [v addSubview:lable];
    
    return v;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.payType == 0) {
            return [[@[@"105",@"79",@"50",@"50",@"50",@"50",@"50"] objectAtIndex:indexPath.row] floatValue];
        }else if (self.payType == 1){
            return [[@[@"105",@"95",@"50",@"50"] objectAtIndex:indexPath.row] floatValue];
        }else if (self.payType == 2){
            return 0;
        }else {return 0;}
        
    }else if (indexPath.section == 1){
        return 50;
    }
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (IBAction)orderclick:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    [[QWAlertView sharedMask] show:_alterView withType:QWAlertViewStyleAlert animationFinish:^{
        
    } dismissHandle:^{
        if (HHR) {
            HHR = NO;
            PaySuccessViewController *pay = [[PaySuccessViewController alloc]init];
            [self.navigationController pushViewController:pay animated:YES];
        }
    }];
}


//MARK:-
- (void)handleSelectedButtonActionWithSelectedIndexPath:(NSIndexPath *)selectedIndexPath{
    if (selectedIndexPath.section == 1) {
        OnlineTableViewCell *celled = [self.mTableView cellForRowAtIndexPath:_selectedIndexPath];
        celled.selectBtn.selected = NO;
        //记录当前选中的位置索引
        _selectedIndexPath = selectedIndexPath;
        //当前选择的打勾
        OnlineTableViewCell *cell = [self.mTableView cellForRowAtIndexPath:selectedIndexPath];
        cell.selectBtn.selected = YES;
    }
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
