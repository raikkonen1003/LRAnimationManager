//
//  AnimationManager.m
//  LLayerTest
//
//  Created by LR on 16/3/21.
//  Copyright © 2016年 LR. All rights reserved.
//

#import "LRAnimationManager.h"

//弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface LRAnimationManager() {
    CGPoint oldPosition;
    CGPoint oldArch;
    LRAnimationStyle oldStyle;
}

@end
@implementation LRAnimationManager

+ (id) sharedInstance {
    static LRAnimationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[self alloc]init];
        
    });
    return instance;
}
- (Boolean)resetViewPosition:(UIView *)newView withAnimationStyle:(LRAnimationStyle)style{
    if(self.animateView == nil || ![self.animateView isEqual:newView]) {
        oldPosition = newView.layer.position;
        oldArch = newView.layer.anchorPoint;
        return true;
    }
    if(!__CGPointEqualToPoint(oldPosition, newView.layer.position) || !__CGPointEqualToPoint(oldArch, newView.layer.anchorPoint)) {
        if(oldStyle == style) {
            return false;
        }
        newView.layer.position = oldPosition;
        newView.layer.anchorPoint = oldArch;
    }
    oldPosition = newView.layer.position;
    oldArch = newView.layer.anchorPoint;
    oldStyle = style;
    return true;
}

