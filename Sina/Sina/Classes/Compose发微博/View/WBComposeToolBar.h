//
//  WBComposeToolBar.h
//  Sina
//
//  Created by Chia on 16/4/18.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBComposeToolBar;
@protocol WBComposeToolBarDelegate <NSObject>

@optional
-(void)composeToolBar:(WBComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end



@interface WBComposeToolBar : UIView

@property(nonatomic, weak) id<WBComposeToolBarDelegate> delegate;

@end
