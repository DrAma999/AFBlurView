# AFBlurView
A UIView subclass that supports UIVisualEffect without all the boiler plate code needed to create one and nest the view hierarchy.
It's really easy to use, you can use it in xib document, create one programmatically or install on an already placed view.

## Requirements
- iOS8 or above
- Autolayout

## Usage

### Directly in storyboard or .xib using Interface Builder
You can create `AFBlurView` directly in a xib document, by placing a `UIView` and changing the custom class in the identity inspector. Even if the best way is later add another subview with inside all the contents that you want to display `AFBlurView` will move all its single subviews into the blur/vibracy hidden content view by keeping the original constraints.
Using the attribute inspector is also possible to set the vibrancy effect (enabled/disabled) and the blur style.
Unfortunately the blur style is represented using integers:
- 0 = ExtraLightBlur
- 1 = LightBlur
- 2 = DarkBlur

### Installing it under an already existing `UIView`
Using the class method:
```objective-c
+ (instancetype) installAndMakeSubview:(UIView*) view;
```
is possible to make and already existing view with all its subviews be a subview of the blur/vibracy hidden content view by keeping the original constraints.

### Create it programmatically
Using that method is possible to create an `AFBlurView`
```objective-c
- (instancetype) initWithFrame:(CGRect)frame
               withEffectStyle:(AFBlurEffect) style
                   andVibrancy:(BOOL) vibrancyEnabled;
```

### Properties
To enable or disable the vibrancy effect use the property:
```objective-c
@property (assign, nonatomic, getter=isVibrancyEnabled) IBInspectable BOOL vibrancyEnabled;
```

To change the blur effect, use the property:
```objective-c
@property (assign, nonatomic)  AFBlurEffect  blurEffect;
```
`AFBlurEffect` is a remap of the `UIVisualEffect` enumeration and has these effect:
- AFBlurEffectExtraLight
- AFBlurEffectLight
- AFBlurEffectDark

### Install
Just copy the two files `AFBlurView` `.h` `.m`

## License 
`AFBlurView` is released under MIT license. See LICENSE for details.



