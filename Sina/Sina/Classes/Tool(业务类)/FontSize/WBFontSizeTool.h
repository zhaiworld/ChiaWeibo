//
//  WBFontSizeTool.h
//  Sina
//
//  Created by Chia on 16/4/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBFontSizeTool : NSObject
/**
 *  保存fontsize
 *
 *  @param fontSize 通用设置界面，设置的字体大小
 */
+(void)saveFontSize:(NSString *)fontSize;
/**
 *  读取fontsize
 *
 *  @return 获取当前APP设置的字体大小
 */
+(NSString*)fontSize;

@end
