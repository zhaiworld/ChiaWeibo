//
//  WBBadgeView.m
//  Sina
//
//  Created by Chia on 16/3/24.
//  Copyright © 2016年 WB. All rights reserved.
// 处理未读数的界面显示与用户交互

#import "WBBadgeView.h"

#define WBBadgeViewFont [UIFont systemFontOfSize:11]
@implementation WBBadgeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        //set background image
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = WBBadgeViewFont;
        
        [self sizeToFit];
    }
    return self;
}

-(void)setBadgeView:(NSString *)badgeView{
    _badgeView = badgeView;
    //判断传过来的值是否为空或0
    if (_badgeView.length == 0 || [_badgeView isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    

    //两种取得nsstring长度的方法
//  CGSize fontSize = [badgeView sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    NSMutableDictionary *attr = [[NSMutableDictionary alloc]init];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    CGSize fontSize = [badgeView sizeWithAttributes:attr];
    
    if (fontSize.width > self.frame.size.width) {//数字串的长度大于角标图片的长度
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeView forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        
    }
}
@end
