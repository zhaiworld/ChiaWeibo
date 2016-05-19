//
//  WBAccountTool.m
//  Sina
//
//  Created by Chia on 16/3/16.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBAccountTool.h"
#import "WBAccount.h"
#import "WBRootTool.h"
#import "HttpTool.h"
#import "WBAccountParam.h"
#import "MJExtension.h"

#define CZAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define CZClient_id     @"2389394849"
#define CZRedirect_uri  @"http://www.baidu.com"
#define CZClient_secret @"03729d16a4cd277c7da26398f7a01282"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation WBAccountTool

+(void)accountWithCode:(NSString *)code access:(void (^)())access failure:(void (^)(NSError *error))failure{
    
    //准备请求参数
    WBAccountParam *param = [[WBAccountParam alloc] init];
    param.client_id = CZClient_id;
    param.client_secret = CZClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = CZRedirect_uri;
    
    //发送Post请求
    [HttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {//请求成功时调用
        
        //字典转模型
        WBAccount *account = [WBAccount accountWithDict:responseObject];
        //保存用户账号信息
        [WBAccountTool saveAccount:account];
        if (access) {
            access();
        }
    } failure:^(NSError *error) {
        //请求失败时调用
        if (failure){
            failure(error);
        }
    }];
}
//类方法一般用静态变量来代替成员变量
static WBAccount * _account;
//存储账号信息
+(void)saveAccount:(WBAccount *)account{
    
    [NSKeyedArchiver archiveRootObject:account toFile:CZAccountFileName];
    
}
//读取账号信息
+(WBAccount *)account{
    
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];
        
        //获取账号信息后判断当前账号是否过期，如果过期返回nil
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {//过期
            return nil;
        }
    }
    return _account;
}
@end




