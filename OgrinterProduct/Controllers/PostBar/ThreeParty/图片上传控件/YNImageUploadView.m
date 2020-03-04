//
//  YNImageUploadView.m
//  上传图片控件
//
//  Created by 贾亚宁 on 2019/5/16.
//  Copyright © 2019 贾亚宁. All rights reserved.
//

#import "YNImageUploadView.h"

@interface YNImageUploadViewConfig ()
/** 展示图片的类型 */
@property (nonatomic, assign) YNImageUploadImageType type;
/** 图片数组 */
@property (nonatomic, strong) NSArray *contents;
@end

@implementation YNImageUploadViewConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化数据
        self.rowCount = 4;
        self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.lineSpace = 10;
        self.columnsSpace = 10;
        self.autoHeight = NO;
        self.scale = 1.f;
        self.photoCount = 9;
        self.isNeedUpload = NO;
        self.addImage = [UIImage imageNamed:@"add_image_white"];
        self.style = YNImageUploadAnimationStyleNormal;
        self.type = YNImageUploadImageTypeUpload;
    }
    return self;
}

- (void)setUploadViewShowImageWithType:(YNImageUploadImageType)type contents:(NSArray *)contents {
    self.type = type;
    // 空数据处理
    if (contents.count == 0) return;
    // 处理数据源
    self.contents = contents;
}

@end

#import "YNImageUploadViewCollCell.h"
#import "TZImagePickerController.h"
#import "Masonry.h"
#import <AFNetworking.h>

@interface YNImageUploadView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,AFMultipartFormData>
/** 视图的配置文件 */
@property (nonatomic, strong) YNImageUploadViewConfig *config;
/** 视图的高度 */
@property (nonatomic, assign) CGFloat viewHeight;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataList;
/** item的size */
@property (nonatomic, assign) CGSize itemSize;
/** 上传图片工具 */
@property (nonatomic, strong) YNImageTool *tool;
/** 盛放cell */
@property (nonatomic, strong) NSMutableArray *cellInfos;
@end

@implementation YNImageUploadView

