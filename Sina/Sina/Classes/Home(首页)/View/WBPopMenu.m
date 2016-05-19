//
//  WBPopMenu.m
//  Sina
//
//  Created by Chia on 16/2/29.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBPopMenu.h"
#import "UIImage+WBimage.h"
#import "UIView+Frame.h"

@implementation WBPopMenu

+(instancetype)showInRect:(CGRect)rect{
    WBPopMenu *menu = [[WBPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imagewithStretchableName:@"popover_background"];
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
    
    return menu;
    
}

// 隐藏弹出菜单
+ (void)hide
{
    for (UIView *popMenu in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([popMenu isKindOfClass:self]) {
            [popMenu removeFromSuperview];
        }
    }
}

// 设置内容视图
- (void)setContentView:(UIView *)contentView
{
    // 先移除之前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
    
}

@end
