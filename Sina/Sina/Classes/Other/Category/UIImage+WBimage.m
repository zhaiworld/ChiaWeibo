//
//  UIImage+WBimage.m
//  Sina
//
//  Created by Chia on 16/2/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "UIImage+WBimage.h"

@implementation UIImage (WBimage)

+(instancetype)imageWithOriginal:(NSString*)imageName
{
    UIImage *oriImage = [UIImage imageNamed:imageName];
    return [oriImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(instancetype)imagewithStretchableName:(NSString *)imageName{
    UIImage *oriImage = [UIImage imageNamed:imageName];
    return [oriImage stretchableImageWithLeftCapWidth:oriImage.size.width *0.5 topCapHeight:oriImage.size.height *0.5];
}
@end
