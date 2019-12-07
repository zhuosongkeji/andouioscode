//
//  SearchResrultViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/5.
//  Copyright © 2019 RXF. All rights reserved.
//


#import "SearchResrultViewController.h"
#import "WSLWaterFlowLayout.h"
#import "ShopCollectionViewCell.h"
#import "HXCollectionViewCell.h"
#import "MsgViewCell.h"
#import "MsgModel.h"


@interface SearchResrultViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,WSLWaterFlowLayoutDelegate>


@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,weak)UITableView *mTableView;

@property (nonatomic,weak) UICollectionView *mCollectionView;

@end


@implementation SearchResrultViewController


//MARK:-
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    if (!_searchBar.becomeFirstResponder)
        [_searchBar becomeFirstResponder];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_searchBar resignFirstResponder];
}

#pragma mark - shops
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}


//MARK:- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    
    [self setBarButtonItem];
    
    if (self.type == SearchTableViewList) {
        [self createmTableView];
    }else if (self.type == SearchCollectionViewtypeOne || self.type == SearchCollectionViewtypeTwo){
        [self createmConnection:self.type];
    }else if (self.type == searchOtherResult){
        
    }else{}
    // Do any additional setup after loading the view from its nib.
}


//MARK:- collecttion
-(UICollectionView *)createmConnection:(SearchResultType)type {
    
    WSLWaterFlowLayout *layout = [[WSLWaterFlowLayout alloc]init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = KSRGBA(255, 255, 255, 1);
    
    if (type == SearchCollectionViewtypeOne) {
        [collectionView registerNib:[UINib nibWithNibName:@"ShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ShopCollectionViewCell"];
        
    }else if (type == SearchCollectionViewtypeTwo){
        
        [collectionView registerNib:[UINib nibWithNibName:@"HXCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HXCollectionViewCell"];
        
    }else{}
    
    [self.view addSubview:self.mCollectionView = collectionView];
    
    return collectionView;
}


//MARK:- 加载tableView
-(UITableView *)createmTableView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerNib:[UINib nibWithNibName:@"MsgViewCell" bundle:nil] forCellReuseIdentifier:@"MsgViewCell"];
    tableView.tableFooterView = [UILabel new];
    [self.view addSubview:self.mTableView = tableView];
    
    return self.mTableView;
}


//MARK:-create SearchBar
- (void)setBarButtonItem {
    
    [self.navigationItem setHidesBackButton:YES];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, KSCREEN_WIDTH, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
    searchBar.placeholder = searchplaceholder;
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]]
     setDefaultTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]}];
    
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    searchBar.tintColor = [UIColor lightGrayColor];
    
    for (UIView *v in [[searchBar.subviews objectAtIndex:0] subviews]) {
        if ([v isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton *cancel = (UIButton *)v;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:13];
        }
    }
    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
}


//MARK:-collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArr count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == SearchCollectionViewtypeOne) {
        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCollectionViewCell" forIndexPath:indexPath];
        //    cell.shop = self.shops[indexPath.item];
        return cell;
    }else if (self.type == SearchCollectionViewtypeTwo){
        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        //    cell.shop = self.shops[indexPath.item];
        return cell;
    }else{
//        ShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HXCollectionViewCell" forIndexPath:indexPath];
        //    cell.shop = self.shops[indexPath.item];
        return nil;
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


//MARK:- mTableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MsgViewCell"];
    if (!cell) {
        NSLog(@"创建");
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消Cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}



//MARK:-WSLWaterFlowLayout
- (CGSize)waterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == SearchCollectionViewtypeOne) {
        return CGSizeMake((KSCREEN_WIDTH-30)/2,234);
    }else if (self.type == SearchCollectionViewtypeTwo){
        return CGSizeMake((KSCREEN_WIDTH-40)/3,120);
    }else{
        return CGSizeMake(0,0);
    }
}

-(CGFloat)columnCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (self.type == SearchCollectionViewtypeOne) {
        return 2;
    }else if (self.type == SearchCollectionViewtypeTwo){
        return 4;
    }else{
        return 0;
    }
}

/** 行数*/
-(CGFloat)rowCountInWaterFlowLayout:(WSLWaterFlowLayout *)waterFlowLayout{
    if (self.type == SearchCollectionViewtypeOne) {
        if ([self.dataArr count]%2 == 0)
            return [self.dataArr count]/2;
        else
            return [self.dataArr count]/2+1;
    }else if (self.type == SearchCollectionViewtypeTwo){
        if ([self.dataArr count]%4 == 0)
            return [self.dataArr count]/4;
        else
            return [self.dataArr count]/4+1;
    }else{
        return 0;
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


//MARK:- UISearchBar
#pragma mark - search
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"SearchButton");
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.dataArr removeAllObjects];
    //    NSDictionary *defaut = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    
    NSString *urlStr = @"12331";
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        if (searchText!=nil && searchText.length>0) {
            [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_GET pathUrl:urlStr params:nil complement:^(ServerResponseInfo * _Nullable serverInfo) {
                if ([[serverInfo.response objectForKey:@"code"] integerValue] == 0) {
//                    NSArray *dataArr = [[serverInfo.response objectForKey:@"data"] objectForKey:@"list"];
                    NSArray *dataArr = nil;
                    for (int i = 0;i < [dataArr count]; i ++ ) {
//                        WorkModel *model = [[WorkModel alloc]initWithDict:dataArr[i]];
//                        NSString *pinyin = [NSString  transformToPinyin:model.title];
//                        if ([pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch].length > 0 ) {
////                            [self.dataArr addObject:model];
//                        }//回到主线程
                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.mTableView reloadData];
                        });
                    }
                    
                }
            }];
        }
    });
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
