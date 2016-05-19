//
//  WBFontSizeTool.m
//  Sina
//
//  Created by Chia on 16/4/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBFontSizeTool.h"

#define WBUserDefaults [NSUserDefaults standardUserDefaults]
#define WBFontSize @"fontSize"
#define WBFontSizeKey @"fontSizeKey"

@implementation WBFontSizeTool

+(void)saveFontSize:(NSString *)fontSize
{
    [WBUserDefaults setObject:fontSize forKey:WBFontSizeKey];
}

+(NSString *)fontSize
{

   return  [WBUserDefaults objectForKey:WBFontSizeKey];
}

@end
