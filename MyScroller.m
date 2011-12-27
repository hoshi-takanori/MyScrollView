//
//  MyScroller.m
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import "MyScroller.h"

@implementation MyScroller

@synthesize knobAlphaValue;
@synthesize slotAlphaValue;

+ (BOOL)isCompatibleWithOverlayScrollers
{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    if ([self respondsToSelector:@selector(scrollerStyle)] && self.scrollerStyle == NSScrollerStyleOverlay) {
        [[NSColor clearColor] set];
        NSRectFill(NSInsetRect([self bounds], -1.0, -1.0));
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextSaveGState(context);
        CGContextSetAlpha(context, slotAlphaValue);
        [self drawKnobSlotInRect:[self rectForPart:NSScrollerKnobSlot] highlight:NO];
        CGContextSetAlpha(context, knobAlphaValue);
        [self drawKnob];
        CGContextRestoreGState(context);
    } else {
        [super drawRect:dirtyRect];
    }
}

@end
