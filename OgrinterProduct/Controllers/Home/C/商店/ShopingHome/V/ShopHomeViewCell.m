//
//  ShopHomeViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/4.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ShopHomeViewCell.h"
#import "WSLWaterFlowLayout.h"
#import "ShopCollectionViewCell.h"
#import "HXCollectionViewCell.h"
#import "CaseCluessKeybordCollectionHeadView.h"

@interface ShopHomeViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>

@property (nonatomic,strong)NSMutableArray *shops;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;

@property (nonatomic,strong)NSArray *titArr;

@end

@implementation ShopHomeViewCell

//MARK:-
-(NSMutableArray *)shops{
    
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}


-(void)setEnumtype:(MyEnum)enumtype{
    _enumtype = enumtype;
    
    self.titArr = @[@"一类",@"二类",@"三类"];
    [self setup];
}

//MARK:- setup
-(void)setup{
    
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    [self.mCollectionView setCollectionViewLayout:layout];
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    
    if (_enumtype == MyEnumValueA) {
        self.mCollectionView.scrollEnabled = NO;
        [self.mCollectionView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCollectionViewCell"];
        //注册head
        [self.mCollectionView registerNib:[UINib nibWithNibName:@"CaseCluessKeybordCollectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CaseCluessKeybordCollectionHeadView"];
    }else if (_enumtype == MyEnumValueB){
        self.mCollectionView.scrollEnabled = YES;
        [self.mCollectionView registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
        //注册head
        [self.mCollectionView registerNib:[UINib nibWithNibName:@"CaseCluessKeybordCollectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CaseCluessKeybordCollectionHeadView"];
        
    }else{
        [self.mCollectionView registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
    }
    
}


//MARK:-collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_enumtype == MyEnumValueA) {
        return 1;
    }else if (_enumtype == MyEnumValueB){
        return 3;
    }else{
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_enumtype == MyEnumValueA) {
        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionViewCell" forIndexPath:indexPath];
        //    cell.shop = self.shops[indexPath.item];
        return cell;
    }else if (_enumtype == MyEnumValueB){
        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        //    cell.shop = self.shops[indexPath.item];
        return cell;
    }else{
        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        //    cell.shop = self.shops[indexPath.item];
        return cell;
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopHomeViewCell *cell = (ShopHomeViewCell *)self.mCollectionView.superview.superview;
    NSIndexPath *path = nil;
    UIView *view = cell.superview;
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)view;
        path = [tableView indexPathForCell:cell];
    }
    
    _itemBlock(indexPath.item,path);
}

//MARK:- header 和 footer的获取逻辑
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        CaseCluessKeybordCollectionHeadView *temp = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CaseCluessKeybordCollectionHeadView" forIndexPath:indexPath];
        [temp setTitStr:self.titArr[indexPath.section]];
        view = temp;
        return view;
        
    }else
        return nil;
}


//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_enumtype == MyEnumValueA) {
        return CGSizeMake((KSCREEN_WIDTH-30)/2,234);
    }else if (_enumtype == MyEnumValueB){
        return CGSizeMake((KSCREEN_WIDTH-40)/3,120);
    }else{
        return CGSizeMake(0,0);
    }
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (_enumtype == MyEnumValueA) {
        return 2;
    }else if (_enumtype == MyEnumValueB){
        return 3;
    }else{
        return 0;
    }
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (_enumtype == MyEnumValueA) {
        return 5;
    }else if (_enumtype == MyEnumValueB){
        return 4;
    }else{
        return 1;
    }
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
    if (_enumtype == MyEnumValueA) {
        CGSize size={0,0};
        return size;
    }else if (_enumtype == MyEnumValueB){
        CGSize size={KSCREEN_WIDTH,44};
        return size;
    }else{
        CGSize size={0,0};
        return size;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self setup];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
