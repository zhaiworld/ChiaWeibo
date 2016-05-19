//
//  UIBarButtonItem+WBItem.h
//  Sina
//
//  Created by Chia on 16/2/29.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WBItem)

+(instancetype)barButtonItemWithImage:(UIImage*)image highImage:(UIImage*)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
