//
//  ViewController.m
//  BlurView
//
//  Created by Andrea Finollo on 22/03/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//

#import "ViewController.h"
#import "AFBlurView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;
@property (weak, nonatomic) IBOutlet AFBlurView *nibBlurView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFBlurView * blurView =[AFBlurView installAndMakeSubview:self.testView];
    self.nibBlurView.effectStyle =  UIBlurEffectStyleExtraLight;
    blurView.vibrancyEnabled = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
