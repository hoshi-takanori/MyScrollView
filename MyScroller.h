//
//  MyScroller.h
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import <AppKit/AppKit.h>

#import "MyScrollView.h"

@interface MyScroller : NSScroller {
    MyScrollView *scrollView;
    NSTrackingArea *trackingArea;

    BOOL knobSlotVisible;
}

@property (nonatomic, assign) MyScrollView *scrollView;

+ (NSScrollerStyle)preferredScrollerStyle;
+ (CGFloat)scrollerWidthForScrollerStyle:(NSScrollerStyle)scrollerStyle;

- (void)setState:(MyScrollViewState)state knobSlotState:(MyScrollViewState)knobSlotState;

@end
