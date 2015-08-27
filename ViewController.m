//
//  ViewController.m
//  DrawerAnimation
//
//  Created by LYXMAC on 15/8/27.
//  Copyright (c) 2015年 LYX. All rights reserved.
//
#import "FlipAnimationController.h"

#import "ViewController.h"

//继承代理
@interface ViewController ()<UIViewControllerTransitioningDelegate>{
    
     FlipAnimationController *_flipAnimationController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
  //初始化
      _flipAnimationController = [FlipAnimationController new];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
     UIViewController *toVC = segue.destinationViewController;
    //设置代理 
    toVC.transitioningDelegate = self;
    
}


//MARK: 实现代理  NS_AVAILABLE_IOS(7_0)  iOS7及以上

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    _flipAnimationController.reverse = YES;
    return _flipAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
      _flipAnimationController.reverse = NO;
    return _flipAnimationController;
    
}

@end
