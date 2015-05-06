//
//  AFBlurView.m
//  BlurView
//
//  Created by Andrea Finollo on 22/03/15.
//  Copyright (c) 2015 CloudInTouch. All rights reserved.
//

#import "AFBlurView.h"

@interface AFBlurView ()

@property (weak, nonatomic) UIVisualEffectView * blurView;
@property (weak, nonatomic) UIVisualEffectView * vibrancyView;
@property (weak, nonatomic) UIView * mainContentView;
@property (nonatomic, getter=areEffectViewAvailable) BOOL availableEffectView;
- (void) stretchToSuperView:(UIView*) view ;

@end

@implementation AFBlurView

- (void) awakeFromNib {
    [super awakeFromNib];
    //Remove subviews that are not Blurview and add them as subview of UIEffectView keeping constraints
    NSMutableArray * constraintsArray = @[].mutableCopy;
    for (UIView * view in self.subviews) {
        if (![view isKindOfClass:UIVisualEffectView.class]) {
            [constraintsArray addObjectsFromArray:ExternalConstraintsReferencingView(view)];
            [view removeFromSuperview];
            [self addSubview:view];
        }
    }
    [self swapConstraints:constraintsArray.copy];
}

- (void) setVibrancyEnabled:(BOOL)vibrancyEnabled {
    if (_vibrancyEnabled == vibrancyEnabled) {
        return;
    }
    UIView * mainView = self.mainContentView;

    if (vibrancyEnabled) {
        //Rifai il percroso di installazione
        [self installVibrancyView];
        [mainView removeFromSuperview];
        [self addSubviewToBlurContentView:mainView];

    }
    else {
        [self removeVibrancyView];
        self.vibrancyView = nil;
        [self addSubviewToBlurContentView:mainView];
    }
    self.mainContentView = mainView;

}

- (void) setEffectStyle:(UIBlurEffectStyle)effect {
    //Però qui rimuovo anche tutte le constrints e le subview... attenzione
    UIView * mainView = self.mainContentView;
    [self removeVibrancyView];
    [self removeBlurView];
    self.availableEffectView = NO;
    _effectStyle = effect;
    [self installViews];
    [self addSubviewToBlurContentView:mainView];
    self.mainContentView = mainView;
    [self stretchToSuperView:mainView];
    
}

- (void) installViews {
    [self installBlurViewWithStyle:self.effectStyle];
    [self installVibrancyView];
    self.availableEffectView = YES;
}

- (void) commonInit {
    _effectStyle = UIBlurEffectStyleDark;
    _vibrancyEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    [self installViews];
    UIView * mainView = [UIView new];
    mainView.translatesAutoresizingMaskIntoConstraints = NO;
    mainView.backgroundColor = [UIColor clearColor];
    [self addSubviewToBlurContentView:mainView];
    self.mainContentView = mainView;
    [self stretchToSuperView:mainView];
}

- (void) installVibrancyView {
    UIVibrancyEffect * vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:(UIBlurEffect*)self.blurView.effect];
    UIVisualEffectView * vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    vibrancyView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.blurView.contentView addSubview:vibrancyView];
    [self stretchToSuperView:vibrancyView];
    self.vibrancyView = vibrancyView;
}

- (void) removeVibrancyView {
    [self.vibrancyView removeFromSuperview];
}


- (void) installBlurViewWithStyle: (UIBlurEffectStyle)style {
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView * blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:blurView];
    [self stretchToSuperView:blurView];
    self.blurView = blurView;
}

- (void) removeBlurView{
    [self.blurView removeFromSuperview];
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void) addSubview:(UIView *)view {
    if (![self areEffectViewAvailable]) {
        [super addSubview:view];
    }
    else {
        [self.mainContentView addSubview:view];
    }
}

- (void) addSubviewToBlurContentView:(UIView*)view {
    if (self.vibrancyView) {
        [self.vibrancyView.contentView addSubview:view];
        return;
    }
    if (self.blurView) {
        [self.blurView.contentView addSubview:view];
        return;
    }
}

- (void) addSubviewToMainView:(UIView *)view {
    self.availableEffectView = NO;
    [self addSubview:view];
    self.availableEffectView = YES;
}

- (void) addConstraints:(NSArray *)constraints {
    if (![self areEffectViewAvailable]) {
        [super addConstraints:constraints];
    }
    else {
        [self addConstraintsToContentView:constraints];
    }

}

- (void) addConstraintsToContentView:(NSArray *)constraints {
    if (self.vibrancyView) {
        [self.vibrancyView.contentView addConstraints:constraints];
        return;
    }
    if (self.blurView) {
        [self.blurView.contentView addConstraints:constraints];
        return;
    }
}

- (void) addConstraintsToSelf:(NSArray *)constraints {
    self.availableEffectView = NO;
    [self addConstraints:constraints];
    self.availableEffectView = YES;
}

- (void) addConstraintToMainContentView:(NSArray*)constraints {
    [self.mainContentView addConstraints:constraints];
}