- (void)changeAnimationForView:(UIView *)view
                animationStyle:(LRAnimationStyle)style
                      rotation:(NSInteger)rotation
                         speed:(NSString *)speedStr {
    
    if (![self resetViewPosition:view withAnimationStyle:style]) {
        return;
    }
    CGFloat speed = 1;//默认速度为1
    NSArray *speedArray = [speedStr componentsSeparatedByString:@","];
    if (speedArray != nil && ![speedArray isKindOfClass:[NSNull class]] && speedArray.count != 0) {
        //执行array不为空时的操作
        NSString *str = speedArray[0];
        speed = str.floatValue;
    }
    
    
//    UIView *tempView = view;
//    NSInteger rotation = 0;
//    if ([view isKindOfClass:[LRChangeScaleTextView class]]) {
//        NSLog(@"[view isKindOfClass:[LRChangeScaleTextView class]]");
//    }else if ([view isKindOfClass:[LRChangeScaleImageView class]]){
//        NSLog(@"[view isKindOfClass:[LRChangeScaleImageView class]]");
//        LRChangeScaleImageView *imageView = (LRChangeScaleImageView *)view;
//        tempView = imageView.imageView;
//        rotation = imageView.rotation;
//    }else if ([view isKindOfClass:[LRChangeScaleButton class]]){
//        NSLog(@"[view isKindOfClass:[LRChangeScaleButton class]]");
//    }else if ([view isKindOfClass:[LRDragView class]]) {
//        NSLog(@"[view isKindOfClass:[LRDragView class]]");
//    }else if ([view isKindOfClass:[LRDragImageView class]]) {
//        NSLog(@"[view isKindOfClass:[LRDragImageView class]]");
//    }else {
//        NSLog(@"无法识别类型");
//        return;
//    }
//    view = tempView;
    
    CGFloat radians = DEGREES_TO_RADIANS(rotation);
    
//    view.transform = CGAffineTransformIdentity;
//    view.layer.transform = CATransform3DIdentity;

    
//    [dstView.layer removeAllAnimations];
//    CALayer *layer = (CALayer *)dstView.layer.presentationLayer;
//    dstView.layer.transform = layer.transform;
    
    switch (style) {
        case LRAnimationStyleNo_effect:
        {
            //用例1 scale
            //        CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
            //        dstView.frame = CGRectMake(-dstRect.size.width-10, dstRect.origin.y, dstRect.size.width, dstRect.size.height);
            //        CGPoint layerPosition = dstView.layer.position;
            //
            //        CATransform3D transform = CATransform3DMakeScale(0.5, 0.5, 1.0);  //x,y,z放大缩小倍数
            //        NSValue *value = [NSValue valueWithCATransform3D:transform];
            //        [theAnimation setToValue:value];
            //
            //        transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
            //        value = [NSValue valueWithCATransform3D:transform];
            //        [theAnimation setFromValue:value];
            //
            //        transform = CATransform3DMakeTranslation(-dstRect.size.width, layerPosition.y,0.0);
            //
            //        [theAnimation setAutoreverses:YES];  //原路返回的动画一遍
            //        [theAnimation setDuration:1.0];
            //        [theAnimation setRepeatCount:2];
            //
            //        [dstView.layer addAnimation:theAnimation forKey:nil];
            
            
            //用例2 rotate
            //        CABasicAnimation *theAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
            //        CATransform3D transform = CATransform3DMakeRotation(M_PI/2, M_PI, 0, 0); //1.57表示所转角度的弧度 = 90Pi/180 = 90*3.14/180
            //        NSValue *value = [NSValue valueWithCATransform3D:transform];
            //        [theAnimation setToValue:value];
            //
            //        transform = CATransform3DMakeRotation(0, 0, 0, 0);
            //        value = [NSValue valueWithCATransform3D:transform];
            //        [theAnimation setFromValue:value];
            //
            //        theAnimation.duration = 3.0;
            //        [dstView.layer addAnimation:theAnimation forKey:nil];
            
            
            //用例3 scale+rotate+position
            //        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
            //        CATransform3D rotateTransform = CATransform3DMakeRotation(M_PI, 0, 0, 1);//沿Z轴旋转
            //        CATransform3D scaleTransform = CATransform3DMakeScale(5, 5, 5);
            //        CATransform3D positionTransform = CATransform3DMakeTranslation(0, 0, 0); //位置移动
            //        CATransform3D combinedTransform =CATransform3DConcat(rotateTransform, scaleTransform); //Concat就是combine的意思
            //        combinedTransform = CATransform3DConcat(combinedTransform, positionTransform); //再combine一次把三个动作连起来
            //
            //        [anim setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]]; //放在3D坐标系中最正的位置
            //        [anim setToValue:[NSValue valueWithCATransform3D:combinedTransform]];
            //        [anim setDuration:5.0f];
            //
            //        [dstView.layer addAnimation:anim forKey:nil];
            //
            ////        [dstView.layer setTransform:combinedTransform];  //如果没有这句，layer执行完动画又会返回最初的state
            
            
            //        CAKeyframeAnimation *ani=[CAKeyframeAnimation animationWithKeyPath:@"position"];
            //        //初始化路径
            //        CGMutablePathRef aPath=CGPathCreateMutable();
            //        //动画起始点
            //        CGPathMoveToPoint(aPath, nil, 20, 20);
            //        CGPathAddCurveToPoint(aPath, nil,
            //                              160, 30,//控制点
            //                              220, 220,//控制点
            //                              240, 380);//控制点
            //
            //        ani.path=aPath;
            //        ani.duration=5;
            //        //设置为渐出
            //        ani.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            //        //自动旋转方向
            //        ani.rotationMode=@"auto";
            //
            //        [dstView.layer addAnimation:ani forKey:@"position"];
            
            //        CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            //        CATransform3D rotation1 = CATransform3DMakeRotation(30 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation2 = CATransform3DMakeRotation(60 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation3 = CATransform3DMakeRotation(90 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation4 = CATransform3DMakeRotation(120 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation5 = CATransform3DMakeRotation(150 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation6 = CATransform3DMakeRotation(180 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation7 = CATransform3DMakeRotation(210 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation8 = CATransform3DMakeRotation(240 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation9 = CATransform3DMakeRotation(270 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation10 = CATransform3DMakeRotation(300 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation11 = CATransform3DMakeRotation(330 * M_PI/180, 0, 0, 1);
            //        CATransform3D rotation12 = CATransform3DMakeRotation(360 * M_PI/180, 0, 0, 1);
            //        //        CATransform3D rotationfrom = CATransform3DMakeRotation(90 * M_PI/180, 0, 0, -1);
            //
            //        [keyAnim setValues:[NSArray arrayWithObjects:
            //                            [NSValue valueWithCATransform3D:rotation1],
            //                            [NSValue valueWithCATransform3D:rotation2],
            //                            [NSValue valueWithCATransform3D:rotation3],
            //                            [NSValue valueWithCATransform3D:rotation4],
            //                            [NSValue valueWithCATransform3D:rotation5],
            //                            [NSValue valueWithCATransform3D:rotation6],
            //                            [NSValue valueWithCATransform3D:rotation7],
            //                            [NSValue valueWithCATransform3D:rotation8],
            //                            [NSValue valueWithCATransform3D:rotation9],
            //                            [NSValue valueWithCATransform3D:rotation10],
            //                            [NSValue valueWithCATransform3D:rotation11],
            //                            [NSValue valueWithCATransform3D:rotation12],
            //                            //                            [NSValue valueWithCATransform3D:rotationfrom],
            //                            nil]];
            //        [keyAnim setKeyTimes:[NSArray arrayWithObjects:
            //                              [NSNumber numberWithFloat:0.0],
            //                              [NSNumber numberWithFloat:0.2f],
            //                              [NSNumber numberWithFloat:0.4f],
            //                              [NSNumber numberWithFloat:0.6f],
            //                              [NSNumber numberWithFloat:0.8f],
            //                              [NSNumber numberWithFloat:0.6f],
            //                              //                              [NSNumber numberWithFloat:0.6f],
            //                              nil]];
            //        [keyAnim setDuration:3.2];
            //        [keyAnim setFillMode:kCAFillModeForwards];
            //        [keyAnim setRemovedOnCompletion:NO];
            //        
            //        [dstView.layer addAnimation:keyAnim forKey:nil];
            
            
        }
            break;
        case LRAnimationStyleFadeInNormal:
        {
            [self fadeInNormalAnimationForView:view speed:speed radians:radians rotation:rotation];
        }
            break;
        case LRAnimationStyleFadeIn://2: 弹性放大
        {
            [self fadeInAnimationForView:view speed:speed radians:radians rotation:rotation];
        }
            break;
        case LRAnimationStyleExpandOpen:
        {
            [self expandOpenAnimationForView:view speed:speed radians:radians rotation:rotation];
        }
            break;
        case LRAnimationStyleZoomIn:
        {
            [self zoomInAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleZoomInDown:
        {
            [self zoomInDownAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleZoomInUp:
        {
            [self zoomInUpAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleSlideExpandUp:
        {
            
        }
            break;
        case LRAnimationStyleRubberBand:
        {
            
        }
            break;
        case LRAnimationStyleShakeX:
        {
            
        }
            break;
        case LRAnimationStyleSwingTop:
        {
            
        }
            break;
        case LRAnimationStyleShakeY:
        {
            
        }
            break;
        case LRAnimationStyleSwingBottom:
        {
            
        }
            break;
        case LRAnimationStyleTossing:
        {
            
        }
            break;
        case LRAnimationStyleBounce:
        {
            
        }
            break;
        case LRAnimationStyleRotateInDownLeft:
        {
            [self rotateInDownLeftAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleRotateInDownRight:
        {
            [self rotateInDownRightAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleRollIn:
        {
            [self rollInAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleFadeInRight:
        {
            [self fadeInRightAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleFadeInLeft:
        {
            [self fadeInLeftAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleFadeInUp:
        {
            [self fadeInUpAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleFadeInDown:
        {
            [self fadeInDownAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleMoveRight:
        {
            [self moveRightAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleMoveLeft:
        {
            [self moveLeftAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleMoveUp:
        {
            [self moveUpAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleMoveDown:
        {
            [self moveDownAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleSlideRight:
        {
            [self slideRightAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleSlideLeft:
        {
            [self slideLeftAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleSlideUp:
        {
            [self slideUpAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleSlideDown:
        {
            [self slideDownAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleLightSpeedIn:
        {
            
        }
            break;
        case LRAnimationStyleFlipInY:
        {
            [self flipInYAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleFlipInX:
        {
            [self flipInXAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleRotateIn:
        {
            [self rotateInAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleStretchRight:
        {
            [self stretchRightAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStyleStretchLeft:
        {
            [self stretchLeftAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStylePullUp:
        {
            [self pullUpAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStylePullDown:
        {
            [self pullDownAnimationForView:view speed:speed radians:radians rotation:rotation];
            
        }
            break;
        case LRAnimationStylePulse:
        {
            
        }
            break;
        case LRAnimationStyleFlash:
        {
            
        }
            break;
            
        default:
            break;
    }
//    if (style == LRAnimationStyleNo_effect) {
//        
//        
//        return;
//    }else if (style == LRAnimationStyleFadeIn) {
//
//
//    }else if (style == LRAnimationStyleShiftIn) {
//        
//        
//        
//        
//        
//    }else if (style == LRAnimationStyleZoomIn) {
//        
//        
//
//    }else if (style == LRAnimationStyleRotation) {
//        
//        
//        //二 关键帧动画实现方式
////        CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
////        
////        [keyAnim setValues:[NSArray arrayWithObjects:
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(30 * M_PI/180, 0, 0, 1)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(60 * M_PI/180, 0, 0, 1)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(90 * M_PI/180, 0, 0, 1)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(120 * M_PI/180, 0, 0, 1)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(150 * M_PI/180, 0, 0, 1)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI,0,0,1)],
////                            
////                            nil]];
//////        [keyAnim setKeyTimes:[NSArray arrayWithObjects:
//////                              [NSNumber numberWithFloat:0.0],
//////                              [NSNumber numberWithFloat:0.2f],
//////                              [NSNumber numberWithFloat:0.4f],
//////                              [NSNumber numberWithFloat:0.6f],
//////                              [NSNumber numberWithFloat:0.8f],
//////                              [NSNumber numberWithFloat:0.6f],
//////                              //                              [NSNumber numberWithFloat:0.6f],
//////                              nil]];
////        [keyAnim setDuration:2.0];
//////        [keyAnim setFillMode:kCAFillModeForwards];
//////        [keyAnim setRemovedOnCompletion:NO];
////        keyAnim.repeatCount = 2;
////        keyAnim.cumulative = YES;//累积 旋转第二遍的时候从第一遍结束的位置继续
////        
////        [dstView.layer addAnimation:keyAnim forKey:kCATransition];
//
//        
//    }else if (style == LRAnimationStyleFlip) {
////        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
////        for (int i = 0; i < 6; i++) {
////            CATransform3D transform = CATransform3DIdentity;
////            //apply perspective
////            transform.m34 = - 1.0 / 500.0;
////            //rotate by 45 degrees along the Y axis
//////            transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
////            transform = CATransform3DMakeRotation(i < 3 ? (i+1)*30*M_PI/180 : (6-i-1)*30*M_PI/180, 0, 1, 0);
////            //apply to layer
//////            dstView.layer.transform = transform;
////            
////            [array addObject:[NSValue valueWithCATransform3D:transform]];
////    //        dstView.layer.sublayerTransform = transform;
////        }
////        
////
////        CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
////
////        keyAnim.values = array;
////        [keyAnim setValues:[NSArray arrayWithObjects:
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(30 * M_PI/180, 0, 1, 0)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(60 * M_PI/180, 0, 1, 0)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(90 * M_PI/180, 0, 1, 0)],
//////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(90 * M_PI/180, 0, 1, 0)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(60 * M_PI/180, 0, 1, 0)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(30 * M_PI/180, 0, 1, 0)],
////                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI,0,1,0)],
////                            
////                            nil]];
////        [keyAnim setKeyTimes:[NSArray arrayWithObjects:
////                              [NSNumber numberWithFloat:0.2f],
////                              [NSNumber numberWithFloat:0.4f],
////                              [NSNumber numberWithFloat:0.6f],
////                              [NSNumber numberWithFloat:0.8f],
////                              [NSNumber numberWithFloat:1.0f],
////                              [NSNumber numberWithFloat:1.2f],
//////                              [NSNumber numberWithFloat:0.4f],
////                              nil]];
////        [keyAnim setDuration:3.2];
////        //        [keyAnim setFillMode:kCAFillModeForwards];
////        //        [keyAnim setRemovedOnCompletion:NO];
//////        keyAnim.repeatCount = 2;
//////        keyAnim.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
////        
////        [dstView.layer addAnimation:keyAnim forKey:nil];
//        
//        
//        //翻转的动画
//        //开始动画
//        [UIView beginAnimations:@"wrap view" context:nil];
//        //设置时常
//        [UIView setAnimationDuration:3];
//        //设置动画淡入淡出
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        //设置代理
//        [UIView setAnimationDelegate:self];
//        //设置翻转方向
//        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
//        //动画结束
//        [UIView commitAnimations];
//        
//
//    }else if (style == LRAnimationStyleDangle) {
////        float timeInterval = 3.5/20;
////        float startTime = 0.0;
////        NSArray *arr = [NSArray arrayWithObjects:
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-10 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-20 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-10 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(10 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(18 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(10 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-8 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-15 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-8 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(13 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-5 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-3 * M_PI/180, 0, 0, 1)],
////                        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
////                        nil];
////        
////        [UIView animateKeyframesWithDuration:3.5 delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedDuration animations:^{
////            for (int i = 0 ; i < 20; i++) {
////                [UIView addKeyframeWithRelativeStartTime:startTime+i*timeInterval relativeDuration:timeInterval animations:^{
////                    NSValue *value = arr[i];
////                    dstView.layer.transform = value.CATransform3DValue;
////                }];
////            }
////            
////        } completion:^(BOOL finished) {
////            
////        }];
//        
//        CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
//
//        [keyAnim setValues:[NSArray arrayWithObjects:
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-10 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-20 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-10 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(10 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(18 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(10 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-8 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-15 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-8 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(13 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-5 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-3 * M_PI/180, 0, 0, 1)],
//                            [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0 * M_PI/180, 0, 0, 1)],
//                            nil]];
//
//        [keyAnim setDuration:3.5];
////        [keyAnim setFillMode:kCAFillModeForwards];
////        [keyAnim setRemovedOnCompletion:NO];
////        keyAnim.repeatCount = 2;
//        keyAnim.cumulative = YES;//累积 旋转第二遍的时候从第一遍结束的位置继续
//        
//        [view.layer addAnimation:keyAnim forKey:kCATransition];
//
//    }else if (style == LRAnimationStyleFadeOut) {
//        
//        //透明度变化
//        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
//        opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
//        opacityAnim.toValue = [NSNumber numberWithFloat:0.0];
//        //        opacityAnim.removedOnCompletion = YES;
//        opacityAnim.duration = 3.0;
//        
//        [CATransaction setCompletionBlock:^{
//            view.alpha = 1.0;
//        }];
//
//        opacityAnim.delegate = self;
//        [view.layer addAnimation:opacityAnim forKey:nil];
//        
//
//    }else if (style == LRAnimationStyleDissolve) {
//        //翻转的动画
//        //开始动画
//        [UIView beginAnimations:@"wap view" context:nil];
//        //设置时常
//        [UIView setAnimationDuration:2];
//        //设置动画淡入淡出
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        //设置代理
//        [UIView setAnimationDelegate:self];
//        //设置翻转方向
//        [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:view cache:YES];
//        //动画结束
//        [UIView commitAnimations];
//        
//        //透明度变化
//        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
//        opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
//        opacityAnim.toValue = [NSNumber numberWithFloat:0.0];
//        //        opacityAnim.removedOnCompletion = YES;
//        opacityAnim.duration = 3.0;
////        opacityAnim.autoreverses = YES;
//        
//        [CATransaction setCompletionBlock:^{
//            view.alpha = 1.0;
//        }];
//        opacityAnim.delegate = self;
//        [view.layer addAnimation:opacityAnim forKey:@"LRAnimationStyleDissolve"];
//    }
    
    self.animateView = view;
}

- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
//    NSLog(@"anim--class-->>%@--%@",[anim description],anim);
    
    self.animateView.layer.position = self.animateViewPosition;
    self.animateView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    if ([self.animateView.layer animationForKey:@"wrap view"] == anim) {
        NSLog(@"selectImgAniGroup----Stop");
    }else if ([self.animateView.layer animationForKey:@"LRAnimationStyleDissolve"] == anim) {
        NSLog(@"LRAnimationStyleDissolve--stop");
    }
}


#pragma mark 暂停CALayer的动画
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    // 让CALayer的时间停止走动
    layer.speed = 0.0;
    // 让CALayer的时间停留在pausedTime这个时刻
    layer.timeOffset = pausedTime;
}
#pragma mark 恢复CALayer的动画
-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime= layer.timeOffset;
    //1. 让CALayer的时间继续行走
    layer.speed= 1.0;
    //2. 取消上次记录的停留时刻
    layer.timeOffset= 0.0;
    //3. 取消上次设置的时间
    layer.beginTime= 0.0;
    //4. 计算暂停的时间(这里也可以用CACurrentMediaTime()-pausedTime)
    CFTimeInterval timeSincePause= [layer convertTime:CACurrentMediaTime()fromLayer:nil]- pausedTime;
    //5. 设置相对于父坐标系的开始时间(往后退timeSincePause)
    layer.beginTime= timeSincePause;
}

#pragma mark- 各个动画方法
- (void)fadeInNormalAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //        dstView.alpha = 0.0;
    //
    //        [UIView beginAnimations:nil context:nil];
    //        [UIView setAnimationDuration:3.0];
    //        dstView.frame = dstRect;
    //        dstView.alpha = 1.0;
    //        [UIView commitAnimations];
    //
    //        [CATransaction setCompletionBlock:^{
    //            [UIView beginAnimations:nil context:nil];
    //            [UIView setAnimationDuration:1.0];
    //            dstView.frame = dstRect;
    //            dstView.alpha = 1.0;
    //            [UIView commitAnimations];
    //        }];
    
    //            [view.layer removeAllAnimations];
    //透明度变化
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation.duration = speed;
    
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:0.1],
                        [NSNumber numberWithFloat:1.0],
                        nil];
    
    [view.layer addAnimation:animation forKey:nil];
}
- (void)fadeInAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = speed;
    
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                        nil];
    
    [view.layer addAnimation:animation forKey:nil];
}
- (void)expandOpenAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = speed;
    
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                        nil];
    
    [view.layer addAnimation:animation forKey:nil];
}
- (void)zoomInAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = speed;
    
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                        nil];
    
    [view.layer addAnimation:animation forKey:nil];
}
- (void)zoomInDownAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //一 基本动画实现方式
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    //从上到下 从下到上都有 角度互余的问题
    radians = DEGREES_TO_RADIANS(rotation+90);
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
    
    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 180 && rotation <= 360) {
        x = startPosition.x - height / tanValue;
    }
    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
        y = startPosition.y - height;
    }
    
    height = height+10;
    CGFloat middleX = startPosition.x + height / tanValue;
    CGFloat middleY = startPosition.y + height;
    if (rotation >= 180 && rotation <= 360) {
        middleX = startPosition.x - height / tanValue;
    }
    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
        middleY = startPosition.y - height;
    }
    
    CGPoint leftPosition = CGPointMake(x, y);
    CGPoint middlePosition = CGPointMake(middleX, middleY);
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:middlePosition],
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    //            animation.fromValue = [NSValue valueWithCGPoint:leftPosition];
    //            animation.toValue = [NSValue valueWithCGPoint:endPosition];
    
    animation.duration = speed/2;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = speed*3/4;
    
    scaleAnimation.values = [NSArray arrayWithObjects:
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                             nil];
    
    [view.layer addAnimation:scaleAnimation forKey:nil];
}
- (void)zoomInUpAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    //从上到下 从下到上都有 角度互余的问题
    radians = DEGREES_TO_RADIANS(rotation+90);
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
    
    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 0 && rotation <= 180) {
        x = startPosition.x - height / tanValue;
    }
    if ((rotation >= 90 && rotation <= 270)) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
        y = startPosition.y - height;
    }
    
    height = height+10;
    CGFloat middleX = startPosition.x + height / tanValue;
    CGFloat middleY = startPosition.y + height;
    if (rotation >= 0 && rotation <= 180) {
        middleX = startPosition.x - height / tanValue;
    }
    if ((rotation >= 90 && rotation <= 270)) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
        middleY = startPosition.y - height;
    }
    
    CGPoint leftPosition = CGPointMake(x, y);
    CGPoint middlePosition = CGPointMake(middleX, middleY);
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:middlePosition],
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    //            animation.fromValue = [NSValue valueWithCGPoint:leftPosition];
    //            animation.toValue = [NSValue valueWithCGPoint:endPosition];
    
    animation.duration = speed/2;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = speed*3/4;
    
    scaleAnimation.values = [NSArray arrayWithObjects:
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                             nil];
    
    [view.layer addAnimation:scaleAnimation forKey:nil];
}
- (void)slideExpandUpAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)rubberBandAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)shakeXAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)swingTopAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)shakeYAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)swingBottomAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)tossingAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)bounceAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}

- (void)rotateInDownLeftAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = speed;
    
    //            animation.values = [NSArray arrayWithObjects:
    //                                [NSNumber numberWithFloat:DEGREES_TO_RADIANS(rotation - 90)],
    //                                [NSNumber numberWithFloat:DEGREES_TO_RADIANS(rotation)],
    //                                nil];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform, DEGREES_TO_RADIANS(- 90), 0, 0, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform, DEGREES_TO_RADIANS(0), 0, 0, 1)],
                        nil];
    
    
    CGPoint position = view.layer.position;
    CGFloat w = view.layer.bounds.size.width;
    CGFloat h = view.layer.bounds.size.height;
    CGFloat x = position.x - (w/2/cos(radians)+(h/2-w/2*tan(radians))*sin(radians));
    CGFloat y = position.y + (h/2-w/2*tan(radians))*cos(radians);
    //            view.layer.position = CGPointMake(position.x-view.bounds.size.width/2, position.y+view.bounds.size.height/2);
    view.layer.position = CGPointMake(x, y);
    view.layer.anchorPoint = CGPointMake(0, 1);
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:nil];
    
    self.animateViewPosition = position;
    
    //            CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    //            animGroup.animations = [NSArray arrayWithObjects:opacityAnim, animation, nil];
    //            animGroup.duration = speed;
    //            [view.layer addAnimation:animation forKey:nil];
}

- (void)rotateInDownRightAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = speed;
    
    //            animation.values = [NSArray arrayWithObjects:
    //                                [NSNumber numberWithFloat:DEGREES_TO_RADIANS(rotation + 90)],
    //                                [NSNumber numberWithFloat:DEGREES_TO_RADIANS(rotation)],
    //                                nil];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform, DEGREES_TO_RADIANS(90), 0, 0, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(view.layer.transform, DEGREES_TO_RADIANS(0), 0, 0, 1)],
                        nil];
    
    CGPoint position = view.layer.position;
    CGFloat w = view.layer.bounds.size.width;
    CGFloat h = view.layer.bounds.size.height;
    CGFloat x = position.x + (w/2/cos(radians)-w/2*tan(radians)*sin(radians)-h/2*sin(radians));
    CGFloat y = position.y + (w*tan(radians)+h)/2*cos(radians);
    view.layer.position = CGPointMake(x, y);
    //            view.layer.position = CGPointMake(position.x+view.bounds.size.width/2, position.y+view.bounds.size.height/2);
    view.layer.anchorPoint = CGPointMake(1, 1);
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:nil];
    
    self.animateViewPosition = position;
    
    //            CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    //            animGroup.animations = [NSArray arrayWithObjects:opacityAnim, animation, nil];
    //            animGroup.duration = speed*3/2;
    //            [view.layer addAnimation:animation forKey:nil];
}
- (void)rollInAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = speed;
    
    animation.values = [NSArray arrayWithObjects:
                        [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-90)],
                        [NSNumber numberWithFloat:0],
                        nil];
    [view.layer addAnimation:animation forKey:nil];
    
    CAKeyframeAnimation *translationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation"];
    translationAnimation.duration = speed;
    
    translationAnimation.values = [NSArray arrayWithObjects:
                                   [NSNumber numberWithFloat:-view.layer.bounds.size.width],
                                   [NSNumber numberWithFloat:0],
                                   nil];
    [view.layer addAnimation:translationAnimation forKey:nil];
}
- (void)fadeInRightAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    //涉及4个方向移动的动画都可以用下面两种方法来计算
    //方法一 用tan来计算，判断不同的移动方向在不同的旋转角度下进行值的变化
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内


    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 90 && rotation <= 270) {
        x = startPosition.x - height / tanValue;
    }
    if (rotation >= 180 && rotation <= 360) {
        y = startPosition.y - height;
    }
//    //方法二 根据旋转角度，不同方向进来需要 +或- 加减具体的值由sin cos值来计算 两种方法都要注意上下方向上 角度互余的问题
//    CGFloat x = startPosition.x + view.layer.bounds.size.width*cos(radians);
//    CGFloat y = startPosition.y + view.layer.bounds.size.width*sin(radians);
    
    CGPoint leftPosition = CGPointMake(x, y);
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)fadeInLeftAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内


    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {
        x = startPosition.x - height / tanValue;
    }
    if ((rotation+180) >= 180 && (rotation+180) <= 360) {//从左向右 -y的情况
        y = startPosition.y - height;
    }
    
//    CGFloat x = startPosition.x - view.layer.bounds.size.width*cos(radians);
//    CGFloat y = startPosition.y - view.layer.bounds.size.width*sin(radians);
    
    CGPoint leftPosition = CGPointMake(x, y);
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)fadeInUpAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    //从上到下 从下到上都有 角度互余的问题
    radians = DEGREES_TO_RADIANS(90 - (rotation%360));//求余角
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内

    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 0 && rotation <= 180) {
        x = startPosition.x - height / tanValue;
    }
    if (rotation >= 90 && rotation <= 270) {
        y = startPosition.y - height;
    }
    
//    //从上到下 从下到上都有 角度互余的问题
//    radians = DEGREES_TO_RADIANS(90 - (rotation%360));//求余角
//    CGFloat x = startPosition.x - view.layer.bounds.size.width*cos(radians);
//    CGFloat y = startPosition.y + view.layer.bounds.size.width*sin(radians);
    
    CGPoint leftPosition = CGPointMake(x, y);//上下方向角度互余
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)fadeInDownAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    //从上到下 从下到上都有 角度互余的问题
    radians = DEGREES_TO_RADIANS(90 - (rotation%360));//求余角
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内

    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 180 && rotation <= 360) {
        x = startPosition.x - height / tanValue;
    }
    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {
        y = startPosition.y - height;
    }
    
//    radians = DEGREES_TO_RADIANS(90 - (rotation%360));//求余角
//    CGFloat x = startPosition.x + view.layer.bounds.size.width*cos(radians);
//    CGFloat y = startPosition.y - view.layer.bounds.size.width*sin(radians);
    
    CGPoint leftPosition = CGPointMake(x, y);//上下方向角度互余
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)moveRightAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
    
    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {
        x = startPosition.x - height / tanValue;
    }
    if ((rotation+180) >= 180 && (rotation+180) <= 360) {
        y = startPosition.y - height;
    }
    
    CGPoint leftPosition = CGPointMake(x, y);
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)moveLeftAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
    
    
    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 90 && rotation <= 270) {
        x = startPosition.x - height / tanValue;
    }
    if (rotation >= 180 && rotation <= 360) {
        y = startPosition.y - height;
    }
    
    CGPoint leftPosition = CGPointMake(x, y);
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}
- (void)moveUpAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    //从上到下 从下到上都有 角度互余的问题
    radians = DEGREES_TO_RADIANS(rotation+90);
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
    
    
    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 0 && rotation <= 180) {
        x = startPosition.x - height / tanValue;
    }
    if (rotation >= 90 && rotation <= 270) {
        y = startPosition.y - height;
    }
    
    CGPoint leftPosition = CGPointMake(x, y);//上下方向角度互余
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)moveDownAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
    //从上到下 从下到上都有 角度互余的问题
    radians = DEGREES_TO_RADIANS(rotation+90);
    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
    CGFloat height = view.layer.bounds.size.width * tanValue;
    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
    
    
    CGFloat x = startPosition.x + height / tanValue;
    CGFloat y = startPosition.y + height;
    if (rotation >= 180 && rotation <= 360) {
        x = startPosition.x - height / tanValue;
    }
    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {
        y = startPosition.y - height;
    }
    
    CGPoint leftPosition = CGPointMake(x, y);
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)slideRightAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
//    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
//    CGFloat height = view.layer.bounds.size.width * tanValue;
//    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
//    
//    CGFloat x = startPosition.x + height / tanValue;
//    CGFloat y = startPosition.y + height;
//    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {
//        x = startPosition.x - height / tanValue;
//    }
//    if (rotation >= 0 && rotation <= 180) {
//        y = startPosition.y - height;
//    }
//    
//    //在原位置的振动
//    CGFloat height1 = -10;
//    CGFloat middleX1 = startPosition.x + height1 / tanValue;
//    CGFloat middleY1 = startPosition.y + height1;
//    CGFloat height2 = 8;
//    CGFloat middleX2 = startPosition.x + height2 / tanValue;
//    CGFloat middleY2 = startPosition.y + height2;
//    CGFloat height3 = -5;
//    CGFloat middleX3 = startPosition.x + height3 / tanValue;
//    CGFloat middleY3 = startPosition.y + height3;
//    CGFloat height4 = 3;
//    CGFloat middleX4 = startPosition.x + height4 / tanValue;
//    CGFloat middleY4 = startPosition.y + height4;
//    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {
//        middleX1 = startPosition.x - height1 / tanValue;
//        middleX2 = startPosition.x - height2 / tanValue;
//        middleX3 = startPosition.x - height3 / tanValue;
//        middleX4 = startPosition.x - height4 / tanValue;
//    }
//    if (rotation >= 0 && rotation <= 180) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
//        middleY1 = startPosition.y - height1;
//        middleY2 = startPosition.y - height2;
//        middleY3 = startPosition.y - height3;
//        middleY4 = startPosition.y - height4;
//    }
//    CGPoint middle1 = CGPointMake(middleX1, middleY1);
//    CGPoint middle2 = CGPointMake(middleX2, middleY2);
//    CGPoint middle3 = CGPointMake(middleX3, middleY3);
//    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    CGFloat x = startPosition.x - view.layer.bounds.size.width*cos(radians);
    CGFloat y = startPosition.y - view.layer.bounds.size.width*sin(radians);
    CGFloat height1 = -10;
    CGFloat height2 = 8;
    CGFloat height3 = -5;
    CGFloat height4 = 3;
    CGFloat middleX1 = startPosition.x - height1*cos(radians);
    CGFloat middleY1 = startPosition.y - height1*sin(radians);
    CGFloat middleX2 = startPosition.x - height2*cos(radians);
    CGFloat middleY2 = startPosition.y - height2*sin(radians);
    CGFloat middleX3 = startPosition.x - height3*cos(radians);
    CGFloat middleY3 = startPosition.y - height3*sin(radians);
    CGFloat middleX4 = startPosition.x - height4*cos(radians);
    CGFloat middleY4 = startPosition.y - height4*sin(radians);
    CGPoint middle1 = CGPointMake(middleX1, middleY1);
    CGPoint middle2 = CGPointMake(middleX2, middleY2);
    CGPoint middle3 = CGPointMake(middleX3, middleY3);
    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    CGPoint leftPosition = CGPointMake(x, y);//上下方向角度互余
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:middle1],
                        [NSValue valueWithCGPoint:middle2],
                        [NSValue valueWithCGPoint:middle3],
                        [NSValue valueWithCGPoint:middle4],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)slideLeftAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
