//
//  WBComposeTool.h
//  Sina
//
//  Created by Chia on 16/4/19.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBComposeTool : NSObject

+(void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

+(void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSError *error))failure;


@end
