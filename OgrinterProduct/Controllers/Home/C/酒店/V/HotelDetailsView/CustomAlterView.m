//
//  CustomAlterView.m
//  OgrinterProduct
//
//  Created by wongshine on 2019/12/10.
//  Copyright © 2019 RXF. All rights reserved.
//

#import "CustomAlterView.h"
#import <WebKit/WebKit.h>


@interface CustomAlterView ()<WKUIDelegate,WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIView *webViewbjView;
@property (nonatomic,strong)WKWebView *webView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (nonatomic,strong)UILabel *title;

@property(nonatomic,strong)UILabel *point;

@end

@implementation CustomAlterView


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
        
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.webViewbjView.frame), CGRectGetHeight(self.webViewbjView.frame)) configuration:wkWebConfig];
        
        _webView.UIDelegate = self;
        
    }
    
    return _webView;
}


-(void)setHtlStr:(NSString *)htlStr{
    _htlStr = htlStr;
    
    [self.webViewbjView addSubview:self.webView];
    [self.webView loadHTMLString:htlStr baseURL:nil];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}


-(void)setup{
    self.cancelBtn.layer.cornerRadius = 4;
    self.agreeBtn.layer.cornerRadius = 4;
}


//MARK:-WKWebView
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    //禁止用户选择
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
    // 适当增大字体大小
    [webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '105%'" completionHandler:nil];
    
}


- (IBAction)click:(UIButton *)sender {
    KPreventRepeatClickTime(1)
    _btnBlcok(sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