//    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
//    CGFloat height = view.layer.bounds.size.width * tanValue;
//    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
//
//    CGFloat x = startPosition.x + height / tanValue;
//    CGFloat y = startPosition.y + height;
//    if (rotation >= 90 && rotation <= 270) {
//        x = startPosition.x - height / tanValue;
//    }
//    if (rotation >= 180 && rotation <= 360) {
//        y = startPosition.y - height;
//    }


//    //在原位置的振动
//    CGFloat height1 = -10;
//    CGFloat middleX1 = startPosition.x + height1 / tanValue;
//    CGFloat middleY1 = startPosition.y + height1;
//    CGFloat height2 = 8;
//    CGFloat middleX2 = startPosition.x + height2 / tanValue;
//    CGFloat middleY2 = startPosition.y + height2;
//    CGFloat height3 = -5;
//    CGFloat middleX3 = startPosition.x + height3 / tanValue;
//    CGFloat middleY3 = startPosition.y + height3;
//    CGFloat height4 = 3;
//    CGFloat middleX4 = startPosition.x + height4 / tanValue;
//    CGFloat middleY4 = startPosition.y + height4;
//    if (rotation >= 90 && rotation <= 270) {
//        middleX1 = startPosition.x - height1 / tanValue;
//        middleX2 = startPosition.x - height2 / tanValue;
//        middleX3 = startPosition.x - height3 / tanValue;
//        middleX4 = startPosition.x - height4 / tanValue;
//    }
//    if (rotation >= 180 && rotation <= 360) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
//        middleY1 = startPosition.y - height1;
//        middleY2 = startPosition.y - height2;
//        middleY3 = startPosition.y - height3;
//        middleY4 = startPosition.y - height4;
//    }
//    CGPoint middle1 = CGPointMake(middleX1, middleY1);
//    CGPoint middle2 = CGPointMake(middleX2, middleY2);
//    CGPoint middle3 = CGPointMake(middleX3, middleY3);
//    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    CGFloat x = startPosition.x + view.layer.bounds.size.width*cos(radians);
    CGFloat y = startPosition.y + view.layer.bounds.size.width*sin(radians);
    CGFloat height1 = -10;
    CGFloat height2 = 8;
    CGFloat height3 = -5;
    CGFloat height4 = 3;
    CGFloat middleX1 = startPosition.x + height1*cos(radians);
    CGFloat middleY1 = startPosition.y + height1*sin(radians);
    CGFloat middleX2 = startPosition.x + height2*cos(radians);
    CGFloat middleY2 = startPosition.y + height2*sin(radians);
    CGFloat middleX3 = startPosition.x + height3*cos(radians);
    CGFloat middleY3 = startPosition.y + height3*sin(radians);
    CGFloat middleX4 = startPosition.x + height4*cos(radians);
    CGFloat middleY4 = startPosition.y + height4*sin(radians);
    CGPoint middle1 = CGPointMake(middleX1, middleY1);
    CGPoint middle2 = CGPointMake(middleX2, middleY2);
    CGPoint middle3 = CGPointMake(middleX3, middleY3);
    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    CGPoint leftPosition = CGPointMake(x, y);//上下方向角度互余
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:middle1],
                        [NSValue valueWithCGPoint:middle2],
                        [NSValue valueWithCGPoint:middle3],
                        [NSValue valueWithCGPoint:middle4],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)slideUpAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
