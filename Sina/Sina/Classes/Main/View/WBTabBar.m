//
//  WBTabBar.m
//  Sina
//
//  Created by Chia on 16/2/26.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBTabBar.h"
#import "WBTabBarButton.h"

@interface WBTabBar()

@property (nonatomic, weak) UIButton *plusButton;
@property (nonatomic, strong) NSMutableArray * buttons;
@property (nonatomic, weak) UIButton *seletedButton;

@end

@implementation WBTabBar

-(NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

-(void)setItems:(NSArray *)items{
    _items = items;
    // 遍历模型数组，创建对应tabBarButton
    for (UITabBarItem *item in _items) {
        
        WBTabBarButton *btn = [WBTabBarButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮赋值模型，按钮的内容由模型对应决定
        btn.item = item;
        //给每个btn添加tag，从0到3，一共4个控件。self.buttons.count是从靠添加控件来变化的
        btn.tag = self.buttons.count;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        if (btn.tag == 0) { // 默认选中第0个
            [self btnClick:btn];
            
        }
        [btn sizeToFit];
        [self addSubview:btn];
        
        // 把按钮添加到按钮数组
        [self.buttons addObject:btn];
    }
}

// 点击tabBarButton调用
-(void)btnClick:(UIButton *)button
{
    _seletedButton.selected = NO;
    button.selected = YES;
    //seletedButton用来记录上一个被选中的btn。
    _seletedButton = button;
    
    // 通知tabBarVc切换控制器，
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}


//懒加载实现自定义发布按钮
-(UIButton *)plusButton
{
    if (!_plusButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        //监听点击 添加按钮 事件
        [btn addTarget:self action:@selector(clickPlus) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        _plusButton = btn;
        
        [self addSubview:_plusButton];
        
    }
    return _plusButton;
}
-(void)clickPlus
{
    //通知tabBarVC,弹出发布微博界面
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlus:)]) {
        [_delegate tabBarDidClickPlus:self];
    }

}

//调整子控件的位置
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w/ (self.items.count + 1);
    CGFloat btnH = h;
    
//    int i = 0;
//    for (UIView *tabBarButton in self.subviews) {
//        if ([tabBarButton isKindOfClass:NSClassFromString(@"WBTabBarButton")]) {
//            if (i == 2) {
//                i = 3;
//            }
//            btnX = i * btnW;
//            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
//            i++;
//        }
//    }
    int i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.buttons) {
        if (i == 2) {
            i = 3;
        }
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    //添加plusButton
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
}

@end
