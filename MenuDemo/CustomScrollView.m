//
//  CustomScrollView.m
//  MenuDemo
//
//  Created by Job on 2017/11/5.
//  Copyright © 2017年 DaDiMedia. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        if ([pan translationInView:self].x > 0.0f && self.contentOffset.x == 0.0f) {
            return NO;
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

@end
