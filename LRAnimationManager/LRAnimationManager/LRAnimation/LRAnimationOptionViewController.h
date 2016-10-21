//
//  AnimationOptionViewController.h
//  LLayerTest
//
//  Created by LR on 16/3/15.
//  Copyright © 2016年 LR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRAnimationManager.h"


typedef void (^DismissHandler)();
typedef void (^SelectAnimationHandler)(LRAnimationStyle index);

@interface LRAnimationOptionViewController : UIViewController

@property (nonatomic,copy) DismissHandler dismissHandler;
@property (nonatomic,copy) SelectAnimationHandler selectAnimationHandler;

@property (nonatomic,copy) NSString *selectedAnimation;
@end
