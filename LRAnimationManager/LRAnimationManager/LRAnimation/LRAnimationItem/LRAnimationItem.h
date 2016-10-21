//
//  AnimationItem.h
//  LLayerTest
//
//  Created by LR on 16/3/17.
//  Copyright © 2016年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LRAnimationItem;
typedef void (^ClickBlock)(LRAnimationItem *animationItem);

@interface LRAnimationItem : UIView

@property (nonatomic,copy) ClickBlock clickBlock;

@property (nonatomic,assign) BOOL selected;

@property (nonatomic,strong) UIImage *backgroundImage;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIImage *selectedImage;

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleL;


@end
