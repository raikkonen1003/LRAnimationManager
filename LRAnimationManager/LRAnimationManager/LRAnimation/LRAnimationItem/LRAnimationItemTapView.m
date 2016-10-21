//
//  AnimationItemTapView.m
//  LLayerTest
//
//  Created by LR on 16/3/18.
//  Copyright © 2016年 LR. All rights reserved.
//

#import "LRAnimationItemTapView.h"
#import "LRAnimationItem.h"

#define RESIZE(x) (x/375.f*CGRectGetWidth([UIScreen mainScreen].bounds))
#define SEPARATE_VIEW_WIDTH       RESIZE(37) //间隔#define SEPARATE_VIEW_WIDTH       10 //间隔

@interface LRAnimationItemTapView()
@property (nonatomic,strong) NSMutableArray *animationItemsArray;
@end

@implementation LRAnimationItemTapView

- (instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withImageArray:(NSArray *)imageArray {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
//        self.backgroundColor = [UIColor whiteColor];
        _animationItemsArray = [NSMutableArray arrayWithCapacity:0];
        _dataArray = dataArray;
        _imageArray = imageArray;
        
        [self configView];
    }
    return self;
}

- (void)configView {
    float width = (self.frame.size.width - SEPARATE_VIEW_WIDTH/2*(_dataArray.count+1)) / _dataArray.count;
    
    
    for (int i = 0; i < _dataArray.count; i++) {
        LRAnimationItem *animationItem = [[LRAnimationItem alloc]initWithFrame:CGRectMake(SEPARATE_VIEW_WIDTH/2 + i*(width+SEPARATE_VIEW_WIDTH/2), 0, width, self.frame.size.height)];
        animationItem.backgroundImage = [UIImage imageNamed:(NSString *)_imageArray[i]];
        animationItem.title = _dataArray[i];
        animationItem.tag = i+1;
        
        if (i == 0) {//选中效果
            animationItem.selectedImage = [UIImage imageNamed:@"LRAnimationImages.bundle/selectedBack.png"];
        }else {
            animationItem.selectedImage = [UIImage imageNamed:@"LRAnimationImages.bundle/selectedBack.png"];
        }
        
//        [animationItem addTarget:self action:@selector(animationItemAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_animationItemsArray addObject:animationItem];
        [self addSubview:animationItem];
        
        //回调
        __weak typeof(self) weakSelf = self;
        [animationItem setClickBlock:^(LRAnimationItem *item){
//            if (item.selected) {
//                //本来就是选中的情况，弹出动画时间设置
//                if ([weakSelf.delegate respondsToSelector:@selector(didSelectAnimationItemTapView:forAnimationSettingsAtIndex:)]) {
//                    [weakSelf.delegate didSelectAnimationItemTapView:self forAnimationSettingsAtIndex:animationItem.tag-1];
//                }
//            }else{
//                if ([weakSelf.delegate respondsToSelector:@selector(didSelectAnimationItemTapView:atIndex:)]) {
//                    [weakSelf.delegate didSelectAnimationItemTapView:self atIndex:animationItem.tag-1];
//                }
//            }
            
            if ([weakSelf.delegate respondsToSelector:@selector(didSelectAnimationItemTapView:atIndex:)]) {
                [weakSelf.delegate didSelectAnimationItemTapView:self atIndex:animationItem.tag-1];
            }
            
            for (LRAnimationItem *subAnimationItem in weakSelf.animationItemsArray) {
                if (item == subAnimationItem) {
                    subAnimationItem.selected = YES;
                }else{
                    subAnimationItem.selected = NO;
                }
            }
        }];
    }
}

- (void)selectItemAtIndex:(NSInteger)index {
    LRAnimationItem *animationItem = _animationItemsArray[index];
    animationItem.selected = YES;
}


@end