//    //从上到下 从下到上都有 角度互余的问题
//    radians = DEGREES_TO_RADIANS(rotation+90);
//    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
//    CGFloat height = view.layer.bounds.size.width * tanValue;
//    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
//    
//    
//    CGFloat x = startPosition.x + height / tanValue;
//    CGFloat y = startPosition.y + height;
//    if (rotation >= 0 && rotation <= 180) {
//        x = startPosition.x - height / tanValue;
//    }
//    if (rotation >= 90 && rotation <= 270) {
//        y = startPosition.y - height;
//    }
//    
//    //在原位置的振动
//    CGFloat height1 = -10;
//    CGFloat middleX1 = startPosition.x + height1 / tanValue;
//    CGFloat middleY1 = startPosition.y + height1;
//    CGFloat height2 = 8;
//    CGFloat middleX2 = startPosition.x + height2 / tanValue;
//    CGFloat middleY2 = startPosition.y + height2;
//    CGFloat height3 = -5;
//    CGFloat middleX3 = startPosition.x + height3 / tanValue;
//    CGFloat middleY3 = startPosition.y + height3;
//    CGFloat height4 = 3;
//    CGFloat middleX4 = startPosition.x + height4 / tanValue;
//    CGFloat middleY4 = startPosition.y + height4;
//    if (rotation >= 0 && rotation <= 180) {
//        middleX1 = startPosition.x - height1 / tanValue;
//        middleX2 = startPosition.x - height2 / tanValue;
//        middleX3 = startPosition.x - height3 / tanValue;
//        middleX4 = startPosition.x - height4 / tanValue;
//    }
//    if (rotation >= 90 && rotation <= 270) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
//        middleY1 = startPosition.y - height1;
//        middleY2 = startPosition.y - height2;
//        middleY3 = startPosition.y - height3;
//        middleY4 = startPosition.y - height4;
//    }
//    CGPoint middle1 = CGPointMake(middleX1, middleY1);
//    CGPoint middle2 = CGPointMake(middleX2, middleY2);
//    CGPoint middle3 = CGPointMake(middleX3, middleY3);
//    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    radians = DEGREES_TO_RADIANS(90 - (rotation%360));//求余角
    CGFloat x = startPosition.x - view.layer.bounds.size.width*cos(radians);
    CGFloat y = startPosition.y + view.layer.bounds.size.height*sin(radians);
    
    CGFloat height1 = -10.0;
    CGFloat height2 = 8.0;
    CGFloat height3 = -5.0;
    CGFloat height4 = 3.0;
    CGFloat middleX1 = startPosition.x - height1*cos(radians);
    CGFloat middleY1 = startPosition.y + height1*sin(radians);
    CGFloat middleX2 = startPosition.x - height2*cos(radians);
    CGFloat middleY2 = startPosition.y + height2*sin(radians);
    CGFloat middleX3 = startPosition.x - height3*cos(radians);
    CGFloat middleY3 = startPosition.y + height3*sin(radians);
    CGFloat middleX4 = startPosition.x - height4*cos(radians);
    CGFloat middleY4 = startPosition.y + height4*sin(radians);
    CGPoint middle1 = CGPointMake(middleX1, middleY1);
    CGPoint middle2 = CGPointMake(middleX2, middleY2);
    CGPoint middle3 = CGPointMake(middleX3, middleY3);
    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    CGPoint leftPosition = CGPointMake(x, y);//上下方向角度互余
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:middle1],
                        [NSValue valueWithCGPoint:middle2],
                        [NSValue valueWithCGPoint:middle3],
                        [NSValue valueWithCGPoint:middle4],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    //            animation.keyTimes = @[
    //                                   [NSNumber numberWithFloat:2/7.0],
    //                                   [NSNumber numberWithFloat:1/7.0],
    //                                   [NSNumber numberWithFloat:1/7.0],
    //                                   [NSNumber numberWithFloat:1/7.0],
    //                                   [NSNumber numberWithFloat:1/7.0],
    //                                   [NSNumber numberWithFloat:1/7.0],
    //                                   ];
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)slideDownAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint startPosition = view.layer.position;
    
