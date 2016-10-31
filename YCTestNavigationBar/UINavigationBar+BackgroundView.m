//
//  UINavigationBar+BackgroundView.m
//  YCTestNavigationBar
//
//  Created by 温玉超 on 16/10/30.
//  Copyright © 2016年 温玉超. All rights reserved.
//

#import "UINavigationBar+BackgroundView.h"
#import <objc/runtime.h>
#import "ViewController.h"

#define titleLableColor [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1]
@implementation UINavigationBar (BackgroundView)
static void *YCNavigationBarKey = "YCNavigationBarKey";
static void *YCNavigationBarMaskViewKey = "YCNavigationBarMaskViewKey";
const CGFloat kStateBarHeight = 20.f;

- (UIView *)overlayView {
    return objc_getAssociatedObject(self, YCNavigationBarKey);
}

- (UIView *)overlayMaskView {
    return objc_getAssociatedObject(self, YCNavigationBarMaskViewKey);
}

- (void)setOverlayView:(UIView *)overLayView {
    objc_setAssociatedObject(self, YCNavigationBarKey, overLayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setOverlayMaskView:(UIView *)overlayMaskView {
    objc_setAssociatedObject(self, YCNavigationBarMaskViewKey, overlayMaskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yc_setNavigationBarBackground:(UIColor *)backgroundColor {
    if (!self.overlayView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlayView = [[UIView alloc] initWithFrame:CGRectMake(0, -kStateBarHeight, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + kStateBarHeight)];
        self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlayView atIndex:0];
    }
    self.overlayView.backgroundColor = backgroundColor;
}

- (void)yc_setNavigationBarMask:(CGFloat)visibleHeight {
    if (!self.overlayMaskView) {
        self.overlayMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, -kStateBarHeight, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + kStateBarHeight)];
        
        self.overlayMaskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.overlayMaskView];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + kStateBarHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = NavigationBarTitle;
        
        label.textColor = titleLableColor;
        label.font = [UIFont boldSystemFontOfSize:17];
        [self.overlayMaskView addSubview:label];
        self.overlayMaskView.layer.mask = [[CAShapeLayer alloc] init];
        self.overlayMaskView.layer.mask.frame = CGRectMake(0, NavigationBarHeight - visibleHeight, self.bounds.size.width, visibleHeight);
        //这个一定要设置
        self.overlayMaskView.layer.mask.backgroundColor = [UIColor redColor].CGColor;
    }
    self.overlayMaskView.layer.mask.frame = CGRectMake(0, NavigationBarHeight - visibleHeight, self.bounds.size.width, visibleHeight);
}

- (void)yc_resetNavigationBarBackground {
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlayView removeFromSuperview];
    self.overlayView = nil;
}
@end