/** 构造方法 */
- (instancetype)initWithConfig:(void(^)(YNImageUploadViewConfig *config))config {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.tool = [[YNImageTool alloc] init];
        _config = [[YNImageUploadViewConfig alloc] init];
        config(_config);
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%ld-%ld-Cell-%u",indexPath.section, indexPath.row, arc4random_uniform(3243274)];
    [self registerClass:[YNImageUploadViewCollCell class] forCellWithReuseIdentifier:reuseIdentifier];
    YNImageUploadViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.isNeedUpload = self.config.isNeedUpload;
    cell.uploadUrl = self.config.uploadUrl;
    cell.parameter = self.config.parameter;
    cell.model = self.dataList[indexPath.row];
    cell.tool = self.tool;
    __weak typeof(self)weakSelf = self;
    cell.deleteBtnTapBlock = ^(YNImageUploadViewCollCell * _Nonnull deleCell) {
        NSIndexPath *deleteIndex = [weakSelf indexPathForCell:deleCell];
        [weakSelf deleteItemAtIndexPath:deleteIndex];
    };
    return cell;
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath {
    YNImageModel *model = (YNImageModel *)[self.dataList objectAtIndex:indexPath.row];
    if (model.state == YNImageUploadStateUploading) {
        [model.task cancel];
    }
    [self.dataList removeObjectAtIndex:indexPath.row];
    [self deleteItemsAtIndexPaths:@[indexPath]];
    YNImageModel *lastModel = (YNImageModel *)[self.dataList lastObject];
    if (!lastModel.isLast) {
        NSIndexPath *insertIndex = [NSIndexPath indexPathForRow:self.dataList.count inSection:0];
        [self.dataList addObject:[self lastImageModel]];
        [self insertItemsAtIndexPaths:@[insertIndex]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.rowCount == 0) return CGSizeZero;
    CGFloat numSpace = self.config.insets.left + self.config.insets.right + self.config.columnsSpace *(self.config.rowCount-1);
    CGFloat itemW = (CGRectGetWidth(self.frame) - numSpace) / self.config.rowCount;
    CGFloat itemH = itemW * self.config.scale;
    self.itemSize = CGSizeMake(itemW, itemH);
    return self.itemSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.config.insets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.config.lineSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.config.columnsSpace;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YNImageModel *model = (YNImageModel *)[self.dataList objectAtIndex:indexPath.row];
    UIViewController *viewController = [self getViewController];
    if (model.isLast) {
        NSMutableArray <PHAsset *>*marray = @[].mutableCopy;
        for (YNImageModel *model in self.dataList) {
            if (!model.isLast) {
                [marray addObject:model.asset];
            }
        }
        __weak typeof(self)weakSelf = self;
        TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:self.config.photoCount delegate:nil];
        imagePicker.selectedAssets = marray;
        [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            NSMutableArray *marray = @[].mutableCopy;
            for (int i = 0; i < photos.count; i ++) {
                YNImageModel *model = [[YNImageModel alloc] init];
                model.image = [photos objectAtIndex:i];
                model.asset = [assets objectAtIndex:i];
                model.imageType = YNImageUploadImageTypeUpload;
                model.state = YNImageUploadStateNormal;
                model.imageName = [NSString stringWithFormat:@"%@%u.png",[self uuidString],arc4random_uniform(255)];
                [model.array addObject:model.image];
                [marray addObject:model];
            }
            [weakSelf filtrationDatasWithArray:marray];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseImgOk" object:nil];
        }];
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }else {
        if (model.imageType == YNImageUploadImageTypeUpload) {
            // 重新加载&预览
            if (model.state == YNImageUploadStateFailed) {
                __weak typeof(self)weakSelf = self;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                [alert addAction:[UIAlertAction actionWithTitle:@"重新上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf reUploadImageWithIndexPath:indexPath];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"预览" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf previewImageWithIndexPath:indexPath];
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [viewController presentViewController:alert animated:YES completion:nil];
            }
            // 预览
            else {
                [self previewImageWithIndexPath:indexPath];
            }
        }else {
            [self previewImageWithIndexPath:indexPath];
        }
    }
}

- (void)previewImageWithIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)reUploadImageWithIndexPath:(NSIndexPath *)indexPath {
    YNImageModel *model = (YNImageModel *)[self.dataList objectAtIndex:indexPath.row];
    model.state = YNImageUploadStateNormal;
    __weak typeof(self)weakSelf = self;
    [UIView performWithoutAnimation:^{
        [weakSelf reloadItemsAtIndexPaths:@[indexPath]];
    }];
}

- (NSString *)uuidString {
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

- (UIViewController *)getViewController {
    UIViewController *topController = nil;
    UIView *frontView = [[[UIApplication sharedApplication].delegate.window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:UIViewController.class]) {
        topController = nextResponder;
    } else {
        topController = [UIApplication sharedApplication].delegate.window.rootViewController;
        while (topController.presentedViewController) {
            topController = topController.presentedViewController;
        }
    }
    return topController;
}

- (void)filtrationDatasWithArray:(NSArray *)array {
    // 1、相同数据
    NSMutableArray *sameArray = @[].mutableCopy;
    // 2、不相同存在新数组中的数据, 需要插入的数据
    NSMutableArray *insetArray = [NSMutableArray arrayWithArray:array];
    // 3、不相同存在旧数组中的数据, 需要删除的数据
    NSMutableArray *deleArray = [NSMutableArray arrayWithArray:self.dataList];
    // 4、遍历两个数组，获取两个数组中的相同数据并存入sameArray中
    for (YNImageModel *oldModel in self.dataList) {
        for (YNImageModel *newModel in array) {
            if ([oldModel.asset.localIdentifier isEqualToString:newModel.asset.localIdentifier]) {
                [sameArray addObject:oldModel];
            }
        }
    }
    // 5、遍历相同的数组，分别把需要删除和需要添加数组中相同不分删除掉，获得两个新数组，insetArray 和 deleArray
    for (YNImageModel *model in sameArray) {
        [deleArray removeObject:model];
        for (YNImageModel *newModel in array) {
            if ([model.asset.localIdentifier isEqualToString:newModel.asset.localIdentifier]) {
                [insetArray removeObject:newModel];
            }
        }
    }
    // 6、取消正在上传的任务
    for (YNImageModel *deleModel in deleArray) {
        if (deleModel.state == YNImageUploadStateUploading) {
            [deleModel.task cancel];
        }
    }
    // 7、根据存储的成功的模型来校验需要插入的模型是否需要重新上传
    for (YNImageModel *newModel in insetArray) {
        for (YNImageModel *saveModel in self.tool.imageModels) {
            if ([newModel.asset.localIdentifier isEqualToString:saveModel.asset.localIdentifier]) {
                newModel.state = saveModel.state;
            }
        }
    }
    // 8、根据需要删除的数组得到需要删除的cell的indexPath数组
    NSMutableArray <NSIndexPath *>*indexPaths = @[].mutableCopy;
    for (YNImageModel *model in deleArray) {
        if (!model.isLast) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.dataList indexOfObject:model] inSection:0];
            [indexPaths addObject:indexPath];
        }
    }
    // 9、处理数据源，将需要删除的数据从原数组中删除
    for (YNImageModel *oldModel in deleArray) {
        if (!oldModel.isLast) {
            [self.dataList removeObject:oldModel];
        }
    }
    // 10、判断需要删除的indexPaths是否为空，为空则不执行删除cell的操作
    if (indexPaths.count > 0) {
        [self deleteItemsAtIndexPaths:indexPaths];
    }
    // 11、数组重复利用，清空数据并根据需要插入的数据数组获得需要插入cell的indexPaths数组
    [indexPaths removeAllObjects];
    
    // 12、判断是否达到最大数
    BOOL isMax = NO;
    if (self.dataList.count + insetArray.count - 1 == self.config.photoCount) {
        isMax = YES;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataList.count-1 inSection:0];
        [self.dataList removeLastObject];
        [self deleteItemsAtIndexPaths:@[indexPath]];
    }
    for (int i = 0; i < insetArray.count; i ++) {
        if (isMax) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:self.dataList.count+i inSection:0]];
        }else {
            [indexPaths addObject:[NSIndexPath indexPathForRow:(self.dataList.count-1)+i inSection:0]];
        }
    }
    // 13、将需要插入的数据，添加到数据源中
    for (YNImageModel *model in insetArray) {
        if (isMax) {
            [self.dataList insertObject:model atIndex:self.dataList.count];
        }else {
            [self.dataList insertObject:model atIndex:self.dataList.count-1];
        }
    }
    // 14、判断需要删除的indexPaths是否为空，为空则不执行删除cell的操作
    if (indexPaths.count > 0) {
        [self insertItemsAtIndexPaths:indexPaths];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 12、如果是自动设置高度，则根据数组长度判断
    if (self.config.isAutoHeight) {
        self.viewHeight = self.config.insets.top + self.config.insets.bottom;
        if (self.dataList.count-1 != self.config.photoCount) {
            [self calculateheightWithArray:self.dataList];
        }else {
            NSMutableArray *marray = [NSMutableArray arrayWithArray:self.dataList];
            [marray removeLastObject];
            [self calculateheightWithArray:marray];
        }
    }
}

