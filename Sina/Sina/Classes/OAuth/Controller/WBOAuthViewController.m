//
//  WBOAuthViewController.m
//  Sina
//
//  Created by Chia on 16/3/14.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBRootTool.h"

#define CZAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define CZClient_id     @"2389394849"
#define CZRedirect_uri  @"http://www.baidu.com"
#define CZClient_secret @"03729d16a4cd277c7da26398f7a01282"



@interface WBOAuthViewController ()<UIWebViewDelegate>

@end

@implementation WBOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:webView];
    
    //加载网页
    
    // 一个完整的URL:基本URL + 参数
    // https://api.weibo.com/oauth2/authorize?client_id=&redirect_uri=

    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"2389394849";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    //拼接URL
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
//    NSString *urlStr = @"www.baidu.com";
    //创建URL
    NSURL *url = [NSURL URLWithString:urlStr];
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载请求
    [webView loadRequest:request];
    
    webView.delegate = self;
    

}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];

}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {//说明有code=
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        //换取accessToken
        [self accessTokenWithCode:code];
        return  NO;
    }
    
    return YES;
}

#pragma mark - 换取accessToken
-(void)accessTokenWithCode:(NSString*)code{
    
    [WBAccountTool accountWithCode:code access:^{
        
        //进入主页或新特性，选择根控制器
        [WBRootTool chooseRootViewController:WBKeyWindow];
    } failure:^(NSError *error) {
        //
    }];
    
}


@end
