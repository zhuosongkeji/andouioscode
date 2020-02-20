//
//  KillerAsselbViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "KillerAsselbViewController.h"
#import "AssemTableViewCell.h"
#import "WSLWaterFlowLayout.h"
#import "AsseCollectionViewCell1.h"
#import "AssemTableViewCell.h"


@interface KillerAsselbViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *bjView;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;


@end

@implementation KillerAsselbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self wr_setNavBarBackgroundAlpha:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.bjView.layer.cornerRadius = 6;
    [self.mScrollView setContentSize:CGSizeMake(3*KSCREEN_WIDTH, 64)];
    self.mTableView.tableFooterView = [UILabel new];
    
    
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    [self.mCollectionView setCollectionViewLayout:layout];
    
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"AssemTableViewCell" bundle:nil] forCellReuseIdentifier:@"AssemTableViewCell"];
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"AsseCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:@"AsseCollectionViewCell1"];
    
}

//MARK:-collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AsseCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AsseCollectionViewCell1" forIndexPath:indexPath];
    
    cell.titblabel.textColor = UIColor.redColor;
    cell.titblabel.text = @"玩具";
    cell.titblabel.textAlignment = NSTextAlignmentCenter;
    [cell.iconimg setHidden:YES];
    [cell.tlable setHidden:YES];
    [cell.plabel setHidden:YES];
    
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    ShopSeckillDetailsViewController *shoper = [[ShopSeckillDetailsViewController alloc]init];
//    [self.navigationController pushViewController:shoper animated:YES];
}


//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake((self.view.width-30)/2,130);
    
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 3;
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 1;
}

/** 列间距*/
-(CGFloat)columnMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 行间距*/
-(CGFloat)rowMarginInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 边缘之间的间距*/
-(UIEdgeInsets)edgeInsetInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


//MARK: -tableView
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
    
    cell.yplable.text = @"抢购45%";
    [cell.sbtn setTitle:@"已抢购" forState:0];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
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
