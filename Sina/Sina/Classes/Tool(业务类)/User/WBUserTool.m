//
//  WBUserTool.m
//  Sina
//
//  Created by Chia on 16/3/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBUserTool.h"
#import "WBUserParam.h"
#import "WBUserResult.h"
#import "WBUser.h"
#import "HttpTool.h"
#import "MJExtension.h"

#import "WBAccountTool.h"
#import "WBAccount.h"

@implementation WBUserTool

+(void)unreadCountWithSuccess:(void (^)(WBUserResult *))success failure:(void (^)(NSError *))failure{
    
    //准备请求参数
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    //发送GET请求
    [HttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        //成功时回调
        WBUserResult *reult = [WBUserResult objectWithKeyValues:responseObject];
        if (success) {
            success(reult);
        }
    } failure:^(NSError *error) {
        //失败时回调
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)userInfoWithSuccess:(void (^)(WBUser *))success failure:(void (^)(NSError *))failure{
    //准备请求参数
    WBUserParam *param = [WBUserParam param];
    param.uid = [WBAccountTool account].uid;
    //发送get请求
    [HttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        //
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        //
        if (failure) {
            failure(error);
        }
    }];
}
@end


