//
//  HomeTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/28.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "HomeTableViewCell.h"
#import "HomeCellModel.h"
#import "HXCollectionViewCell.h"
#import "WSLWaterFlowLayout.h"
#import "OnlineOrderModel.h"
#import "OnlineOrderListModel.h"
#import "HXCollectionCollectionViewCell.h"
#import "ShopCollectionViewCell.h"
#import "MsgViewCell.h"
#import "MdBannerListModel.h"
#import "MDBannerModel.h"

@interface HomeTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout>

//MARK:cell 1
@property (weak, nonatomic) IBOutlet UICollectionView *mCollec1;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollec2;
@property (weak, nonatomic) IBOutlet UIView *mCollec2BjView;
@property (weak, nonatomic) IBOutlet UIButton *mCollec2BJViewButton1;
@property (weak, nonatomic) IBOutlet UIButton *mCollec2BJViewButton2;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout1;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout2;

//MARK:cell 2
@property (weak, nonatomic) IBOutlet UICollectionView *mCollec3;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout3;

//MARK:cell 3
@property (weak, nonatomic) IBOutlet UILabel *mTitle1;
@property (weak, nonatomic) IBOutlet UIButton *mDZButton1;
@property (weak, nonatomic) IBOutlet UIView *mScoreBJView1;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollec4;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout4;


//MARK:cell 4
@property (weak, nonatomic) IBOutlet UILabel *mTitle2;
@property (weak, nonatomic) IBOutlet UIView *mScoreBJView2;
@property (weak, nonatomic) IBOutlet UIButton *mDZButton2;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollec5;
@property(nonatomic,strong)WSLWaterFlowLayout *mylayout5;

//MARK:cell 5
@property (weak, nonatomic) IBOutlet UITableView *mTable;

//MARK:cell 6
@property (weak, nonatomic) IBOutlet UICollectionView *mCollec6;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout6;

@end


@implementation HomeTableViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

-(void)setup1{
    
    self.layout1 = [[UICollectionViewFlowLayout alloc]init];
    self.layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout1.minimumLineSpacing = 10;
    self.layout1.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.layout1.itemSize = CGSizeMake((KSCREEN_WIDTH-50)/4,108);
    
    self.mCollec1.delegate = self;
    self.mCollec1.dataSource = self;
    
    [self.mCollec1 registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
}

-(void)setup3{
    
    self.layout3 = [[UICollectionViewFlowLayout alloc]init];
    
    self.layout3.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout3.minimumLineSpacing = 10;
    self.layout3.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.layout3.itemSize = CGSizeMake((KSCREEN_WIDTH-50)/4,108);
    [self.mCollec3 setCollectionViewLayout:self.layout3];
    self.mCollec3.delegate = self;
    self.mCollec3.dataSource = self;
    [self.mCollec3 registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
}

-(void)setup4{
    
    self.layout4 = [[UICollectionViewFlowLayout alloc]init];
    
    self.layout4.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout4.minimumLineSpacing = 10;
    self.layout4.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.layout4.itemSize = CGSizeMake((KSCREEN_WIDTH-40)/3,128);
    [self.mCollec4 setCollectionViewLayout:self.layout4];
    self.mCollec4.delegate = self;
    self.mCollec4.dataSource = self;
    [self.mCollec4 registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
}


-(void)setup5{
    
    self.mylayout5 = [[WSLWaterFlowLayout alloc]init];
    
    self.mylayout5.delegate = self;
    
    [self.mCollec5 setCollectionViewLayout:self.mylayout5];
    self.mCollec5.delegate = self;
    self.mCollec5.dataSource = self;
    [self.mCollec5 registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
    [self.mCollec5 setCollectionViewLayout:self.mylayout5];
}


-(void)setup6{
    
    self.layout6 = [[UICollectionViewFlowLayout alloc]init];
    
    self.layout6.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout6.minimumLineSpacing = 10;
    self.layout6.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.layout6.itemSize = CGSizeMake((KSCREEN_WIDTH-30)/2,208);
    
    [self.mCollec6 setCollectionViewLayout:self.layout6];
    self.mCollec6.delegate = self;
    self.mCollec6.dataSource = self;
    [self.mCollec6 registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCollectionViewCell"];
}


-(void)setup2{
    
    self.layout2 = [[UICollectionViewFlowLayout alloc]init];
    
    self.layout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout2.minimumLineSpacing = 10;
    self.layout2.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.layout2.itemSize = CGSizeMake((KSCREEN_WIDTH-50)/4,108);
    [self.mCollec2 setCollectionViewLayout:self.layout2];
    self.mCollec2.delegate = self;
    self.mCollec2.dataSource = self;
    [self.mCollec2 registerNib:[UINib nibWithNibName:@"HXCollectionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionCollectionViewCell"];
}


-(void)setupTableView{
    
    self.mTable.tableFooterView = [UILabel new];
    self.mTable.delegate = self;
    self.mTable.dataSource = self;
    
    [self.mTable registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:@"MsgViewCell"];
}

-(void)setListArrt:(NSArray *)listArrt{
    _listArrt = listArrt;
    [self.mTable reloadData];
}

-(void)setListmodel:(HomeCellModel *)listmodel {
    _listmodel = listmodel;
}


-(void)setModelist:(OnlineOrderModel *)modelist{
    _modelist = modelist;
    [self setupStar:modelist.stars_all bjView:self.mScoreBJView2];
    if (_modelist) {
        [self.mCollec5 reloadData];
    }
}


-(void)setListArr:(NSArray *)listArr{
    _listArr = listArr;
    
    if ([_listArr count] > 0) {
        [self.mCollec1 reloadData];
        [self.mCollec1 setCollectionViewLayout:self.layout1];
    }
}

-(void)setBamodelist:(MDBannerModel *)Bamodelist{
    _Bamodelist = Bamodelist;
    [self.mCollec6 reloadData];
}

-(void)setModelist1:(OnlineOrderModel *)modelist1{
    _modelist1 = modelist1;
    [self setupStar:modelist1.stars_all bjView:self.mScoreBJView1];
    if (_modelist) {
        [self.mCollec4 reloadData];
    }
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.section) {
        case 0:
            identifier = @"HomeTableViewCellOne";
            index = 0;
            break;
            
        case 1:
            
            identifier = @"HomeTableViewCellTwo";
            index = 1;
            break;
    
            
        case 2:
            
            identifier = @"HomeTableViewCellThrid";
            index = 2;
            break;
            
        case 3:
            
            identifier = @"HomeTableViewCellFourth";
            index = 3;
            break;
        
        case 4:
            
            identifier = @"HomeTableViewCellFive";
            index = 4;
            break;
        
        case 5:
            
            identifier = @"HomeTableViewCellSix";
            index = 5;
            break;
            
        default:
            break;
    }
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        @try {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil] objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"cell == exception %@",exception);
        } @finally {
            
        }

        NSLog(@"创建TableViewCell");
    }
    
    return cell;
}



- (void)configTempCellWith:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            [self setup1];
            [self setup2];
            break;
            
        case 1:
            [self setup3];
            break;
            
        case 2:
            
            [self setup4];
            
            break;
            
        case 3:
            [self setup5];
            break;
            
        case 4:
            
            [self setupTableView];
            break;
            
        case 5:
            [self setup6];
            break;
            
        default:
            break;
    }
}


