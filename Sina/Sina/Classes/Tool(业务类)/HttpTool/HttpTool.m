//
//  HttpTool.m
//  Sina
//
//  Created by Chia on 16/3/22.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "WBUploadParams.h"


@implementation HttpTool

+(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(id))success
   failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //GET请求成功后调用
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //GET请求失败后调用
        if (failure) {
            failure(error);
        }
    }];
}

+(void)Post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))succes failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //POST请求成功后调用
        if (succes) {
            succes(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //GET请求失败后调用
        if (failure) {
            failure(error);
        }
    }];
}

+(void)UpLoad:(NSString *)URLString parameters:(id)parameters uploadParams:(WBUploadParams *)uploadParams success:(void (^)())success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:uploadParams.data name:uploadParams.name fileName:uploadParams.fileName mimeType:uploadParams.mimeType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            
            failure(error);
        }
    }];
}

@end