//    //从上到下 从下到上都有 角度互余的问题
//    radians = DEGREES_TO_RADIANS(rotation+90);
//    CGFloat tanValue = ABS(tan(radians)) == 0 ? ABS(tan(DEGREES_TO_RADIANS(1))) : ABS(tan(radians));
//    CGFloat height = view.layer.bounds.size.width * tanValue;
//    height = height > view.layer.bounds.size.height ? view.layer.bounds.size.height : height;//让y在自身高度范围内
//    
//    
//    CGFloat x = startPosition.x + height / tanValue;
//    CGFloat y = startPosition.y + height;
//    if (rotation >= 180 && rotation <= 360) {
//        x = startPosition.x - height / tanValue;
//    }
//    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {
//        y = startPosition.y - height;
//    }
//    
//    //在原位置的振动
//    CGFloat height1 = -10;
//    CGFloat middleX1 = startPosition.x + height1 / tanValue;
//    CGFloat middleY1 = startPosition.y + height1;
//    CGFloat height2 = 8;
//    CGFloat middleX2 = startPosition.x + height2 / tanValue;
//    CGFloat middleY2 = startPosition.y + height2;
//    CGFloat height3 = -5;
//    CGFloat middleX3 = startPosition.x + height3 / tanValue;
//    CGFloat middleY3 = startPosition.y + height3;
//    CGFloat height4 = 3;
//    CGFloat middleX4 = startPosition.x + height4 / tanValue;
//    CGFloat middleY4 = startPosition.y + height4;
//    if (rotation >= 180 && rotation <= 360) {
//        middleX1 = startPosition.x - height1 / tanValue;
//        middleX2 = startPosition.x - height2 / tanValue;
//        middleX3 = startPosition.x - height3 / tanValue;
//        middleX4 = startPosition.x - height4 / tanValue;
//    }
//    if ((rotation >= 0 && rotation <= 90) || (rotation >= 270 && rotation <= 360)) {//(rotation-90 >= 180 && rotation-90 <= 360) {//从上向下 -y
//        middleY1 = startPosition.y - height1;
//        middleY2 = startPosition.y - height2;
//        middleY3 = startPosition.y - height3;
//        middleY4 = startPosition.y - height4;
//    }
//    CGPoint middle1 = CGPointMake(middleX1, middleY1);
//    CGPoint middle2 = CGPointMake(middleX2, middleY2);
//    CGPoint middle3 = CGPointMake(middleX3, middleY3);
//    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    radians = DEGREES_TO_RADIANS(90 - (rotation%360));//求余角
    CGFloat x = startPosition.x + view.layer.bounds.size.width*cos(radians);
    CGFloat y = startPosition.y - view.layer.bounds.size.height*sin(radians);
    
    CGFloat height1 = -10;
    CGFloat height2 = 8;
    CGFloat height3 = -5;
    CGFloat height4 = 3;
    CGFloat middleX1 = startPosition.x + height1*cos(radians);
    CGFloat middleY1 = startPosition.y - height1*sin(radians);
    CGFloat middleX2 = startPosition.x + height2*cos(radians);
    CGFloat middleY2 = startPosition.y - height2*sin(radians);
    CGFloat middleX3 = startPosition.x + height3*cos(radians);
    CGFloat middleY3 = startPosition.y - height3*sin(radians);
    CGFloat middleX4 = startPosition.x + height4*cos(radians);
    CGFloat middleY4 = startPosition.y - height4*sin(radians);
    CGPoint middle1 = CGPointMake(middleX1, middleY1);
    CGPoint middle2 = CGPointMake(middleX2, middleY2);
    CGPoint middle3 = CGPointMake(middleX3, middleY3);
    CGPoint middle4 = CGPointMake(middleX4, middleY4);
    
    CGPoint leftPosition = CGPointMake(x, y);//上下方向角度互余
    CGPoint endPosition = view.layer.position;// 最后回归到起始点
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCGPoint:leftPosition],
                        [NSValue valueWithCGPoint:middle1],
                        [NSValue valueWithCGPoint:middle2],
                        [NSValue valueWithCGPoint:middle3],
                        [NSValue valueWithCGPoint:middle4],
                        [NSValue valueWithCGPoint:endPosition],
                        nil];
    
    animation.duration = speed;
    animation.cumulative = YES;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)lightSpeedInAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)flipInYAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = speed;
    
    NSArray *rotationArray = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:M_PI/2],
                              [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-30)],
                              [NSNumber numberWithFloat:DEGREES_TO_RADIANS(20)],
                              [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-10)],
                              [NSNumber numberWithFloat:0],
                              nil];
    NSMutableArray *transformArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < rotationArray.count; i++) {
        CATransform3D transform = view.layer.transform;
        transform.m34 = - 1.0 / 500.0;
        NSNumber *angle = rotationArray[i];
        transform = CATransform3DRotate(transform, angle.floatValue, 0, 1, 0);
        [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
    }
    animation.values = transformArray;
    
    [view.layer addAnimation:animation forKey:nil];
}

