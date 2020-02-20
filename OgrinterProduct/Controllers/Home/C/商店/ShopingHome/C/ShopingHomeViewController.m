//
//  ShopingHomeViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//


#define shopApi @"goods/index"


#import "ShopingHomeViewController.h"
#import "ShopSeckillDetailsViewController.h"
#import "KillerAsselbViewController.h"

#import "ShopHomeSectionView.h"
#import "ShoperHeadView.h"

#import "ShopCollectionReusableView.h"
#import "WSLWaterFlowLayout.h"
#import "ShopCollectionViewCell.h"

#import "AsseKillerViewController.h"

#import "MDBannerModel.h"
#import "MdBannerListModel.h"


@interface ShopingHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>{
    NSArray *sectionArr;
}

@property(nonatomic,strong)ShoperHeadView *headView;

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *btns;

@end

@implementation ShopingHomeViewController

-(ShoperHeadView *)headView {
    if (!_headView) {
        _headView = [[NSBundle mainBundle]loadNibNamed:@"ShoperHeadView" owner:self options:nil].lastObject;
        [_headView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 652)];
        __weak typeof(&*self)weakSelf = self;
        _headView.ptmsBlock = ^(NSInteger idx) {
//            [HUDManager showTextHud:OtherMsg];
//            return;
            if (idx == 10009) {

                AsseKillerViewController *ass = [[AsseKillerViewController alloc]init];
                [weakSelf.navigationController pushViewController:ass animated:YES];

            }else if (idx == 10008){

                KillerAsselbViewController *ass = [[KillerAsselbViewController alloc]init];
                [weakSelf.navigationController pushViewController:ass animated:YES];
            }else{}
        };
    }
    return _headView;
}

-(NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

//MARK:- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    self.mCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNetWork];
    }];
    
    [self loadNetWork];
    // Do any additional setup after loading the view from its nib.
}


-(void)loadNetWork{
    NSString *url = [NSString stringWithFormat:@"%@%@",API_BASE_URL_STRING,shopApi];
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:url params:@{} complement:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] integerValue] == 200) {
            NSDictionary *dict = serverInfo.response[@"data"];
            MDBannerModel *model = [[MDBannerModel alloc] initWithDict:dict];
            
            [self.dataArr addObject:model];
            
            NSArray *Barray = [model.dataDic objectForKey:@"banner"];
            NSMutableArray *listArr = [NSMutableArray array];
            for (int i = 0; i < [Barray count]; i ++) {
                MdBannerListModel *list = Barray[i];
                list.bgImg = @"http://md-juhe.oss-cn-hangzhou.aliyuncs.com/upload/ad/20180417/9bc42ce40490c854eab2e9969ac8e328caab0a17.png";
                [listArr addObject:list];
            }
            [self.headView setBanArr:listArr];
            
        }else {
            [HUDManager showTextHud:loadError];
        }
        
        [self.mCollectionView reloadData];
        [self.mCollectionView.mj_header endRefreshing];
    }];
}


-(void)setup{
    
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc]init];
    
    layout.delegate = self;
    
    [self.mCollectionView setCollectionViewLayout:layout];
    
    [self.mCollectionView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT- kStatuTabBarH)];
    
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCollectionViewCell"];
    
    //注册head
    [self.mCollectionView registerNib:[UINib nibWithNibName:@"ShopCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShopCollectionReusableView"];
}

//MARK:-collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {return 3;}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataArr count] > 0) {
        MDBannerModel *mode = self.dataArr[0];
        if (section == 1) {
            return [[mode.dataDic objectForKey:@"recommend_goods"] count];
        }else if (section == 2){
            return [[mode.dataDic objectForKey:@"bargain_goods"] count];
        }else{ return 0;}
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionViewCell" forIndexPath:indexPath];
    
    if ([self.dataArr count] > 0) {
        MDBannerModel *mode = self.dataArr[0];
        if (indexPath.section == 1) {
            MdBannerListModel *list = [mode.dataDic objectForKey:@"recommend_goods"][indexPath.item];
            cell.modellists = list;
        }else if (indexPath.section == 2){
            MdBannerListModel *list = [mode.dataDic objectForKey:@"bargain_goods"][indexPath.item];
            cell.modellists = list;
        }else{ }
        
    }

    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MDBannerModel *mode = self.dataArr[0];
    
    ShopSeckillDetailsViewController *seckill = [[ShopSeckillDetailsViewController alloc]init];
    seckill.seckillType = ShopSeckillDetailsTypeOrder;
    
    if (indexPath.section == 1) {
        MdBannerListModel *m = [[mode.dataDic objectForKey:@"recommend_goods"] objectAtIndex:indexPath.item];
        seckill.cpid = m.uid;
    }else if (indexPath.section == 2){
        MdBannerListModel *m = [[mode.dataDic objectForKey:@"bargain_goods"] objectAtIndex:indexPath.item];
        seckill.cpid = m.uid;
    }else{}
    
    [self.navigationController pushViewController:seckill animated:YES];
}

//MARK:- header 和 footer的获取逻辑
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        ShopCollectionReusableView *temp = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShopCollectionReusableView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [temp addSubview:self.headView];
        }else{
            ShopHomeSectionView *sectionView = [[NSBundle mainBundle]loadNibNamed:@"ShopHomeSectionView" owner:self options:nil].lastObject;
            [sectionView setFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 44)];
            [temp addSubview:sectionView];
            sectionView.btnclickBlcok = ^(UIButton *btn) {
                [HUDManager showTextHud:OtherMsg];
            };
        }

        return view = temp;
    }else
        return nil;
}


//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((self.view.width-30)/2,234);
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
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

//MARK:- Header and Footer
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForHeaderViewInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(self.view.width, 652);
    }else{
        return CGSizeMake(self.view.width, 64);
    }
}


////MARK:-
//- (IBAction)btnClick:(UIButton *)sender {
//    KPreventRepeatClickTime(1)
//    if (sender.tag == 10008) {
//        ShopSeckillDetailsViewController *seckill = [[ShopSeckillDetailsViewController alloc]init];
//        seckill.seckillType = ShopSeckillDetailsTypeKill;
//        [self.navigationController pushViewController:seckill animated:YES];
//    }else if (sender.tag == 10009){
//
//    }else{
//
//    }
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
