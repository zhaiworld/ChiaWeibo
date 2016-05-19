//
//  WBTextView.h
//  Sina
//
//  Created by Chia on 16/4/15.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBTextView : UITextView
/**
 *  文本区提示语
 */
@property(nonatomic, strong) NSString *placeHolder;
@property(nonatomic, assign) BOOL hiddenPlaceHolder;


@end
