//
//  HotelOnlineGotOrderViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/18.
//  Copyright © 2020 RXF. All rights reserved.
//



#import "HotelOnlineGotOrderViewController.h"
#import "HotelOnlineOrderTableViewCell.h"



@interface HotelOnlineGotOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


@end

@implementation HotelOnlineGotOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.mTableView.tableFooterView = [UILabel new];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"HotelOnlineOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotelOnlineOrderTableViewCell"];
    
    
    
}



//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HotelOnlineOrderTableViewCell *cell = [HotelOnlineOrderTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
    [cell configTempCellWith:indexPath];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%ld%ld",indexPath.section,indexPath.row);
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
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
