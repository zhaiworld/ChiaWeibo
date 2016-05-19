//
//  AppDelegate.m
//  Sina
//
//  Created by Chia on 16/2/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabBarController.h"
#import "WBNewFeatureController.h"
#import "WBOAuthViewController.h"
#import "WBAccountTool.h"
#import "WBRootTool.h"

#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong ) AVAudioPlayer * player ;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //判断有没有授权
    if ([WBAccountTool account]) {//已经授权
        //选择根控制器
        [WBRootTool chooseRootViewController:self.window];
    }else{
        
        //进行授权
        
        WBOAuthViewController *auth = [[WBOAuthViewController alloc]init];
        self.window.rootViewController = auth;

    }
    [self.window makeKeyAndVisible];

    return YES;
}
//用sdwebimage框架很容易出现内存警告
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    //清除所有缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}
- (void)applicationWillResignActive:(UIApplication *)application {

    //后台播放音乐
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    [player prepareToPlay];
    player.numberOfLoops = -1;
    [player play];
    
    _player = player;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    //开启一个后台任务
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        //
        [application endBackgroundTask:ID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
