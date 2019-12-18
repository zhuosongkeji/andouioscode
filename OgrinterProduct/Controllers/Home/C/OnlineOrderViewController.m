//
//  OnlineOrderViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/18.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "OnlineOrderViewController.h"
#import "MenuScreeningView.h"

#import "HomeTableViewCell.h"


@interface OnlineOrderViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UIView *bjTopView;

@property (weak, nonatomic) IBOutlet UIView *TopbjView;


@property (nonatomic,strong) MenuScreeningView *menuScreeningView;

@end

@implementation OnlineOrderViewController


-(MenuScreeningView *)menuScreeningView{
    if (!_menuScreeningView) {
        _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, MenuHeight)];
        _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    }
    return _menuScreeningView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
}


//MARK:- tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section != 3) {
        return 0;
    }else {
        return 3;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [HomeTableViewCell tempTableViewCellWith:tableView indexPath:indexPath];
    
    [cell configTempCellWith:indexPath];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 3) {
        return 0;
    }else{
        return 222;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 37)];
        [v addSubview:self.menuScreeningView];
        return v;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 37;
    }
    return 0;
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
