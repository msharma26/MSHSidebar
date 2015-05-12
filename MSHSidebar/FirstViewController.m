//
//  FirstViewController.m
//  MSHSidebar
//
//  Created by Manu Sharma on 5/8/15.
//  Copyright (c) 2015 Westerlime Enterprises. All rights reserved.
//

#import "FirstViewController.h"

#define kSnapThreshold 40

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UIView *panningView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer* pgr = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handlePan:)];
    [self.panningView addGestureRecognizer:pgr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)handlePan:(UIPanGestureRecognizer*)pgr;
{
    if (pgr.state == UIGestureRecognizerStateChanged) {
        CGPoint center = pgr.view.center;
        CGPoint translation = [pgr translationInView:pgr.view];
        center = CGPointMake(center.x + translation.x,
                             center.y);
        NSLog(@"%f", center.x);
        pgr.view.center = center;
        [pgr setTranslation:CGPointZero inView:pgr.view];
        
    } else if (pgr.state == UIGestureRecognizerStateEnded) {
        [self snapView:pgr.view toView:self.view];



    }
}

-(void) snapView: (UIView*)topView toView: (UIView*) baseView{

    if (topView.center.x <= baseView.center.x+kSnapThreshold || topView.center.x <= baseView.center.x-kSnapThreshold){
        [UIView animateWithDuration:0.2 animations:^{
            topView.center = baseView.center;
        } completion:^(BOOL finished) {
            
        }];

    }
    
    else if (topView.center.x <=baseView.center.x*2 - kSnapThreshold || topView.center.x >=baseView.center.x*2 ) {
        CGPoint center = CGPointMake( baseView.center.x*2 +kSnapThreshold, baseView.center.y);
        [UIView animateWithDuration:0.2 animations:^{
            topView.center = center;
        } completion:^(BOOL finished) {
            
        }];

    }
    
}

@end
