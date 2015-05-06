//
//  AFBlurView.h
//  BlurView
//
//  Created by Andrea Finollo on 22/03/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFBlurView : UIView
@property (assign, nonatomic) UIBlurEffectStyle  effectStyle;
@property (assign, nonatomic, getter=isVibrancyEnabled) BOOL vibrancyEnabled;

+ (instancetype) installAndMakeSubview:(UIView*) view;


@end
