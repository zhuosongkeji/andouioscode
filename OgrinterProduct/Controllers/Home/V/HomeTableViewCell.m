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

@interface HomeTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView1;


@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
    // Initialization code
}


-(void)setup {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    layout.itemSize = CGSizeMake(88,108);
    
    self.mCollectionView1.delegate = self;
    self.mCollectionView1.dataSource = self;
    [self.mCollectionView1 setCollectionViewLayout:layout];
    [self.mCollectionView1 registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
    
}


-(void)setListmodel:(HomeCellModel *)listmodel {
    _listmodel = listmodel;
}


+ (instancetype)tempTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.section ) {
        case 0:
        case 1:
            
            identifier = @"HomeTableViewCellOne";
            index = 0;
            break;
            
        case 2:
            
            identifier = @"HomeTableViewCellTwo";
            index = 1;
            break;
            
        default:
            break;
    }
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil] objectAtIndex:index];
        NSLog(@"创建");
    }
    
    return cell;
}


- (void)configTempCellWith:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            
            break;
        }
        case 1: {
            
            break;
        }
        case 2: {
            
            break;
        }
            
        case 3: {
            
            
            break;
        }
            
        default:
            break;
    }
}


//MARK: - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
