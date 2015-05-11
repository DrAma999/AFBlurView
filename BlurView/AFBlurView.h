//
//  AFBlurView.h
//  BlurView
//
//  Created by Andrea Finollo on 22/03/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AFBlurEffect) {
    AFBlurEffectExtraLight = 0,
    AFBlurEffectLight = 1,
    AFBlurEffectDark = 2,
    AFBlurEffectNumberOfEffects = 3
};

@interface AFBlurView : UIView

/**
 `AFBlurEffect` to apply on the `AFBlurView`. Default value is `AFBlurEffectDark`.
 */
@property (assign, nonatomic)  AFBlurEffect  blurEffect;

/**
 To be used just in Interface Builder: `AFBlurEffect` to apply on the `AFBlurView`. Default value is `AFBlurEffectDark`.
 0. ExtraLight
 1. Light
 2. Dark
 */
@property (assign, nonatomic) IBInspectable  NSInteger  blurEffectStyleNumber;


/**
 Enable vibrancy on the `AFBlurView`. Default value is YES.
 */
@property (assign, nonatomic, getter=isVibrancyEnabled) IBInspectable BOOL vibrancyEnabled;

/**
 Designated initilizer to create an `AFBlurView` programmtically
 
 @param frame Frame of the view.
 @param style `UIBlurEffectStyle` to apply on the `AFBlurView`.
 @param vibrancyEnabled Enable vibrancy on the `AFBlurView`.

 */
- (instancetype) initWithFrame:(CGRect)frame
               withEffectStyle:(AFBlurEffect) style
                   andVibrancy:(BOOL) vibrancyEnabled;

/**
 Use this class method when you already have a view and want to transform it in a `AFBlurView`.
 It simply takes the original view and add as subview of the `AFBlurView` keeping the original constaints.
 
 @param view The view you want to transform in `AFBlurView`.
 
 */
+ (instancetype) installAndMakeSubview:(UIView*) view;


@end
