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
    
    // Create programmatically
    AFBlurView * blurView = [[AFBlurView alloc] initWithFrame:CGRectZero withEffectStyle:AFBlurEffectDark andVibrancy:NO];
    [self.view addSubview:blurView];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    self.viewProgrammaticallyWithOutVibrancy = blurView;
    NSDictionary * view = NSDictionaryOfVariableBindings(blurView,_viewFromNibWithOutVibrancy);
    NSArray * vertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_viewFromNibWithOutVibrancy]-21-[blurView]" options:0 metrics:nil views:view];
    NSArray * horConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[blurView]-16-|" options:0 metrics:nil views:view];
    [self.view addConstraints:vertConstraints];
    [self.view addConstraints:horConstraints];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    label.text = @"AFBlurView created programmatically, dark style vibrancy OFF";
    label.textColor = [UIColor whiteColor];
    [self.viewProgrammaticallyWithOutVibrancy addSubview:label];
    view = NSDictionaryOfVariableBindings(label);
    vertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[label]-8-|" options:0 metrics:nil views:view];
    horConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[label]-8-|" options:0 metrics:nil views:view];
    [self.viewProgrammaticallyWithOutVibrancy addConstraints:[vertConstraints arrayByAddingObjectsFromArray:horConstraints]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
