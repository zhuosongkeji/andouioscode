//
//  OnlineBookingViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/9.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "OnlineBookingViewController.h"
#import "OnlineTableViewCell.h"


@interface OnlineBookingViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation OnlineBookingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线预订";
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.mTableView.tableFooterView = [UILabel new];
    [self.mTableView registerNib:[UINib nibWithNibName:@"OnlineTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnlineTableViewCell"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
