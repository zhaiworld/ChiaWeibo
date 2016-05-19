//
//  WBTabBar.h
//  Sina
//
//  Created by Chia on 16/2/26.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTabBar;
@protocol WBTabBarDelegate <NSObject>

@optional
- (void)tabBar:(WBTabBar *)tabBar didClickButton:(NSInteger)index;
/**
 *  点击加号时调用
 *
 *  @param tabBar 告诉代理是哪个VIEW
 */
-(void)tabBarDidClickPlus:(WBTabBar *)tabBar;
@end

@interface WBTabBar : UIView

//保存每一个按钮对应tabBarItem
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<WBTabBarDelegate> delegate;

@end
