//
//  WBStatusCacheTool.h
//  Sina
//
//  Created by Chia on 16/5/6.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WBStatusParam;
@interface WBStatusCacheTool : NSObject

/**
 *  保存数据字典数据到数据库
 *
 *  @param statuses 字典类型微博数据
 */
+(void)saveWithStatuses:(NSArray *)statuses;

+(NSArray*)statusesWithParam:(WBStatusParam*)param;

@end
