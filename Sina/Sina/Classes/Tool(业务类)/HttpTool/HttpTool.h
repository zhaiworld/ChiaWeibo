//
//  HttpTool.h
//  Sina
//
//  Created by Chia on 16/3/22.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBUploadParams;
@interface HttpTool : NSObject

+(void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;


+(void)Post:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))succes
    failure:(void (^)(NSError *error))failure;

+(void)UpLoad:(NSString *)URLString
   parameters:(id)parameters
 uploadParams:(WBUploadParams *)uploadParams
      success:(void(^)())success
      failure:(void (^)(NSError *error))failure;
@end