- (void)flipInXAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    rotationAnimation.duration = speed;
    
    NSArray *rotationArray = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:M_PI/2],
                              [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-30)],
                              [NSNumber numberWithFloat:DEGREES_TO_RADIANS(20)],
                              [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-10)],
                              [NSNumber numberWithFloat:0],
                              nil];
    NSMutableArray *transformArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < rotationArray.count; i++) {
        CATransform3D transform = view.layer.transform;
        transform.m34 = - 1.0 / 500.0;
        NSNumber *angle = rotationArray[i];
        transform = CATransform3DRotate(transform, angle.floatValue, 1, 0, 0);
        [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
    }
    rotationAnimation.values = transformArray;
    
    
    [view.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)rotateInAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    //透明度变化
    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.duration = speed/2;
    
    opacityAnim.values = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.1],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    
    [view.layer addAnimation:opacityAnim forKey:nil];
    
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.values = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:radians + M_PI],
                                [NSNumber numberWithFloat:radians + M_PI * 2.0],
                                nil];
    rotationAnimation.duration = speed;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.removedOnCompletion = YES;
    
    [view.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)stretchRightAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = speed;
    
    NSArray *rotationArray = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.95],
                              [NSNumber numberWithFloat:1.05],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    NSMutableArray *transformArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < rotationArray.count; i++) {
        CATransform3D transform = view.layer.transform;
        //                transform.m34 = - 1.0 / 500.0;
        NSNumber *scale = rotationArray[i];
        transform = CATransform3DScale(transform, scale.floatValue, 1.0 , 1.0);
        [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
        //                transform = CATransform3DMakeAffineTransform(CGAffineTransformScale(view.transform, scale.floatValue, 1.0));
        //                [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
        //                [transformArray addObject:[NSValue valueWithCGAffineTransform:CGAffineTransformScale(view.transform, angle.floatValue, 1.0)]];
//        CGRect rect = CGRectMake(0, 0, view.layer.bounds.size.width*scale.floatValue, view.layer.bounds.size.height);
//        [transformArray addObject:[NSValue valueWithCGRect:rect]];
    }
    animation.values = transformArray;
    
    CGPoint position = view.layer.position;
    self.animateViewPosition = position;
    view.layer.position = CGPointMake(position.x-view.layer.bounds.size.width/2*cos(radians), position.y-view.layer.bounds.size.width/2*sin(radians));
    view.layer.anchorPoint = CGPointMake(0, 0.5);
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)stretchLeftAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = speed;
    
    NSArray *rotationArray = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.95],
                              [NSNumber numberWithFloat:1.05],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    NSMutableArray *transformArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < rotationArray.count; i++) {
        CATransform3D transform = view.layer.transform;
        //                transform.m34 = - 1.0 / 500.0;
        NSNumber *scale = rotationArray[i];
        transform = CATransform3DScale(transform, scale.floatValue, 1.0 , 1.0);
        [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
        //                transform = CATransform3DMakeAffineTransform(CGAffineTransformScale(view.transform, scale.floatValue, 1.0));
        //                [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
        //                [transformArray addObject:[NSValue valueWithCGAffineTransform:CGAffineTransformScale(view.transform, angle.floatValue, 1.0)]];
//        CGRect rect = CGRectMake(0, 0, view.layer.bounds.size.width*scale.floatValue, view.layer.bounds.size.height);
//        [transformArray addObject:[NSValue valueWithCGRect:rect]];
    }
    animation.values = transformArray;
    
    CGPoint position = view.layer.position;
    self.animateViewPosition = position;
    view.layer.position = CGPointMake(position.x+view.layer.bounds.size.width/2*cos(radians), position.y+view.layer.bounds.size.width/2*sin(radians));
    view.layer.anchorPoint = CGPointMake(1, 0.5);
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)pullUpAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = speed;
    
    NSArray *rotationArray = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.95],
                              [NSNumber numberWithFloat:1.05],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    NSMutableArray *transformArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < rotationArray.count; i++) {
        CATransform3D transform = view.layer.transform;
        //                transform.m34 = - 1.0 / 500.0;
        NSNumber *scale = rotationArray[i];
        transform = CATransform3DScale(transform, 1.0, scale.floatValue, 1.0);
        [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
        //                transform = CATransform3DMakeAffineTransform(CGAffineTransformScale(view.transform, scale.floatValue, 1.0));
        //                [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
        //                [transformArray addObject:[NSValue valueWithCGAffineTransform:CGAffineTransformScale(view.transform, angle.floatValue, 1.0)]];
//        CGRect rect = CGRectMake(0, 0, view.layer.bounds.size.width, view.layer.bounds.size.height*scale.floatValue);
//        [transformArray addObject:[NSValue valueWithCGRect:rect]];
    }
    animation.values = transformArray;
    
    CGPoint position = view.layer.position;
    self.animateViewPosition = position;
    view.layer.position = CGPointMake(position.x-view.layer.bounds.size.height/2*sin(radians), position.y+view.layer.bounds.size.height/2*cos(radians));
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:nil];
}

