//
//  BackView.m
//  LRAnimationManager
//
//  Created by LR on 16/10/20.
//  Copyright © 2016年 LR. All rights reserved.
//

#import "BackView.h"

@implementation BackView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self configView];
    }
    return self;
}

- (void)configView {
    UITextView *textView = [[UITextView alloc]init];
    CGRect frame = self.frame;
    textView.frame = CGRectMake(10, 10, frame.size.width-20, frame.size.height-20);
    textView.text = @"文本背景view分离";
    [self addSubview:textView];
    [textView setNeedsLayout];
    
    CGFloat lineWidth = 10;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.strokeColor = [UIColor purpleColor].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.lineWidth = lineWidth;
    borderLayer.lineCap = @"round";
    borderLayer.lineJoin = @"round";
    borderLayer.lineDashPattern = @[[NSNumber numberWithFloat:lineWidth/2], [NSNumber numberWithFloat:2*lineWidth]];//线条宽度+空白宽度
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, self.bounds.size.width-2*lineWidth/2, self.bounds.size.height-2*lineWidth/2);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    borderLayer.path = bezierPath.CGPath;
    
    [self.layer insertSublayer:borderLayer atIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
