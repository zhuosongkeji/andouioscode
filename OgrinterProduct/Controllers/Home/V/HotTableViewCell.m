//
//  HotTableViewCell.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/11/29.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "HotTableViewCell.h"
#import "HotCollectionViewCell.h"

@interface HotTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation HotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+(instancetype)createKKLocalHotCityTableViewCellWithTableView:(UITableView*)tableView indexPath:(NSIndexPath *)indexPath{
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotTableViewCell"];
    
    if (!cell) {
        cell = [[HotTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HotTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell initViews:tableView indexPath:indexPath];
    }
    
    return cell;
}


-(void)initViews:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    NSString *title = nil;
        
    if (indexPath.row == 0) {
        title = @"定位城市";
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 42, 12, 16)];
        imgView.image = [UIImage imageNamed:@"地址"];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(40, 42, KSCREEN_WIDTH, 21)];
        title.text = @"重庆";
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = [UIColor lightGrayColor];
        
        [self addSubview:imgView];
        [self addSubview:title];
        
    }else{
        
        title = @"热门城市";
        
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        
        layout.minimumLineSpacing = 6;
        layout.minimumInteritemSpacing = 6;
        layout.itemSize = CGSizeMake((self.contentView.frame.size.width-24)/3.0, 30);
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 40, KSCREEN_WIDTH-40, 90) collectionViewLayout:layout];
        [_collectionView registerClass:[HotCollectionViewCell class] forCellWithReuseIdentifier:@"HotCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_collectionView];
    }
    
    self.titleLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KSCREEN_WIDTH-20, 40)];
    _titleLb.text = title;
    _titleLb.font = [UIFont systemFontOfSize:14];
    _titleLb.textColor = [UIColor lightGrayColor];

    [self addSubview:_titleLb];
    
}


//MARK: - delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _hotCityArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotCollectionViewCell" forIndexPath:indexPath];
    
    cell.name = _hotCityArr[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_HotCityClickBlock) {
        _HotCityClickBlock(_hotCityArr[indexPath.row]);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
