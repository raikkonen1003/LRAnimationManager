//
//  AnimationManager.h
//  LLayerTest
//
//  Created by LR on 16/3/21.
//  Copyright © 2016年 LR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LRAnimationStyle){
    /**
     *  0: 默认
     */
    LRAnimationStyleNo_effect = 0, //无
    /**
     *  1: 淡入
     */
    LRAnimationStyleFadeInNormal = 1,
    /**
     *  2: 弹性放大
     */
    LRAnimationStyleFadeIn = 2,
    /**
     *  3: 弹性缩小
     */
    LRAnimationStyleExpandOpen = 3,
    /**
     *  4: 放大
     */
    LRAnimationStyleZoomIn = 4,
    /**
     *  5: 下落放大
     */
    LRAnimationStyleZoomInDown = 5,
    /**
     *  6: 上升放大
     */
    LRAnimationStyleZoomInUp = 6,
    /**
     *  7: 两侧弹开
     */
    LRAnimationStyleSlideExpandUp = 7,
    /**
     *  8: 两侧收缩
     */
    LRAnimationStyleRubberBand = 8,
    /**
     *  9: 左右摇摆
     */
    LRAnimationStyleShakeX = 9,
    /**
     *  10: 上摆钟
     */
    LRAnimationStyleSwingTop = 10,
    /**
     *  11: 上下摇摆
     */
    LRAnimationStyleShakeY = 11,
    /**
     *  12: 下摆钟
     */
    LRAnimationStyleSwingBottom = 12,
    /**
     *  13: 摇头晃脑
     */
    LRAnimationStyleTossing = 13,
    /**
     *  14: 反弹
     */
    LRAnimationStyleBounce = 14,
    /**
     *  15: 从左滚入
     */
    LRAnimationStyleRotateInDownLeft = 15,
    /**
     *  16: 从右滚入
     */
    LRAnimationStyleRotateInDownRight = 16,
    /**
     *  17: 滚雪球
     */
    LRAnimationStyleRollIn = 17,
    /**
     *  18: 向左淡入
     */
    LRAnimationStyleFadeInRight = 18,
    /**
     *  19: 向右淡入
     */
    LRAnimationStyleFadeInLeft = 19,
    /**
     *  20: 向上淡入
     */
    LRAnimationStyleFadeInUp = 20,
    /**
     *  21: 向下淡入
     */
    LRAnimationStyleFadeInDown = 21,
    /**
     *  22: 向右飞入
     */
    LRAnimationStyleMoveRight = 22,
    /**
     *  23: 向左飞入
     */
    LRAnimationStyleMoveLeft = 23,
    /**
     *  24: 向上飞入
     */
    LRAnimationStyleMoveUp = 24,
    /**
     *  25: 向下飞入
     */
    LRAnimationStyleMoveDown = 25,
    /**
     *  26: 向右滑入
     */
    LRAnimationStyleSlideRight = 26,
    /**
     *  27: 向左滑入
     */
    LRAnimationStyleSlideLeft = 27,
    /**
     *  28: 向上滑入
     */
    LRAnimationStyleSlideUp = 28,
    /**
     *  29: 向下滑入
     */
    LRAnimationStyleSlideDown = 29,
    /**
     *  30: 刹车
     */
    LRAnimationStyleLightSpeedIn = 30,
    /**
     *  31: 左右翻转
     */
    LRAnimationStyleFlipInY = 31,
    /**
     *  32: 上下翻转
     */
    LRAnimationStyleFlipInX = 32,
    /**
     *  33: 旋转出现
     */
    LRAnimationStyleRotateIn = 33,
    /**
     *  34: 向右展开
     */
    LRAnimationStyleStretchRight = 34,
    /**
     *  35: 向左展开
     */
    LRAnimationStyleStretchLeft = 35,
    /**
     *  36: 向上展开
     */
    LRAnimationStylePullUp = 36,
    /**
     *  37: 向下展开
     */
    LRAnimationStylePullDown = 37,
    /**
     *  38: 脉冲
     */
    LRAnimationStylePulse = 38,
    /**
     *  39: 闪烁
     */
    LRAnimationStyleFlash = 39,
    
};

@interface LRAnimationManager : NSObject<CAAnimationDelegate>

@property (nonatomic,strong) UIView *animateView;
@property (nonatomic,assign) CGPoint animateViewPosition;

+ (id) sharedInstance;

- (void)changeAnimationForView:(UIView *)view
                animationStyle:(LRAnimationStyle)style
                      rotation:(NSInteger)rotation
                         speed:(NSString *)speedStr;

@end
