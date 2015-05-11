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
@property (weak, nonatomic) IBOutlet UIView * alreadyCreatedViewFromNib;
@property (weak, nonatomic) IBOutlet AFBlurView *viewFromNibWithVibrancy;
@property (weak, nonatomic) IBOutlet AFBlurView *viewFromNibWithOutVibrancy;
@property (weak, nonatomic)  AFBlurView *viewProgrammaticallyWithOutVibrancy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Install AFBlurView created in the storyboard
    [AFBlurView installAndMakeSubview:_alreadyCreatedViewFromNib];
    AFBlurView * blurView = [[AFBlurView alloc] initWithFrame:CGRectZero withEffectStyle:AFBlurEffectDark andVibrancy:NO];
    [self.view addSubview:blurView];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewProgrammaticallyWithOutVibrancy = blurView;
    NSDictionary * view = NSDictionaryOfVariableBindings(blurView);
    NSArray * vertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0)-[blurView(164)]-20-|" options:0 metrics:nil views:view];
    NSArray * horConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[blurView(120)]-20-|" options:0 metrics:nil views:view];
    [self.view addConstraints:vertConstraints];
    [self.view addConstraints:horConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
