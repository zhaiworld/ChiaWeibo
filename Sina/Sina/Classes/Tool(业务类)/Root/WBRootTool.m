//
//  WBRootTool.m
//  Sina
//
//  Created by Chia on 16/3/17.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBRootTool.h"
#import "WBTabBarController.h"
#import "WBNewFeatureController.h"

#define CZVersionKey @"version"

@implementation WBRootTool

+(void)chooseRootViewController:(UIWindow*)window{
    
    //获取当前版本号
    NSString *currentVer = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //获取旧版本号
    NSString *lastVer = [[NSUserDefaults standardUserDefaults] objectForKey:CZVersionKey];
    //是否有版本更新，没有则进入主页，有则进入新特性界面（并保存新版本号）
    if ([currentVer isEqualToString:lastVer]) {//没有新版本
        //进入主界面
        WBTabBarController *tabBarVc = [[WBTabBarController alloc] init];
        window.rootViewController = tabBarVc;
        CZLog(@"currentVer= %@",currentVer);
        CZLog(@"lastVer= %@",lastVer);

    }else{
        //有新版本，进入新特性界面
        WBNewFeatureController * newFeatureVc = [[WBNewFeatureController alloc] init];
        window.rootViewController = newFeatureVc;
        CZLog(@"currentVer= %@",currentVer);
        CZLog(@"lastVer= %@",lastVer);

        //保存新版本号到lastVer
        [[NSUserDefaults standardUserDefaults] setObject:currentVer forKey:CZVersionKey];
    }
}

@end