- (void)calculateheightWithArray:(NSArray *)array {
    if (array.count % self.config.rowCount == 0) {
        self.viewHeight += (self.itemSize.height*(array.count/self.config.rowCount) + self.config.columnsSpace*(array.count/self.config.rowCount-1));
    }else {
        self.viewHeight += (self.itemSize.height*(array.count/self.config.rowCount+1) + self.config.columnsSpace*(array.count/self.config.rowCount));
    }
    __weak typeof(self)weakSelf = self;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(weakSelf.viewHeight));
    }];
}

#pragma  - mark 懒加载
- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = @[].mutableCopy;
        if (self.config.type == YNImageUploadImageTypeUpload) {
            [_dataList addObject:[self lastImageModel]];
        }else {
            for (int i = 0; i < self.config.contents.count; i ++) {
                YNImageModel *model = [[YNImageModel alloc] init];
                model.imageType = self.config.type;
                model.imageName = [NSString stringWithFormat:@"%@%u.jpg",[self uuidString],arc4random_uniform(255)];
                if (self.config.type == YNImageUploadImageTypeImage) {
                    model.image = (UIImage *)[self.config.contents objectAtIndex:i];
                }else if (self.config.type == YNImageUploadImageTypeImageUrl) {
                    model.imageUrl = (NSString *)[self.config.contents objectAtIndex:i];
                }else {
                    model.imageName = (NSString *)[self.config.contents objectAtIndex:i];
                }
                [_dataList addObject:model];
            }
        }
    }
    return _dataList;
}

