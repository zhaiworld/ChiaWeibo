//
//  WBCover.m
//  Sina
//
//  Created by Chia on 16/2/29.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBCover.h"

@implementation WBCover

//设置蒙版

-(void)setDimBackgroud:(BOOL)dimBackgroud{
    _dimBackgroud = dimBackgroud;
    if (dimBackgroud) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
    }else{
        self.alpha = 1.0;
        self.backgroundColor = [UIColor clearColor];
    }
}

+(instancetype)showCover{
    WBCover *cover = [[WBCover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
//    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    [WBKeyWindow addSubview:cover];
    
    return cover;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)]) {
        [_delegate coverDidClickCover:self];
    }
}

@end
