//
//  MDActivityIndicatorView.h
//  ReputationRights
//
//  Created by Sargis_Gevorgyan on 12.02.15.
//  Copyright (c) 2015 MagicDevs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDActivityIndicatorViewDelegate;

@interface MDActivityIndicatorView : UIView

/** The number of circle indicators. */
@property (readwrite, nonatomic) NSUInteger numberOfCircles;

/** The spacing between circles. */
@property (readwrite, nonatomic) CGFloat internalSpacing;

/** The radius of each circle. */
@property (readwrite, nonatomic) CGFloat radius;

/** The base animation delay of each circle. */
@property (readwrite, nonatomic) CGFloat delay;

/** The base animation duration of each circle*/
@property (readwrite, nonatomic) CGFloat duration;

/** The assigned delegate */
@property (strong, nonatomic) id<MDActivityIndicatorViewDelegate> delegate;


/**
 Starts the animation of the activity indicator.
 */
- (void)startAnimating;

/**
 Stops the animation of the acitivity indciator.
 */
- (void)stopAnimating;

@end

@protocol MDActivityIndicatorViewDelegate <NSObject>

@optional

/**
 Gets the user-defined background color for a particular circle.
 @param activityIndicatorView The activityIndicatorView owning the circle.
 @param index The index of a particular circle.
 @return The background color of a particular circle.
 */
- (UIColor *)activityIndicatorView:(MDActivityIndicatorView *)activityIndicatorView
      circleBackgroundColorAtIndex:(NSUInteger)index;

@end
