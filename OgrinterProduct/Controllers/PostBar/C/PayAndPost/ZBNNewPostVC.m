//
//  ZBNNewPostVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/19.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNNewPostVC.h"
#import "ZBNPostPayVC.h"
#import "PYPhotoBrowser.h"
#import "TZImagePickerController.h"
#import "WMZDialog.h"

@interface ZBNNewPostVC () <TZImagePickerControllerDelegate,PYPhotosViewDelegate>
/*! 图片背景View */
@property (weak, nonatomic) IBOutlet PYPhotosView *photoBackV;
/*! 标题 */
@property (weak, nonatomic) IBOutlet UITextField *titleL;
/*! 内容 */
@property (weak, nonatomic) IBOutlet UITextView *content;
/*! 选择类别 */
@property (weak, nonatomic) IBOutlet UILabel *chooseL;
/*! 电话 */
@property (weak, nonatomic) IBOutlet UILabel *phoneT;
/*! 不置顶 */
@property (weak, nonatomic) IBOutlet UIButton *notDingBtn;
/*! 置顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/*! 存储图片的数组 */
@property (nonatomic, strong) NSMutableArray *photos;
/*! 展示图片背景约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backVH;

@end

@implementation ZBNNewPostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UI设置
    [self setupUI];
    // 添加展示图片的view
    [self setupImageBackV];
    // 设置手势
    [self setupGes];
}


- (void)setupUI
{
    self.navigationItem.title = @"发布";
}


// 添加展示图片的view
- (void)setupImageBackV
{
    PYPhotosView *publishPhotosView = [PYPhotosView photosView];
    publishPhotosView.py_x = 15;
    publishPhotosView.py_y = 15;
    // 2.1 设置本地图片
    publishPhotosView.images = nil;
    // 3. 设置代理
//    publishPhotosView.delegate = self;
    publishPhotosView.photosMaxCol = 5;//每行显示最大图片个数
    publishPhotosView.imagesMaxCountWhenWillCompose = 9;//最多选择图片的个数
    self.photoBackV.delegate = self;
}



#pragma mark - PYPhotosViewDelegate
- (void)photosView:(PYPhotosView *)photosView didAddImageClickedWithImages:(NSMutableArray *)images{
    // 在这里做当点击添加图片按钮时，你想做的事。
    [self getPhotos];
}
// 进入预览图片时调用, 可以在此获得预览控制器，实现对导航栏的自定义
- (void)photosView:(PYPhotosView *)photosView didPreviewImagesWithPreviewControlelr:(PYPhotosPreviewController *)previewControlelr{
    NSLog(@"进入预览图片");
}

- (void)photosView:(PYPhotosView *)photosView didDeleteImageIndex:(NSInteger)imageIndex
{
     if (self.photos.count > 2) {
         self.backVH.constant = 305;
     } else if (self.photos.count > 0){
         self.backVH.constant = 225;
     }
}

//进入相册的方法:
-(void)getPhotos{
    
    ADWeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9-weakSelf.photos.count delegate:self];
    imagePickerVc.maxImagesCount = 9;//最小照片必选张数,默认是0
    imagePickerVc.sortAscendingByModificationDate = NO;// 对照片排序，按修改时间升序，默认是YES。如果设置为NO,最新的照片会显示在最前面，内部的拍照按钮会排在第一个
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        NSLog(@"选中图片photos === %@",photos);
        [weakSelf.photos addObjectsFromArray:photos];
        [weakSelf.photoBackV reloadDataWithImages:weakSelf.photos];
        if (self.photos.count > 2) {
            self.backVH.constant = 305;
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


#pragma mark -- 手势
- (void)setupGes
{
    // 类别选择
    UITapGestureRecognizer *labelGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTypeClick)];
    self.chooseL.userInteractionEnabled = YES;
    [self.chooseL addGestureRecognizer:labelGes];
    // 电话填写
    UITapGestureRecognizer *phoneGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneNumClick)];
    self.phoneT.userInteractionEnabled = YES;
    [self.phoneT addGestureRecognizer:phoneGes];
}


#pragma mark -- 点击事件相关
/*! 发布按钮点击 */
- (IBAction)postBtnClick:(UIButton *)sender
{
    if (self.titleL.text.length < 0) {
        [HUDManager showTextHud:@"请填写标题"];
        return;
    }
    if (self.content.text.length < 10) {
        [HUDManager showTextHud:@"请发布至少十个字的内容"];
        return;
    }
    if (self.phoneT.text.length != 11) {
        [HUDManager showTextHud:@"请输入正确的手机号"];
        return;
    }
    if ([self.chooseL.text isEqualToString:@"选择类型"]) {
        [HUDManager showTextHud:@"请选择发帖类型"];
        return;
    }
    if (self.dingBtn.selected==NO && self.notDingBtn.selected==NO) {
        [HUDManager showTextHud:@"请选择是否置顶"];
        return;
    }
    
    // 发布帖子
    [self postRequest];
    
}
/*! 电话号码点击 */
- (void)phoneNumClick
{
    Dialog().wTypeSet(DialogTypeWrite).wEventOKFinishSet(^(id anyID, id otherData){
        if (anyID) {
            [self.phoneT setText:anyID];
        } else {
            [self.phoneT setText:@"请输入手机号"];
        }
    }).wOKColorSet(KSRGBA(94, 211, 174, 1)).wTitleSet(@"").wMessageSet(@"手机号").wWirteTextMaxLineSet(1).wWirteTextMaxNumSet(13).wLineAlphaSet(0.01).wLineColorSet([UIColor redColor]).wStart();
}

/*! 选择类别点击 */
- (void)chooseTypeClick
{
    Dialog().
    wTypeSet(DialogTypeSheet).
    wDataSet(@[@"招聘信息"]).
    wTitleSet(@"请选择").
    wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type){
        if (anyID) {
            [self.chooseL setText:anyID];
        } else {
            [self.chooseL setText:@"选择类型"];
        }
    }).
    wStart();
}

/*! 不点赞 */
- (IBAction)notDingBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.dingBtn.selected = NO;
    } else {
        sender.selected = YES;
    }
}

/*! 点赞 */
- (IBAction)dingBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.notDingBtn.selected = NO;
    } else {
        sender.selected = YES;
    }
}

#pragma mark -- net

- (void)postRequest
{
    ADWeakSelf;
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"uid"] = unmodel.uid;
        param[@"title"] = self.titleL.text;
        param[@"content"] = self.content.text;
        param[@"type_id"] = @1;
        param[@"contact_info"] = self.phoneT.text;
    if (self.dingBtn.selected) {
        param[@"top_post"] = @1;
    } else {
        param[@"top_post"] = @0;
    }

    [FKHRequestManager uploadFileWithPath:@"http://andou.zhuosongkj.com/index.php/api/tieba/post" filePath:weakSelf.photos parms:param fileType:FileType_Image result:^(ServerResponseInfo * _Nullable serverInfo) {
        if ([serverInfo.response[@"code"] intValue] == 200 && self.dingBtn.selected) {
            dispatch_async(dispatch_get_main_queue(), ^{
            ZBNPostPayVC *vc = [[ZBNPostPayVC alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
            });
        } else if ([serverInfo.response[@"code"] intValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [HUDManager showTextHud:@"发帖成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}

#pragma mark -- lazy

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

@end
