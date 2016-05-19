//
//  WBComposeTool.m
//  Sina
//
//  Created by Chia on 16/4/19.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBComposeTool.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "WBComposeParams.h"

#import "AFNetworking.h"
#import "WBUploadParams.h"

@implementation WBComposeTool

+(void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    WBComposeParams *params = [WBComposeParams param];
    
    params.status = status;
    [HttpTool Post:@"https://api.weibo.com/2/statuses/update.json" parameters:params.keyValues success:^(id responseObject) {
        //success
        success();
    } failure:^(NSError *error) {
        //failure
        failure(error);
    }];
}

+(void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    WBComposeParams *params = [WBComposeParams param];
    params.status =status;
    WBUploadParams *uploadP = [[WBUploadParams alloc] init];
    uploadP.data =UIImagePNGRepresentation(image);
    uploadP.name = @"pic";
    uploadP.fileName = @"image.png";
    uploadP.mimeType = @"image/png";
    //here
    [HttpTool UpLoad:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params.keyValues uploadParams:uploadP success:^{
        //
        success();
    } failure:^(NSError *error) {
        //
        failure(error);
    }];
 
}

@end
