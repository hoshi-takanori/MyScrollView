//
//  MyScroller.h
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import <AppKit/AppKit.h>

@class MyScrollView;

@interface MyScroller : NSScroller {
    MyScrollView *scrollView;
    NSTrackingArea *trackingArea;

    CGFloat knobAlphaValue;
    CGFloat knobSlotAlphaValue;
}

@property (nonatomic, assign) MyScrollView *scrollView;
@property (nonatomic, assign) CGFloat knobAlphaValue;
@property (nonatomic, assign) CGFloat knobSlotAlphaValue;

+ (CGFloat)scrollerWidthForScrollerStyle:(NSScrollerStyle)scrollerStyle;

@end