+ (instancetype) installAndMakeSubview:(UIView*) view {
    if (!view) {
        [NSException raise:@"View can't be nil" format:nil];
    }
    AFBlurView * effectView = [[self.class alloc]initWithFrame:CGRectZero];
    effectView.translatesAutoresizingMaskIntoConstraints = NO;
    UIView * oldView = view;
    UIView * superView = oldView.superview;
    //Search and copy oldView constraint
    NSArray * sizeConstraints = SizeConstraintsReferencingView(view);
    NSArray * externalConstraints = ExternalConstraintsReferencingView(view);
    [oldView removeConstraints:sizeConstraints];
    [oldView removeFromSuperview];
    oldView.backgroundColor = [UIColor clearColor];
    [effectView addSubview:oldView];
    NSMutableArray * constrArraySize = @[].mutableCopy;
    //Add those constraint to the superview or the same view
    [sizeConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * constr, NSUInteger idx, BOOL *stop) {
        //
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:constr.firstItem == oldView ? effectView : constr.firstItem
                                                                        attribute:constr.firstAttribute
                                                                        relatedBy:constr.relation
                                                                          toItem:constr.secondItem == oldView ? effectView : constr.secondItem
                                                                        attribute:constr.secondAttribute
                                                                        multiplier:constr.multiplier
                                                                        constant:constr.constant];
        [constrArraySize addObject:constraint];
    }];
    NSMutableArray * constrArray = @[].mutableCopy;
    
    [externalConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * constr, NSUInteger idx, BOOL *stop) {
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:constr.firstItem == oldView ? effectView : constr.firstItem
                                                                       attribute:constr.firstAttribute
                                                                       relatedBy:constr.relation
                                                                          toItem:constr.secondItem == oldView ? effectView : constr.secondItem
                                                                       attribute:constr.secondAttribute
                                                                      multiplier:constr.multiplier
                                                                        constant:constr.constant];
        [constrArray addObject:constraint];
    }];
    [superView addSubview:effectView];
    [effectView.superview addConstraints:constrArray];
    [effectView addConstraintsToSelf:constrArraySize];

    [effectView stretchToSuperView:oldView];
    return effectView;
}

- (void) swapConstraints:(NSArray*)constraints {
    NSMutableArray * constrArray = @[].mutableCopy;
    //Add those constraint to the superview or the same view
    [constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint * constr, NSUInteger idx, BOOL *stop) {
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:constr.firstItem == self ? [constr.secondItem superview] : constr.firstItem
                                                                       attribute:constr.firstAttribute
                                                                       relatedBy:constr.relation
                                                                          toItem:constr.secondItem == self ? [constr.firstItem superview] : constr.secondItem
                                                                       attribute:constr.secondAttribute
                                                                      multiplier:constr.multiplier
                                                                        constant:constr.constant];
        [constrArray addObject:constraint];
    }];
    [self addConstraintToMainContentView:constrArray];

}


#pragma Constraints Helper
#define IS_SIZE_ATTRIBUTE(ATTRIBUTE) [@[@(NSLayoutAttributeWidth), @(NSLayoutAttributeHeight)] containsObject:@(ATTRIBUTE)]


- (void) stretchToSuperView:(UIView*) view {
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view);
    NSString *formatTemplate = @"%@:|[view]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [view.superview addConstraints:constraints];
    }
    
}

// Test constraint against view
static BOOL ConstraintRefersToView(NSLayoutConstraint * constraint,UIView * theView)
{
    if (!theView)
        return NO;
    if (!constraint.firstItem) // shouldn't happen. Illegal
        return NO;
    if (constraint.firstItem == theView)
        return YES;
    if (!constraint.secondItem)
        return NO;
    if (constraint.secondItem == theView)
        return YES;
    return NO;
}

// Positioning constraints
static NSArray *ExternalConstraintsReferencingView(UIView *view)
{
    if (!view) return @[];
    
    NSMutableArray *superviews = [NSMutableArray array];
    UIView *superview = view.superview;
    while (superview != nil)
    {
        [superviews addObject:superview];
        superview = superview.superview;
    }
    
    NSMutableArray *constraints = [NSMutableArray array];
    for (UIView *superview in superviews)
        for (NSLayoutConstraint *constraint in superview.constraints)
        {
            if (![constraint.class isEqual:[NSLayoutConstraint class]])
                continue;
            
            if (ConstraintRefersToView(constraint, view))
                [constraints addObject:constraint];
        }
    
    return constraints.copy;
}

// Sizing constraints
static NSArray *InternalConstraintsReferencingView(UIView *view)
{
    if (!view) return @[];
    
    NSMutableArray *constraints = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in view.constraints)
    {
        if (![constraint.class isEqual:[NSLayoutConstraint class]])
            continue;
        
        if (ConstraintRefersToView(constraint, view))
            [constraints addObject:constraint];
    }
    
    return constraints.copy;
}


static NSArray *SizeConstraintsReferencingView(UIView* view){
    NSArray * internal = InternalConstraintsReferencingView(view);
    NSMutableArray * mutArr = @[].mutableCopy;
    [internal enumerateObjectsUsingBlock:^(NSLayoutConstraint * constr, NSUInteger idx, BOOL *stop) {
        if (IS_SIZE_ATTRIBUTE(constr.firstAttribute)) {
            [mutArr addObject:constr];
        }
    }];
    return mutArr.copy;
}


@end
