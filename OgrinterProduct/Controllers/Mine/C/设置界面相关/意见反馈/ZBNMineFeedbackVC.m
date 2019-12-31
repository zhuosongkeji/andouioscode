//
//  ZBNMineFeedbackVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineFeedbackVC.h"

#import "ZBNEntryFooterView.h"

@interface ZBNMineFeedbackVC () <UITextViewDelegate>

@property (nonatomic, weak) ZBNEntryFooterView *footerV;
/*! 意见反馈 */
@property (weak, nonatomic) IBOutlet UITextView *contentText;



@end

@implementation ZBNMineFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"意见反馈";
    // 设置底部按钮
    [self setupFooterView];
    // 设置代理对象
    self.contentText.delegate = self;
}


- (void)setupFooterView
{
    ZBNEntryFooterView *footerV = [ZBNEntryFooterView viewFromXib];
    footerV.height = 150;
    footerV.width = self.view.width;
    footerV.x = 0;
    footerV.y = KSCREEN_HEIGHT * 0.9;
    footerV.setButtonText(@"确认提交");
    // 点击按钮进行意见上传
    
    
    
    footerV.middleBtnClickTask = ^{
                // 上传数据
            
        if (self.contentText.text.length > 0) {
            [self upLoadData];
        } else {
            [HUDManager showTextHud:@"请输入意见"];
        }
                
    };
    
    
    
        
    [self.view addSubview:footerV];
    self.footerV = footerV;
}


/*! 上传意见的内容 */
- (void)upLoadData
{
    
    
    
    NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
    userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = unmodel.uid;
    params[@"token"] = unmodel.token;
    params[@"content"] = self.contentText.text;
    
    // 发送网络请求
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/opinion/index" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
        
        if (serverInfo.httpCode == 200) {
           [HUDManager showStateHud:@"感谢您宝贵的评价" state:HUDStateTypeSuccess];
        } else {
            [HUDManager showStateHud:@"网络问题" state:HUDStateTypeFail];
        }
//        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

@end
