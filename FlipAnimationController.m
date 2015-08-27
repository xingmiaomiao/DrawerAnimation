//
//  BLAdTransitionController.m
//  prototype
//
//  Created by César Pinto Castillo on 12/06/13.
//  Copyright (c) 2013 Blocket. All rights reserved.
//

#import "FlipAnimationController.h"
#import "UIViewExt.h"


//#import <QuartzCore/QuartzCore.h>

@implementation FlipAnimationController

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 1. the usual stuff ...
    UIView* containerView = [transitionContext containerView];
     UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
   
   
    [containerView addSubview:toVC.view];
    
    
    CGRect initialFrame = [UIScreen mainScreen].bounds;
//    toView.frame = initialFrame;
    
    
    //1 设置将要去往的view的开始和终止位置（离屏幕左边）

    float toViewInitLeft = self.reverse ?  initialFrame.size.width:  0 ;
    float toViewFinalLeft = self.reverse ?  initialFrame.size.width/3: 0;
    
    
    toView.left=toViewInitLeft;
    

    
   //2 截图 初始view的截图 加上
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect shrunkenFrame = CGRectInset(fromVC.view.frame, fromVC.view.frame.size.width/4, fromVC.view.frame.size.height/4);
    CGRect fromFinalFrame = CGRectOffset(shrunkenFrame, 0, screenBounds.size.height);
    
    // create a snapshot
    UIView *intermediateView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    intermediateView.frame = fromVC.view.frame;
    [containerView addSubview:intermediateView];
    

    
    
    //3 初始view截图的开始和结束位置 及 view堆叠顺序
    float fromViewInitLeft = self.reverse ?  0:  initialFrame.size.width/3 ;
    float fromViewFinalLeft = self.reverse ? 0: initialFrame.size.width;
    
    intermediateView.left = fromViewInitLeft;
    
    if (self.reverse) {
        
         [containerView sendSubviewToBack:intermediateView];

    }else{
        
        [containerView bringSubviewToFront:intermediateView];
        
       
    }
    
    

    
    // 4 动画
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:0
                              animations:^{
                                  
                                  
             if (self.reverse) {
                 intermediateView.left = 0;
             }else{
                 intermediateView.left = fromViewFinalLeft;
             
             }
                                
            toView.left = toViewFinalLeft;
       
      } completion:^(BOOL finished) {
          [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
      }];
    
}



- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}

@end
