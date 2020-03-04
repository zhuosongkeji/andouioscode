//
//  KillerAsselbViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/2/20.
//  Copyright © 2020 RXF. All rights reserved.
//

#define goods_sec_list @"goods/sec_list"

#import "KillerAsselbViewController.h"
#import "ShopSeckillDetailsViewController.h"
#import "AssemTableViewCell.h"
#import "WSLWaterFlowLayout.h"
#import "AsseCollectionViewCell1.h"
#import "AssemTableViewCell.h"
#import "KillerAessModel.h"
#import "KillerListAessbModel.h"
#import "KillAessBTopViewCell.h"
#import "iCarousel.h"


@interface KillerAsselbViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView2;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property(nonatomic,strong)NSString *nowStr;
@property (weak, nonatomic) IBOutlet UIView *bjView;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@property(nonatomic,strong)WSLWaterFlowLayout *layout;

@property (nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation KillerAsselbViewController

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *time = [NSObject getNowtime1];
    NSLog(@"%@",time);
    NSArray *arr = [time componentsSeparatedByString:@":"];
    self.nowStr = arr[0];
    
    [self wr_setNavBarBackgroundAlpha:0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setup];
    // Do any additional setup after loading the view from its nib.
}


-(void)setup{
    
    self.bjView.layer.cornerRadius = 6;

    self.mTableView.tableFooterView = [UILabel new];
    
    self.layout = [[WSLWaterFlowLayout alloc]init];
    
    WSLWaterFlowLayout *layout1 = [[WSLWaterFlowLayout alloc]init];
    
    self.layout.delegate = self;
    layout1.delegate = self;
    
    [self.mCollectionView setCollectionViewLayout:self.layout];
    [self.mCollectionView2 setCollectionViewLayout:layout1];
    
    
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    self.mCollectionView2.delegate = self;
    self.mCollectionView2.dataSource = self;
    
    [self.mTableView registerNib:[UINib nibWithNibName:@"AssemTableViewCell" bundle:nil] forCellReuseIdentifier:@"AssemTableViewCell"];
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"AsseCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:@"AsseCollectionViewCell1"];
    
    [self.mCollectionView2 registerNib:[UINib nibWithNibName:@"KillAessBTopViewCell" bundle:nil] forCellWithReuseIdentifier:@"KillAessBTopViewCell"];
    
    [self loadnetWork];
    
}


-(void)loadnetWork{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,goods_sec_list];
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{@"sec_hour":self.nowStr,@"page":@"1"} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict = serverInfo.response[@"data"];
            KillerAessModel *model = [[KillerAessModel alloc]initWithDict:dict];
            [self.dataArr addObject:model];
            [self.mCollectionView reloadData];
            [self.mTableView reloadData];
        }else {
            [HUDManager showTextHud:loadError];
        }
        
        [self.mCollectionView reloadData];
        [self.mTableView reloadData];
    }];
}

//MARK:-collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.dataArr count]) {
        KillerAessModel *model = self.dataArr[0];
        return [model.top_goods count];
    }
    return 5;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.mCollectionView) {
        AsseCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AsseCollectionViewCell1" forIndexPath:indexPath];
        
        if ([self.dataArr count]) {
            KillerAessModel *model = self.dataArr[0];
            KillerListAessbModel *m = model.top_goods[indexPath.item];
            cell.modellists = m;
        }
        
        cell.titblabel.textColor = UIColor.redColor;
        cell.titblabel.textAlignment = NSTextAlignmentCenter;
        [cell.iconimg setHidden:YES];
        [cell.tlable setHidden:YES];
        [cell.plabel setHidden:YES];
        
        return cell;
        
    }else{
        
        KillAessBTopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KillAessBTopViewCell" forIndexPath:indexPath];
        
        if (indexPath.item == 0) {
            if ([self.nowStr integerValue]-2 >= 8) {
                cell.desc.text = @"已开抢";
                cell.time.text = [NSString stringWithFormat:@"%ld:00",[self.nowStr integerValue]-2];
            }else{
                cell.desc.text = @"";
                cell.time.text = @"";
            }

        }else if (indexPath.item == 1){
            
            if ([self.nowStr integerValue]-1 >= 9) {
                cell.desc.text = @"已开抢";
                cell.time.text = [NSString stringWithFormat:@"%ld:00",[self.nowStr integerValue]-1];
            }else{
                cell.desc.text = @"";
                cell.time.text = @"";
            }
            
        }else if (indexPath.item == 2) {
            cell.time.textColor = [UIColor whiteColor];
            cell.desc.textColor = UIColor.whiteColor;
            cell.desc.text = @"抢购进行中";
            cell.time.text = [NSString stringWithFormat:@"%@:00",self.nowStr];
        }else if (indexPath.item == 3){
            if ([self.nowStr integerValue]+1 <=17 ) {
                cell.desc.text = @"即将开场";
                cell.time.text = [NSString stringWithFormat:@"%ld:00",[self.nowStr integerValue]+1];
            }else{
                cell.desc.text = @"";
                cell.time.text = @"";
            }
        }else if (indexPath.item == 4){
            if ([self.nowStr integerValue]+2 <=18 ) {
                cell.desc.text = @"即将开场";
                cell.time.text = [NSString stringWithFormat:@"%ld:00",[self.nowStr integerValue]+2];
            }else{
                cell.desc.text = @"";
                cell.time.text = @"";
            }
        }
//        if ([self.nowStr integerValue]-2 < 7) {
//
//        }
//        if ([self.nowStr integerValue] <= 8) {
//            cell.time.text = [NSString stringWithFormat:@"%@",DataTimerArr[indexPath.item+2]];
//        }else if ([self.nowStr integerValue] == 9){
//            cell.time.text = [NSString stringWithFormat:@"%@",DataTimerArr[indexPath.item+1]];
//        }else{
//            cell.time.text = [NSString stringWithFormat:@"%@",DataTimerArr[indexPath.item+1]];
//        }
        
        return cell;
    }
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopSeckillDetailsViewController *seckill = [[ShopSeckillDetailsViewController alloc]init];
    seckill.seckillType = ShopSeckillDetailsTypeKill;
    
    KillerAessModel *model = self.dataArr[0];
    KillerListAessbModel *m = model.top_goods[indexPath.item];
    
    seckill.cpid = m.goods_id;
    seckill.sec_id = m.sec_id;
    
    [self.navigationController pushViewController:seckill animated:YES];
}


//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (waterFlowLayout == self.layout) {
        return  CGSizeMake((self.view.width-30)/2,150);
    }
    return  CGSizeMake(self.view.width/5,44);
    
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (waterFlowLayout == self.layout) {
        return  3;
    }
    return 5;
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
    if ([self.dataArr count]) {
        KillerAessModel *model = self.dataArr[0];
        return [model.goods_list count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AssemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssemTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"AssemTableViewCell" owner:self options:nil].lastObject;
    }
    
    if ([self.dataArr count]) {
        KillerAessModel *model = self.dataArr[0];
        KillerListAessbModel *m = model.goods_list[indexPath.row];
        cell.modelis1 = m;
    }
    
    [cell.sbtn setTitle:@"马上抢" forState:0];
    
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
