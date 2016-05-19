//
//  WBTabBarController.m
//  Sina
//
//  Created by Chia on 16/2/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBTabBarController.h"
#import "UIImage+WBimage.h"
#import "WBTabBar.h"

#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"

#import "WBNavigationController.h"
#import "WBUserTool.h"
#import "WBUserResult.h"
#import "WBComposeViewController.h"



@interface WBTabBarController ()<WBTabBarDelegate>
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, weak) WBHomeViewController *home;
@property (nonatomic, weak) WBMessageViewController *message;
@property (nonatomic, weak) WBProfileViewController *profile;

@end

@implementation WBTabBarController

//懒加载方法在实例化时不需要初始化内容，因为只有在需要它时才创建
-(NSMutableArray*)items{
    if (_items ==nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建所有子控制视图
    [self setUpAllChildViewController];
    
    // 自定义tabBar
    [self setUpTabBar];
    //每2秒刷新一下未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(unreadCount) userInfo:nil repeats:YES];
    
}
#pragma mark - 添加自定义tabBar
-(void)setUpTabBar{
    //自定义TabBar
    WBTabBar *wbTabBar = [[WBTabBar alloc] initWithFrame:self.tabBar.bounds];
    wbTabBar.backgroundColor = [UIColor whiteColor];
    
    //设置代理
    wbTabBar.delegate = self;
    
    // 给tabBar传递tabBarItem模型
    wbTabBar.items = self.items;
    
    
    // 添加自定义tabBar
    [self.tabBar addSubview:wbTabBar];

}
#pragma mark - 获取用户未读数
-(void)unreadCount{
    [WBUserTool unreadCountWithSuccess:^(WBUserResult *result) {
        //成功取得未读数，将未读数分配到界面上
        //home
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        //message
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        //profile
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        //设置应用程序所有的未读数，在HOME后显示
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
    } failure:^(NSError *error) {
        //
    }];

}
#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger)index
{
    self.selectedIndex = index;
}
//点击添加按钮后调用
-(void)tabBarDidClickPlus:(WBTabBar *)tabBar
{
    WBComposeViewController * compVc =[[WBComposeViewController alloc]init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:compVc];
    //跳转发布微博界面
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - 在视图加载前将系统自带tabBar上的按钮移除
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }

}

#pragma mark - 设置所有子控制器
-(void)setUpAllChildViewController
{
    //首页
    WBHomeViewController *home = [[WBHomeViewController alloc] init];
    [self setOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageWithOriginal:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    //消息
    WBMessageViewController *message = [[WBMessageViewController alloc] init];
    [self setOneChildViewController:message image:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageWithOriginal:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    
    //发现
    WBDiscoverViewController *discover = [[WBDiscoverViewController alloc] init];
    [self setOneChildViewController:discover image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageWithOriginal:@"tabbar_discover_selected"] title:@"发布"];
    

    //我
    WBProfileViewController *setting = [[WBProfileViewController alloc] init];
    [self setOneChildViewController:setting image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageWithOriginal:@"tabbar_profile_selected"] title:@"我"];
    _profile = setting;
    

}

#pragma mark - 给各个子控制器初始化内容
-(void)setOneChildViewController:(UIViewController*)vc image:(UIImage*)image selectedImage:(UIImage*)selectedImage title:(NSString*)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    // 保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    //将四个根控制器视图
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
