//
//  ZBNProtocolVC.m
//  OgrinterProduct
//
//  Created by 周芳圆 on 2020/2/12.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "ZBNProtocolVC.h"
#import <WebKit/WebKit.h>


@interface ZBNProtocolVC () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *webBackView;
@property (nonatomic, copy) NSString *htmlStr;
@property (nonatomic, weak) WKWebView *webV;
@end

@implementation ZBNProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)setupUI
{
    WKWebView *webV = [[WKWebView alloc] init];
    webV.frame = CGRectMake(0, 0, self.webBackView.width - 40, self.webBackView.height + 100);
    [self.webBackView addSubview:webV];
    self.webV = webV;
}


/*! 取消 */
- (IBAction)cancelBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*! 同意 */
- (IBAction)agreeBtnClick:(UIButton *)sender {
    if (self.agreeBtnClickTask) {
        self.agreeBtnClickTask();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)loadData
{
    [FKHRequestManager cancleRequestWork];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @"1";
    ADWeakSelf;
    
    UIFont *font = [UIFont systemFontOfSize:40];
    
    [FKHRequestManager sendJSONRequestWithMethod:RequestMethod_POST pathUrl:ZBNTreatyURL params:param complement:^(ServerResponseInfo * _Nullable serverInfo) {

        
        weakSelf.htmlStr = [serverInfo.response[@"data"] objectForKey:@"content"];
//        NSString *htmlString = [NSString stringWithFormat:@"<font face='%@' >%@", font.fontName,weakSelf.htmlStr];
        
        NSString* htmlString = [NSString stringWithFormat:@"<span><span style=\"font-family: %@!important; font-size: %i\">%@</span></span>",
        font.fontName,
        (int) font.pointSize,
        self.htmlStr];

        [weakSelf.webV loadHTMLString:htmlString baseURL:nil];
        
       }];
}

@end
