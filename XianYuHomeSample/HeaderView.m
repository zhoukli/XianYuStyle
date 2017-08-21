//
//  HeaderView.m
//  XianYuHomeSample
//
//  Created by 周凯丽 on 2017/8/18.
//  Copyright © 2017年 t. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView
{
    UIButton *_freshBtn;
    UIButton *_nearbyBtn;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UIButton class]]) {//新鲜的 附近的 按钮可以点击  
        return view;
    }
    return nil;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - kSegmentHeight)];
        imgView.image =[UIImage imageNamed:@"home"];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        
        for (NSInteger i = 0; i< 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * self.midX, self.height - kSegmentHeight, self.midX, kSegmentHeight);
            [btn setTitleColor:RGBFromValue(0x333333) forState:UIControlStateSelected];
            [btn setTitleColor:RGBFromValue(0x999999) forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [self addSubview:btn];
            btn.tag = i;
            [btn addTarget:self action:@selector(segmentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (i == 0) {
                [btn setTitle:@"新鲜的" forState:UIControlStateNormal];
                btn.selected = YES;
                _freshBtn = btn;
            }else{
                [btn setTitle:@"附近的" forState:UIControlStateNormal];
                _nearbyBtn = btn;
            }
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0.5)];
        line.backgroundColor = RGBFromValue(0xc8c8c8);
        [self  addSubview:line];
    }
    return self;
}
- (void)setIndex:(NSInteger)index
{
    if (_index == index) {
        return;
    }
    _index = index;
    if (index == 0) {
        _freshBtn.selected = YES;
        _nearbyBtn.selected = NO;
    }else{
        _freshBtn.selected = NO;
        _nearbyBtn.selected = YES;
    }
}
- (void)segmentButtonClick:(UIButton *)button
{
    self.index = button.tag;
    
    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(button.tag);
    }
}

@end
