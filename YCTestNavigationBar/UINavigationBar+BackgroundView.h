//
//  UINavigationBar+BackgroundView.h
//  YCTestNavigationBar
//
//  Created by 温玉超 on 16/10/30.
//  Copyright © 2016年 温玉超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundView)

@property (nonatomic, retain) UIView *overlayView;
@property (nonatomic, retain) UIView *overlayMaskView;
- (void)yc_setNavigationBarBackground:(UIColor *)backgroundColor;
- (void)yc_resetNavigationBarBackground;
- (void)yc_setNavigationBarMask:(CGFloat)visibleHeight;
@end
