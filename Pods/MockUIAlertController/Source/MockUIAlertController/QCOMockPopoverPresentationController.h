//  MockUIAlertController by Jon Reid, https://qualitycoding.org/
//  Copyright 2019 Jonathan M. Reid. See LICENSE.txt

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

/*!
 * @abstract Same as UIPopoverPresentationController, but changing arrowDirection to readwrite.
 */
@interface QCOMockPopoverPresentationController : NSObject

@property (nullable, nonatomic, assign) id <UIPopoverPresentationControllerDelegate> delegate;

@property (nonatomic, assign) UIPopoverArrowDirection permittedArrowDirections;

@property (nullable, nonatomic, retain) UIView *sourceView;
@property (nonatomic, assign) CGRect sourceRect;

@property (nullable, nonatomic, retain) UIBarButtonItem *barButtonItem;

// Returns the direction the arrow is pointing on a presented popover. Before presentation, this returns UIPopoverArrowDirectionUnknown.
@property (nonatomic, assign) UIPopoverArrowDirection arrowDirection;

// By default, a popover disallows interaction with any view outside of the popover while the popover is presented.
// This property allows the specification of an array of UIView instances which the user is allowed to interact with
// while the popover is up.
@property (nullable, nonatomic, copy) NSArray *passthroughViews;

// Set popover background color. Set to nil to use default background color. Default is nil.
@property (nullable, nonatomic, copy) UIColor *backgroundColor;

// Clients may wish to change the available area for popover display. The default implementation of this method always
// returns insets which define 10 points from the edges of the display, and presentation of popovers always accounts
// for the status bar. The rectangle being inset is always expressed in terms of the current device orientation; (0, 0)
// is always in the upper-left of the device. This may require insets to change on device rotation.
@property (nonatomic, readwrite) UIEdgeInsets popoverLayoutMargins;

// Clients may customize the popover background chrome by providing a class which subclasses `UIPopoverBackgroundView`
// and which implements the required instance and class methods on that class.
@property (nullable, nonatomic, readwrite, strong) Class <UIPopoverBackgroundViewMethods> popoverBackgroundViewClass;

@end

NS_ASSUME_NONNULL_END
