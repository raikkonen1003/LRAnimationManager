//
//  AnimationOptionViewController.m
//  LLayerTest
//
//  Created by LR on 16/3/15.
//  Copyright © 2016年 LR. All rights reserved.
//

#import "LRAnimationOptionViewController.h"
#import "LRAnimationItemTapView.h"

// 屏幕宽高
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#define RESIZE(x) (x/375.f*CGRectGetWidth([UIScreen mainScreen].bounds))

#define COLOR_RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define BOTTOMTOOLSVIEW_HEIGHT RESIZE(153)


#define OPTION_HEIGHT             RESIZE(20)
#define ANIMATION_OPTION_HEIGHT   RESIZE(115)
#define SCROLLVIEW_HEIGHT         RESIZE(120)

#define OPTIONVIEW_HEIGHT         (OPTION_HEIGHT + SCROLLVIEW_HEIGHT) //加括号保证运算的优先级

#define ITEM_WIDTH                RESIZE(75)
#define SEPARATE_VIEW_WIDTH       RESIZE(37) //间隔

#define ANIMATION_ENUMS @[@"no_effect",@"fadeInNormal",@"fadeIn",@"expandOpen",@"zoomIn",@"zoomInDown",@"zoomInUp",@"slideExpandUp",@"rubberBand",@"shakeX",@"swingTop",@"shakeY",@"swingBottom",@"tossing",@"bounce",@"rotateInDownLeft",@"rotateInDownRight",@"rollIn",@"fadeInRight",@"fadeInLeft",@"fadeInUp",@"fadeInDown",@"moveRight",@"moveLeft",@"moveUp",@"moveDown",@"slideRight",@"slideLeft",@"slideUp",@"slideDown",@"lightSpeedIn",@"flipInY",@"flipInX",@"rotateIn",@"stretchRight",@"stretchLeft",@"pullUp",@"pullDown",@"pulse",@"flash"]
//,@"下落放大",@"上升放大",@"两侧弹开",@"两侧收缩",@"左右摇摆",@"上钟摆",@"上下摇摆",@"下钟摆",@"摇头晃脑",@"反弹" ,@"滚雪球" ,@"刹车" ,@"脉冲",@"闪烁"
#define OPTION_TEMP_ANIMATIONS   @[@"无效果",@"淡入",@"弹性放大",@"弹性缩小",@"放大",@"从左滚入",@"从右滚入",@"向左淡入",@"向右淡入",@"向上淡入",@"向下淡入",@"向右飞入",@"向左飞入",@"向上飞入",@"向下飞入",@"向右滑入",@"向左滑入",@"向上滑入",@"向下滑入",@"左右翻转",@"上下翻转",@"旋转出现",@"向右展开",@"向左展开",@"向上展开",@"向下展开"]
#define OPTION_ANIMATIONS   @[@"无效果",@"淡入",@"弹性放大",@"弹性缩小",@"放大",@"下落放大",@"上升放大",@"两侧弹开",@"两侧收缩",@"左右摇摆",@"上钟摆",@"上下摇摆",@"下钟摆",@"摇头晃脑",@"反弹",@"从左滚入",@"从右滚入",@"滚雪球",@"向左淡入",@"向右淡入",@"向上淡入",@"向下淡入",@"向右飞入",@"向左飞入",@"向上飞入",@"向下飞入",@"向右滑入",@"向左滑入",@"向上滑入",@"向下滑入",@"刹车",@"左右翻转",@"上下翻转",@"旋转出现",@"向右展开",@"向左展开",@"向上展开",@"向下展开",@"脉冲",@"闪烁"]
#define OPTION_IMAGES       @[@"LRAnimationImages.bundle/no_effect.png",@"LRAnimationImages.bundle/fadeInNormal.png",@"LRAnimationImages.bundle/fadeIn.png",@"LRAnimationImages.bundle/expandOpen.png",@"LRAnimationImages.bundle/zoomIn.png",@"LRAnimationImages.bundle/zoomInDown.png",@"LRAnimationImages.bundle/zoomInUp.png",@"LRAnimationImages.bundle/slideExpandUp.png",@"LRAnimationImages.bundle/rubberBand.png",@"LRAnimationImages.bundle/shakeX.png",@"LRAnimationImages.bundle/swingTop.png",@"LRAnimationImages.bundle/shakeY.png",@"LRAnimationImages.bundle/swingBottom.png",@"LRAnimationImages.bundle/tossing.png",@"LRAnimationImages.bundle/bounce.png",@"LRAnimationImages.bundle/rotateInDownLeft.png",@"LRAnimationImages.bundle/rotateInDownRight.png",@"LRAnimationImages.bundle/rollIn.png",@"LRAnimationImages.bundle/fadeInRight.png",@"LRAnimationImages.bundle/fadeInLeft.png",@"LRAnimationImages.bundle/fadeInUp.png",@"LRAnimationImages.bundle/fadeInDown.png",@"LRAnimationImages.bundle/moveRight.png",@"LRAnimationImages.bundle/moveLeft.png",@"LRAnimationImages.bundle/moveUp.png",@"LRAnimationImages.bundle/moveDown.png",@"LRAnimationImages.bundle/slideRight.png",@"LRAnimationImages.bundle/slideLeft.png",@"LRAnimationImages.bundle/slideUp.png",@"LRAnimationImages.bundle/slideDown.png",@"LRAnimationImages.bundle/lightSpeedIn.png",@"LRAnimationImages.bundle/flipInY.png",@"LRAnimationImages.bundle/flipInX.png",@"LRAnimationImages.bundle/rotateIn.png",@"LRAnimationImages.bundle/stretchRight.png",@"LRAnimationImages.bundle/stretchLeft.png",@"LRAnimationImages.bundle/pullUp.png",@"LRAnimationImages.bundle/pullDown.png",@"LRAnimationImages.bundle/pulse.png",@"LRAnimationImages.bundle/flash.png"]