- (BOOL)isFinish {
    for (YNImageModel *model in self.dataList) {
        if (model.state != YNImageUploadStateFinish) {
            return NO;
        }
    }
    return YES;
}

- (NSMutableArray *)cellInfos {
    if (!_cellInfos) {
        _cellInfos = @[].mutableCopy;
    }
    return _cellInfos;
}

- (YNImageModel *)lastImageModel {
    YNImageModel *model = [[YNImageModel alloc] init];
    model.last = YES;
    model.image = self.config.addImage;
    model.imageName = @"add";
    model.imageType = YNImageUploadImageTypeUpload;
    return model;
}

- (NSArray<UIImage *> *)images {
    NSMutableArray <UIImage *>*marray = @[].mutableCopy;
    
    if (self.dataList.count > 1) {
        for (YNImageModel *model in self.dataList) {
            [marray addObject:model.image];
            NSLog(@"%@----+++---",model.image);
        }
        [marray removeLastObject];
    }
    return marray;
}

- (NSMutableArray *)dataArr
{
    NSMutableArray <NSString *>*marray = @[].mutableCopy;
       if (self.dataList.count > 1) {
           for (YNImageModel *model in self.dataList) {
               [marray addObjectsFromArray:model.array];
           }
           [marray removeLastObject];
       }
       return marray;
}


- (NSArray<NSString *> *)imageNames {
    NSMutableArray <NSString *>*marray = @[].mutableCopy;
    if (self.dataList.count > 1) {
        for (YNImageModel *model in self.dataList) {
            [marray addObject:model.imageName];
        }
        [marray removeLastObject];
    }
    return marray;
}

- (NSString *)imageNameString {
    NSString *string = @"";
    if (self.dataList.count > 1) {
        NSMutableArray *marray = [NSMutableArray arrayWithArray:self.dataList];
        [marray removeLastObject];
        for (YNImageModel *model in marray) {
            string = [string stringByAppendingString:model.imageName];
            string = [string stringByAppendingString:@","];
        }
        string = [string substringWithRange:NSMakeRange(0, string.length-1)];
    }
    return string;
}
    
/*! 服务器返回的地址 */
- (NSString *)returnURL
{
    NSString *returnURL = @"";
    if (self.dataList.count > 1) {
        NSMutableArray *marray = [NSMutableArray arrayWithArray:self.dataList];
        [marray removeLastObject];
        for (YNImageModel *model in marray) {
            returnURL = [returnURL stringByAppendingString:model.returnURL];
            returnURL = [returnURL stringByAppendingString:@","];
        }
        returnURL = [returnURL substringWithRange:NSMakeRange(0, returnURL.length - 1)];
        return returnURL;
    }  else {
        NSString *returnStr = [[NSString alloc] init];
        for (YNImageModel *model in self.dataList) {
            returnStr = model.returnURL;
        }
        return returnStr;
    }
}

@end
