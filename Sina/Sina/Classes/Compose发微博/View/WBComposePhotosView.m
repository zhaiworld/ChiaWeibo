//
//  WBComposePhotosView.m
//  Sina
//
//  Created by Chia on 16/4/19.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBComposePhotosView.h"

@implementation WBComposePhotosView

//-(instancetype)initWithFrame:(CGRect)frame{
//    if (self = [super initWithFrame:frame]) {
//        
//    }
//    return self;
//}

-(void)setImage:(UIImage *)image
{
    _image = image;
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = 10;
    NSUInteger cols = 3;
    CGFloat wh = (self.frame.size.width - (cols - 1)* margin) / cols;
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0 ; i< self.subviews.count; i++) {
        UIImageView *imageV = [[UIImageView alloc]init];
        
        imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = wh * col + margin * col;
        y = wh * row + margin * row;
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
