//
//  ViewController.m
//  LRAnimationManager
//
//  Created by LR on 16/10/19.
//  Copyright © 2016年 LR. All rights reserved.
//

#import "ViewController.h"
#import "LRAnimationOptionViewController.h"
#import "LRAnimationManager.h"
#import "BackView.h"

#define RESIZE(x) (x/375.f*CGRectGetWidth([UIScreen mainScreen].bounds))

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *testImageView;
@property (weak, nonatomic) IBOutlet UITextView *testTextView;

@property (nonatomic,strong) UIView *rotateBorderView;
@property (nonatomic,assign) NSInteger rotation;//旋转角度
@end

@implementation ViewController
- (IBAction)imageAnimationAction:(id)sender {
    [self changeAnimationOptionForView:self.testImageView];
}
- (IBAction)textAnimationAction:(id)sender {
    [self changeAnimationOptionForView:self.rotateBorderView];
}

- (void)changeAnimationOptionForView:(id)view {
    LRAnimationOptionViewController *animationVc = [[LRAnimationOptionViewController alloc]init];
    animationVc.selectAnimationHandler = ^(LRAnimationStyle style){
        LRAnimationManager *animationManager = [LRAnimationManager sharedInstance];
        [animationManager changeAnimationForView:view animationStyle:style rotation:_rotation speed:@"1"];
        
    };
    
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:animationVc];
    navi.navigationBar.hidden = YES;
    navi.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    navi.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;//保证ios7 模态弹出视图背景色不为黑色
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.testTextView sizeThatFits:CGSizeMake(240, 120)];
    self.testTextView.contentInset = UIEdgeInsetsMake(10, 25, 30, 25);
//    self.testTextView.layer.borderWidth = 10;
//    self.testTextView.layer.borderColor = [UIColor purpleColor].CGColor;
    
    
//    BackView *rotateBorderView = [[BackView alloc]init];
//    rotateBorderView.frame = CGRectMake(67.5-10, 224+128+20, 240+20, 108+20);
//    rotateBorderView.backgroundColor = [UIColor greenColor];
//    [rotateBorderView configView];
//    [self.view addSubview:rotateBorderView];
//    self.rotateBorderView = rotateBorderView;
    
    self.testTextView.hidden = YES;
    
    UIView *rotateBorderView = [[UIView alloc]init];
    rotateBorderView.frame = CGRectMake(67.5-5, 224+128+20 - 100, 240+20, 108+10);
    rotateBorderView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:rotateBorderView];
    self.rotateBorderView = rotateBorderView;
    
    UITextView *textView = [[UITextView alloc]init];
    CGRect frame = rotateBorderView.frame;
    textView.frame = CGRectMake(5, 5, frame.size.width-10, frame.size.height-10);
    textView.text = @"文本背景view分离";
    [rotateBorderView addSubview:textView];
    
    CGFloat lineWidth = 5;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.strokeColor = [UIColor purpleColor].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.lineWidth = lineWidth;
    borderLayer.lineCap = @"round";
    borderLayer.lineJoin = @"round";
    borderLayer.lineDashPattern = @[[NSNumber numberWithFloat:lineWidth/2], [NSNumber numberWithFloat:2*lineWidth]];//线条宽度+空白宽度
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, rotateBorderView.bounds.size.width-2*lineWidth/2, rotateBorderView.bounds.size.height-2*lineWidth/2);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    borderLayer.path = bezierPath.CGPath;
    
    [rotateBorderView.layer insertSublayer:borderLayer atIndex:0];
    
    _rotation = 0;
//    rotateBorderView.transform = CGAffineTransformRotate(rotateBorderView.transform, _rotation);
    rotateBorderView.layer.transform = CATransform3DRotate(rotateBorderView.layer.transform, _rotation/180.0*M_PI, 0.0, 0.0, 1.0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
