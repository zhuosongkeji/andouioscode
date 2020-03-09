//
//  ZBNMineFeedbackVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2019/12/28.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "ZBNMineFeedbackVC.h"

@interface ZBNMineFeedbackVC () <UITextViewDelegate>

/*! 意见反馈 */
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@end

@implementation ZBNMineFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"意见反馈";
    // 设置代理对象
    self.contentText.delegate = self;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.contentText.text = nil;
}


- (IBAction)btnClick:(UIButton *)sender {
    
    [self upLoadData];
}



/*! 上传意见的内容 */
- (void)upLoadData
{
    [FKHRequestManager cancleRequestWork];
    if (self.contentText.text.length > 0) {
    // 如果输入了意见
        NSData * data1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"infoData"];
        userInfo * unmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data1];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"uid"] = unmodel.uid;
        params[@"token"] = unmodel.token;
        params[@"content"] = self.contentText.text;
        // 发送网络请求
        [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:@"http://andou.zhuosongkj.com/api/opinion/index" params:params complement:^(ServerResponseInfo * _Nullable serverInfo) {
            if ([serverInfo.response[@"code"] intValue] == 200) {
               [HUDManager showStateHud:@"感谢您宝贵的评价" state:HUDStateTypeSuccess];
            } else {
                [HUDManager showStateHud:@"网络问题" state:HUDStateTypeFail];
            }
        }];
    
    }
}

@end
