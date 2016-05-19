//
//  WBTextView.m
//  Sina
//
//  Created by Chia on 16/4/15.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBTextView.h"

@interface WBTextView()

@property(nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation WBTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
    
}

-(UILabel *)placeHolderLabel{
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _placeHolderLabel = label;
    }
    return _placeHolderLabel;
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = self.font;
    [self.placeHolderLabel sizeToFit];
}
-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    [self.placeHolderLabel sizeToFit];
}
-(void)setHiddenPlaceHolder:(BOOL)hiddenPlaceHolder{
    _hiddenPlaceHolder = hiddenPlaceHolder;
    self.placeHolderLabel.hidden = hiddenPlaceHolder;
}
-(void)layoutSubviews
{
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}
@end
