//
//  WBStatusTool.m
//  Sina
//
//  Created by Chia on 16/3/22.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBStatusTool.h"
#import "AFNetworking.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "HttpTool.h"
#import "WBStatus.h"

#import "MJExtension.h"
#import "WBStatusParam.h"
#import "WBStatusResult.h"
#import "WBStatusCacheTool.h"

@implementation WBStatusTool

+(void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *))success failure:(void(^)(NSError *))failure{
    //创建一个请求参数对象并为参数传值
    WBStatusParam *params = [[WBStatusParam alloc] init];
    params.access_token=[WBAccountTool account].access_token;
    if (sinceId) {
        
        params.since_id = sinceId;
    }
    //load from db
    NSArray * statuses = [WBStatusCacheTool statusesWithParam:params];
    if (statuses.count) {
        if (success) {
            //返回结果中的WBStatus模型数组
            success(statuses);
        }
    }
    
    [HttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {//httptool请求成功后调用
        
        //将取出的字典数据（带有WBStatus模型数组）转换成WBStatusResult模型
        WBStatusResult * result = [WBStatusResult objectWithKeyValues:responseObject];
        if (success) {
            //返回结果中的WBStatus模型数组
            success(result.statuses);
        }
        //save to db
        [WBStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
    } failure:^(NSError *error) {
        //
    }];
}

+(void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    //创建一个请求参数对象并为参数传值
    WBStatusParam *params = [[WBStatusParam alloc] init];
    params.access_token = [WBAccountTool account].access_token;
    if (maxId) {
        params.max_id = maxId;
    }
    //load from db
    NSArray * statuses = [WBStatusCacheTool statusesWithParam:params];
    if (statuses.count) {
        if (success) {
            //返回结果中的WBStatus模型数组
            success(statuses);
        }
    }
    //httpTool请求
    [HttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        
        //获得返回数据
        WBStatusResult * result = [WBStatusResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
        [WBStatusCacheTool saveWithStatuses:responseObject[@"statuses"]];
    } failure:^(NSError *error) {
        //
        if (failure) {
            failure(error);
        }
    }];
}

@end
