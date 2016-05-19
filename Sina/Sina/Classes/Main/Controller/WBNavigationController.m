//
//  WBNavigationController.m
//  Sina
//
//  Created by Chia on 16/2/29.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBNavigationController.h"
#import "UIBarButtonItem+WBItem.h"

@interface WBNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) id popDelegate;

@end

@implementation WBNavigationController

+(void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *att = [[NSMutableDictionary alloc] init];
    att[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    //在清空前保存当前interactivePopGestureRecognizer的代理
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    //实现滑动返回功能
    self.interactivePopGestureRecognizer.delegate = nil;
    //设置自己为navigationController的delegate，实现代理方法
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //获取主窗口的tabBar
    UITabBarController *tabBarVc = (UITabBarController*)WBKeyWindow.rootViewController;
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
    
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {//显示根控制器
        
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }else{//不是根控制器
        self.interactivePopGestureRecognizer.delegate = nil;

    }
}
//重写pushViewController方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    CZLog(@"%s",__func__);
    //设置非根控制器内容

    if (self.viewControllers.count !=0) {//说明不是根控制器
        
        //设置导航栏的左边与右边
        //左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        //右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}

-(void)backToPre{
    [self popViewControllerAnimated:YES];
}

-(void)backToRoot{
    [self popToRootViewControllerAnimated:YES];
}


@end
