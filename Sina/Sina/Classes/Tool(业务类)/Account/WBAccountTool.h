//
//  WBAccountTool.h
//  Sina
//
//  Created by Chia on 16/3/16.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBAccount;
@interface WBAccountTool : NSObject

+(void)saveAccount:(WBAccount *)account;

+(WBAccount *)account;

+(void)accountWithCode:(NSString*)code access:(void(^)())access failure:(void(^)(NSError *error))failure;

//+(void)accountWithCodes:(NSString*)code access:(void(^)())access failure:(void(^)(NSError *error))failure;

@end
