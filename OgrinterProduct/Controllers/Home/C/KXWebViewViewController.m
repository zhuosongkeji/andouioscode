//
//  KXWebViewViewController.m
//  OgrinterProduct
//
//  Created by wongshine on 2020/1/7.
//  Copyright © 2020 RXF. All rights reserved.
//

#import "KXWebViewViewController.h"
#import <WebKit/WebKit.h>


@interface KXWebViewViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong)WKWebView *webView;

@end

@implementation KXWebViewViewController


-(WKWebView *)webView {
    if (!_webView) {
        
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        
        wkWebConfig.userContentController = wkUController;
        
        //自适应屏幕的宽度js
        
        NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        //添加js调用
        
        [wkUController addUserScript:wkUserScript];
        
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT) configuration:wkWebConfig];
        
        NSString *urlStr = [NSString stringWithFormat:@"https://%@",self.kxurl];
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        
        [_webView loadRequest:request];
        
        _webView.UIDelegate = self;
    }
    
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view from its nib.
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //禁止用户选择
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
    // 适当增大字体大小
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '105%'" completionHandler:nil];
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
