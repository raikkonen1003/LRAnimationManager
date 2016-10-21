//
//  AnimationItem.m
//  LLayerTest
//
//  Created by LR on 16/3/17.
//  Copyright © 2016年 LR. All rights reserved.
//

#import "LRAnimationItem.h"

#define RESIZE(x) (x/375.f*CGRectGetWidth([UIScreen mainScreen].bounds))
#define TITLE_HEIGHT     20
#define VERTICAL_SPACE   RESIZE(13)
#define HORIZONTAL_SPACE RESIZE(21/2)
#define TITLE_FONT       RESIZE(14)
#define IMAGE_WIDTH      RESIZE(54)
#define IMAGE_HEIGHT     RESIZE(54)

#define ITEM_WIDTH                RESIZE(75)

@implementation LRAnimationItem

- (instancetype)init {
    if (self = [super init]) {
        [self configView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configView];
    }
    return self;
}
- (void)configView {
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(HORIZONTAL_SPACE, VERTICAL_SPACE, IMAGE_WIDTH, IMAGE_HEIGHT)];
//    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+RESIZE(20), CGRectGetWidth(imageView.frame), TITLE_HEIGHT)];
    UILabel *titleL = [[UILabel alloc]init];
    titleL.font = [UIFont systemFontOfSize:TITLE_FONT];
    titleL.textColor = [UIColor whiteColor];
    titleL.textAlignment = NSTextAlignmentCenter;
//    titleL.center = CGPointMake(CGRectGetWidth(imageView.frame)/2, CGRectGetMaxY(imageView.frame)+RESIZE(20)+TITLE_HEIGHT/2);
    
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.frame.size.height)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.bounds.size.width, self.frame.size.height);
    _imageView = imageView;
    _titleL = titleL;
    _button = button;
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(titleL.frame), 0);//图片偏移
    
    [self addSubview:button];
    [self addSubview:imageView];
    [self addSubview:titleL];
    
    imageView.image = self.backgroundImage;
    titleL.text = self.title;
    
    [button setImage:self.selectedImage forState:UIControlStateSelected];
//    [button addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.selected = button.selected;
}
- (void)touchDownAction:(id)sender {
    NSLog(@"touchDownAction");
    [_button setImage:self.selectedImage forState:UIControlStateSelected];
}

#pragma mark -- set
- (void)setSelected:(BOOL)selected {
    if (_selected != selected) {
        _button.selected = selected;
        
        _selected = selected;
    }
    
}
- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (_backgroundImage != backgroundImage) {
        _imageView.image = backgroundImage;
        
        _backgroundImage = backgroundImage;
    }
}
- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _titleL.text = title;
        [_titleL sizeToFit];
        _titleL.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetMaxY(_imageView.frame)+RESIZE(20)+TITLE_HEIGHT/2);
        
        _title = title;
    }
}
- (void)setSelectedImage:(UIImage *)selectedImage {
    if (_selectedImage != selectedImage) {
        [_button setImage:selectedImage forState:UIControlStateSelected];
        
        _selectedImage = selectedImage;
    }
}
#pragma mark-

- (void)btnAction:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(self);
    }
    
    
//    UIButton *button = (UIButton *)sender;
//    
//    if (button.selected) {
//        
//    }else {
//        button.selected = !button.selected;
//    }
//    
//    self.selected = button.selected;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [_button addTarget:target action:action forControlEvents:controlEvents];
}

@end
