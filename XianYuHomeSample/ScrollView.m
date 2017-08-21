//
//  ScrollView.m
//  XianYuHomeSample
//
//  Created by 周凯丽 on 2017/8/21.
//  Copyright © 2017年 t. All rights reserved.
//

#import "ScrollView.h"
#import "HeaderView.h"
@implementation ScrollView

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    BOOL hitHeadView  = point.y < (kHeadContentH - self.offsetY);
    if (!view || hitHeadView) {
        self.scrollEnabled = NO;
        if (!view) {
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x) {
                    view = subView;
                }
            }
        }
    }else{
        self.scrollEnabled = YES;
    }
    return view;
}

@end
