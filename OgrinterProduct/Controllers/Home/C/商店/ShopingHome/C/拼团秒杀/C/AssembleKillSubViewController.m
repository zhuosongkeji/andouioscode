//
//  AssembleKillSubViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/17.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "AssembleKillSubViewController.h"
#import "AssemTableViewCell.h"

@interface AssembleKillSubViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) BOOL fingerIsTouch;

@end

@implementation AssembleKillSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.subTableView.delegate = self;
    self.subTableView.dataSource = self;
    self.subTableView.tableFooterView = [UILabel new];
    [self.subTableView registerNib:[UINib nibWithNibName:@"AssemTableViewCell" bundle:nil] forCellReuseIdentifier:@"AssemTableViewCell"];
    
}



//MARK: -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AssemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssemTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"AssemTableViewCell" owner:self options:nil].lastObject;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
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
        //        if (!self.fingerIsTouch) {//这里的作用是在手指离开屏幕后也不让显示主视图，具体可以自己看看效果
        //            return;
        //        }
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AOtherTop" object:nil];//到顶通知父视图改变状态
    }
    self.subTableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
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