- (void)pullDownAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = speed;
//    view.clipsToBounds = true;
    NSArray *rotationArray = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.95],
                              [NSNumber numberWithFloat:1.05],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    NSMutableArray *transformArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < rotationArray.count; i++) {
        CATransform3D transform = view.layer.transform;
        //                transform.m34 = - 1.0 / 500.0;
        NSNumber *scale = rotationArray[i];
        transform = CATransform3DScale(transform, 1.0, scale.floatValue, 1.0);
        [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
//                        transform = CATransform3DMakeAffineTransform(CGAffineTransformScale(view.transform, scale.floatValue, 1.0));
//                        [transformArray addObject:[NSValue valueWithCATransform3D:transform]];
//                        [transformArray addObject:[NSValue valueWithCGAffineTransform:CGAffineTransformScale(view.transform, scale.floatValue, 1.0)]];
//        CGRect rect = CGRectMake(0, 0, view.layer.bounds.size.width, view.layer.bounds.size.height*scale.floatValue);
//        [transformArray addObject:[NSValue valueWithCGRect:rect]];
    }
    animation.values = transformArray;
    
    CGPoint position = view.layer.position;
    self.animateViewPosition = position;
    view.layer.position = CGPointMake(position.x+view.layer.bounds.size.height/2*sin(radians), position.y-view.layer.bounds.size.height/2*cos(radians));
    view.layer.anchorPoint = CGPointMake(0.5, 0);
    animation.delegate = self;
    [view.layer addAnimation:animation forKey:nil];
}
- (void)pulseAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}
- (void)flashAnimationForView:(UIView *)view speed:(CGFloat)speed radians:(CGFloat)radians rotation:(NSInteger)rotation {
    
}

@end
