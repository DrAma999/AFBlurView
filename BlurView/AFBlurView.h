//
//  AFBlurView.h
//  BlurView
//
//  Created by Andrea Finollo on 22/03/15.
//  Copyright (c) 2014–2015 Cloud In Touch sas (http://cloudintouch.it)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