@interface LRAnimationOptionViewController()<AnimationItemTapViewDelegate>

@property (nonatomic,strong) UIView *canvas;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) LRAnimationItemTapView *animationItemTapView;

@end

@implementation LRAnimationOptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configView];
}

- (void)configView {
    UIView *canvas = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - BOTTOMTOOLSVIEW_HEIGHT, SCREEN_WIDTH, BOTTOMTOOLSVIEW_HEIGHT)];
    canvas.backgroundColor = COLOR_RGB(26, 26, 26, .8);
    [self.view addSubview:canvas];
    _canvas = canvas;
    
    
    
    
//    1.左右滑动：确定UIScrollView的contentSize，如果UIScrollView中的内容填充满上下（即内容触到顶及底部）则实现了只能左右滑动
//    
//    2.上下滑动：确定UIScrollView的contentSize，如果UIScrollView中的内容填充满左右（即内容触到右部及左部）则实现了只能上下滑动
    //在这里内容没有触到顶及底部 要在上面加个view就可以保证 内容没有触到顶及底部的时候也可以不上下滚动，不得其解！！！
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, OPTION_HEIGHT)];
    [_canvas addSubview:view];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, OPTION_HEIGHT, SCREEN_WIDTH, SCROLLVIEW_HEIGHT)];
//        scrollView.backgroundColor = [UIColor yellowColor];
    [_canvas addSubview:scrollView];
    _scrollView = scrollView;

    
//    NSArray *animationsArray = OPTION_ANIMATIONS;
//    NSArray *imagesArray = OPTION_IMAGES;
    NSArray *animationsArray = OPTION_TEMP_ANIMATIONS;
    NSMutableArray *imagesTempArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < OPTION_TEMP_ANIMATIONS.count; i++) {
        NSString *str = OPTION_TEMP_ANIMATIONS[i];
        NSUInteger j = [OPTION_ANIMATIONS indexOfObject:str];
        [imagesTempArray addObject:OPTION_IMAGES[j]];
    }
    NSArray *imagesArray = [NSArray arrayWithArray:imagesTempArray];
    
    LRAnimationItemTapView *animationItemTapView = [[LRAnimationItemTapView alloc]initWithFrame:CGRectMake(0, 0, (ITEM_WIDTH+SEPARATE_VIEW_WIDTH/2)*animationsArray.count+SEPARATE_VIEW_WIDTH/2, ANIMATION_OPTION_HEIGHT) withDataArray:animationsArray withImageArray:imagesArray];
    animationItemTapView.delegate = self;
    [_scrollView addSubview:animationItemTapView];
    _scrollView.contentSize = CGSizeMake((ITEM_WIDTH+SEPARATE_VIEW_WIDTH/2)*animationsArray.count+SEPARATE_VIEW_WIDTH/2, SCROLLVIEW_HEIGHT);
    _animationItemTapView = animationItemTapView;
    
    [self configSelectedAnimation:self.selectedAnimation];
}

//设置已经选中的动画
- (void)configSelectedAnimation:(NSString *)animationName {
    if (!animationName) {//没有动画 新建控件 的情况
        return;
    }
    NSUInteger selectedIndex = [ANIMATION_ENUMS indexOfObject:animationName];
    NSUInteger selectedTempIndex = [OPTION_TEMP_ANIMATIONS indexOfObject:OPTION_ANIMATIONS[selectedIndex]];
    if (selectedTempIndex < OPTION_TEMP_ANIMATIONS.count) {
        [_animationItemTapView selectItemAtIndex:selectedTempIndex];
    }
}

#pragma mark- AnimationItemTapViewDelegate
- (void)didSelectAnimationItemTapView:(LRAnimationItemTapView *)animationItemTapView atIndex:(NSInteger)index {
    NSLog(@"didSelectAnimationItemTapView  index %lu",index);
    
    NSString *str = OPTION_TEMP_ANIMATIONS[index];
    NSUInteger selectTempIndex = [OPTION_ANIMATIONS indexOfObject:str];
    NSLog(@"didSelectAnimationItemTapView  selectTempIndex %lu",selectTempIndex);
    if (self.selectAnimationHandler) {
        self.selectAnimationHandler(selectTempIndex);
    }
}
- (void)didSelectAnimationItemTapView:(LRAnimationItemTapView *)animationItemTapView forAnimationSettingsAtIndex:(NSInteger)index {
    NSLog(@"本来就是选中的情况，弹出动画时间设置 index %lu",index);
}
#pragma mark-

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.dismissHandler)
    {
        self.dismissHandler();
    }
    //点击的位置
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    if (pt.y > 0 && pt.y < SCREEN_HEIGHT-BOTTOMTOOLSVIEW_HEIGHT) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}
@end
