//
//  ViewController.m
//  UIAlertViewTesting
//
//  Created by Sebastian Strus on 2018-05-14.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@property (weak, nonatomic) IBOutlet UIButton *screenLockButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *setButton;

@property CGFloat brightness;
@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.screenLockButton.layer.borderWidth = 1.0f;
    self.screenLockButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.screenLockButton.layer.cornerRadius = 5.0f;
    
    self.saveButton.layer.borderWidth = 1.0f;
    self.saveButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.saveButton.layer.cornerRadius = 5.0f;
    
    self.setButton.layer.borderWidth = 1.0f;
    self.setButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.setButton.layer.cornerRadius = 5.0f;
    
    self.redView.alpha = 0.0f;
    self.redView.layer.cornerRadius = 8;
    
    _brightness = 1.0f;
    [[UIScreen mainScreen] setBrightness: 1.0f];
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.blackView addGestureRecognizer:singleFingerTap];
    
    
    UISwipeGestureRecognizer *gestureRecognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightHandler:)];
    [gestureRecognizer1 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.blackView addGestureRecognizer:gestureRecognizer1];
    
    UISwipeGestureRecognizer *gestureRecognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftHandler:)];
    [gestureRecognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.blackView addGestureRecognizer:gestureRecognizer2];
    
    UISwipeGestureRecognizer *gestureRecognizer3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownHandler:)];
    [gestureRecognizer3 setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.blackView addGestureRecognizer:gestureRecognizer3];
}

-(void)swipeLeftHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe left");
    if (self.redView.alpha == 0.0f) {
        self.redView.alpha = 1.0f;
    } else {
        self.redView.alpha = 0.0f;
    };
}

-(void)swipeRightHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe right");
    [_blackView removeFromSuperview];
}

-(void)swipeDownHandler:(UISwipeGestureRecognizer *)recognizer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 0.4
                                             target: self
                                           selector: @selector(handleTimer:)
                                           userInfo: nil
                                            repeats: YES];
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)setScreenLock:(UIButton *)sender {
    NSLog(@"Set screen lock");
    //[self.view.layer insertSublayer:_blackView atIndex:0];//.insertSublayer(gradient, at: 0)
    [self.view addSubview:self.blackView];

    
}
- (IBAction)saveCurrentBrightness:(UIButton *)sender {
    _brightness = [UIScreen mainScreen].brightness;
}
- (IBAction)setSavedBrightness:(UIButton *)sender {
    [[UIScreen mainScreen] setBrightness: _brightness];
}


- (void)makeDark {
    [[UIScreen mainScreen] setBrightness: 0.0f];
}
- (void)makeBright {
    [[UIScreen mainScreen] setBrightness: 1.0f];
}


-(void)handleTimer:(NSTimer *)timer {
    NSLog(@"Begin pulse");
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^ {
                         self.redView.alpha = 0.3;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2 animations:^ {
                             self.redView.alpha = 1.0;
                         }];
                     }];
}



- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    if ([UIScreen mainScreen].brightness == 0.0f) {
        [self makeBright];
    } else {
        [self makeDark];
    }
}








@end