//MARK:-tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_listArrt count] >3)
        return 3;
    return [_listArrt count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    
    if (!cell) {
        NSLog(@"创建");
    }
    
    if ([self.listArrt count]>0) {
        cell.listmodel = self.listArrt[indexPath.row];
        
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}


//MARK: - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.mCollec1) {
        return [_listArr count];
    }else if (collectionView == self.mCollec2){
        return 4;
    }else if (collectionView == self.mCollec3){
        return 6;
    }else if (collectionView == self.mCollec4){
        return [_modelist1.cai count];;
    }
    else if (collectionView == self.mCollec5){
        return [_modelist.cai count];
    }
    else if (collectionView == self.mCollec6){
        return [[_Bamodelist.dataDic objectForKey:@"recommend_goods"] count];
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.mCollec1) {
        HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        cell.modelist0 = _listArr[indexPath.item];
        
        return cell;
        
    }else if (collectionView == self.mCollec2){
        HXCollectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionCollectionViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (collectionView == self.mCollec3){
        HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        
        return cell;
        
    }else if (collectionView == self.mCollec4){
        HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        
        cell.lmodelist1 = _modelist1.cai[indexPath.item];
        
        return cell;
        
    }else if (collectionView == self.mCollec5){
        HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
       
            cell.lmodelist1 = _modelist.cai[indexPath.item];
        
        return cell;
        
    }else if (collectionView == self.mCollec6){
        
        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionViewCell" forIndexPath:indexPath];
        
        MdBannerListModel *list = [_Bamodelist.dataDic objectForKey:@"recommend_goods"][indexPath.item];
        
        cell.modellists = list;
        
        return cell;
    }
    
    return nil;

}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = nil;
    if (collectionView == self.mCollec1) {
        
    }else if (collectionView == self.mCollec2){
        
    }else if (collectionView == self.mCollec3){
        
    }else if (collectionView == self.mCollec4){
        
    }else if (collectionView == self.mCollec5){
        
    }else if (collectionView == self.mCollec6){
        
    }else{}
    if (cell) {
        _mblock(cell.tag);
    }
}

//MARK:-
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    if (_modelist) {
        if ([_modelist.cai count]%3 == 0)
            if (indexPath.item == 0)
                return CGSizeMake(0, 148);
            else
                return CGSizeMake(0, 69);
            else if([_modelist.cai count]%3 != 0)
                return CGSizeMake(KSCREEN_WIDTH-20, 148);
            else
                return CGSizeZero;

    }
    return CGSizeZero;
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return 2;
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    return [_modelist.cai count];
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


-(void)setupStar:(NSString *)num bjView:(UIView *)view{
    for (int i = 0; i < [num integerValue]; i ++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(8+i*17,3,12,12)];
        imgView.image = [UIImage imageNamed:@"start"];
        [view addSubview:imgView];
    }
}


@end
