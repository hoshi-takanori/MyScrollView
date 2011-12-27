//
//  MyScroller.m
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import "MyScroller.h"
#import "MyScrollView.h"

#define OVERLAY_SCROLLER_WIDTH 10

@implementation MyScroller

@synthesize scrollView;
@synthesize knobAlphaValue;
@synthesize knobSlotAlphaValue;

+ (BOOL)isCompatibleWithOverlayScrollers
{
    return YES;
}

+ (CGFloat)scrollerWidthForScrollerStyle:(NSScrollerStyle)scrollerStyle
{
    if (scrollerStyle == NSScrollerStyleOverlay) {
        // BUG: +[NSScroller scrollerWidthForControlSize:scrollerStyle:] returns 15 for NSScrollerStyleOverlay...
        return OVERLAY_SCROLLER_WIDTH;
    } else {
        return [NSScroller scrollerWidth];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    if ([self respondsToSelector:@selector(scrollerStyle)] && self.scrollerStyle == NSScrollerStyleOverlay) {
        [[NSColor clearColor] set];
        NSRectFill(NSInsetRect([self bounds], -1.0, -1.0));
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, knobSlotAlphaValue);
        [self drawKnobSlotInRect:[self rectForPart:NSScrollerKnobSlot] highlight:NO];
        CGContextSetAlpha(context, knobAlphaValue);
        [self drawKnob];
        CGContextRestoreGState(context);
    } else {
        [super drawRect:dirtyRect];
    }
}

- (void)updateTrackingAreas
{
    if (trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
        [trackingArea release];
    }
    if ([self respondsToSelector:@selector(scrollerStyle)]) {
        trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                    options:NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways
                                                      owner:self
                                                   userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
}

- (void)mouseEntered:(NSEvent *)theEvent
{
    [scrollView mouseEnteredScroller:self];
}

- (void)mouseExited:(NSEvent *)theEvent
{
    [scrollView mouseExitedScroller:self];
}

- (void)dealloc
{
    if (trackingArea != nil) {
        [self removeTrackingArea:trackingArea];
        [trackingArea release];
    }
    [super dealloc];
}

@end
