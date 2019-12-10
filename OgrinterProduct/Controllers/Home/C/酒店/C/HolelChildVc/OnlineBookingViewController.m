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


@interface OnlineBookingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    BOOL HHR;
}


@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(nonatomic,strong)CustomAlterView *alterView;

@property (nonatomic,weak)UIButton *bjbtn;

@end

@implementation OnlineBookingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线预订";
    
    [self setup];
    [self createAlter];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
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
        return 7;
    }
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OnlineTableViewCell *cell = [OnlineTableViewCell tempTableViewCellWith:self.mTableView indexPath:indexPath];
    
    [cell configTempCellWith:indexPath];
    
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
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [[@[@"105",@"79",@"50",@"50",@"50",@"50",@"50"] objectAtIndex:indexPath.row] floatValue];
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
