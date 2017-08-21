//
//  HeaderView.h
//  XianYuHomeSample
//
//  Created by 周凯丽 on 2017/8/18.
//  Copyright © 2017年 t. All rights reserved.
//

#import <UIKit/UIKit.h>
static CGFloat kHeadViewHeight  = 253 + 40;//头部视图高度
static CGFloat kSegmentHeight   = 40;//segment高度

static CGFloat kHeadContentH = 253;

@interface HeaderView : UIView

@property (strong, nonatomic) void(^segmentSelectBlock)(NSInteger index);//1  新鲜的  2 附近的

@property (assign, nonatomic) NSInteger index;//




@end
