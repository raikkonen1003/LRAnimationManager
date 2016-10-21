//
//  AnimationItemTapView.h
//  LLayerTest
//
//  Created by LR on 16/3/18.
//  Copyright © 2016年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LRAnimationItemTapView;
@protocol AnimationItemTapViewDelegate <NSObject>

/**
 *  选中某个动画的时候的回调
 *
 *  @param animationItemTapView 点击的view
 *  @param index                index
 */
- (void)didSelectAnimationItemTapView:(LRAnimationItemTapView *)animationItemTapView atIndex:(NSInteger)index;
/**
 *  已经是选中状态的时候 再次点击弹出动画时间设置
 *
 *  @param animationItemTapView 点击的view
 *  @param index                index
 */
- (void)didSelectAnimationItemTapView:(LRAnimationItemTapView *)animationItemTapView forAnimationSettingsAtIndex:(NSInteger)index;

@end

@interface LRAnimationItemTapView : UIView

@property (nonatomic, weak) id<AnimationItemTapViewDelegate> delegate;
/**
 数据源
 */
@property (nonatomic, strong)NSArray *dataArray;
/**
 图片
 */
@property (nonatomic, strong)NSArray *imageArray;

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withImageArray:(NSArray *)imageArray;

- (void)selectItemAtIndex:(NSInteger)index;

@end
