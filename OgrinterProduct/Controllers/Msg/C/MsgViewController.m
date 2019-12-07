//
//  MsgViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#define MenuHeight 36

#import "MsgViewController.h"
#import "MenuScreeningView.h"
#import "MsgViewCell.h"


@interface MsgViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MenuScreeningView *menuScreeningView;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toTop;

@end

@implementation MsgViewController



//MARK:- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toTop.constant = MenuHeight;
    
    _menuScreeningView = [[MenuScreeningView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, MenuHeight)];
    _menuScreeningView.backgroundColor = KSRGBA(255, 255, 255, 1);
    [self.view addSubview:_menuScreeningView];
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:@"MsgViewCell"];
    // Do any additional setup after loading the view from its nib.
}


//MARK:-tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    if (!cell) {
        NSLog(@"创建新的cell");
    }
    
    cell.selectBlock = ^(UIButton *button) {
        
    };
//    cell.listmodel =
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
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
