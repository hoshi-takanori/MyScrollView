//
//  MyScrollView.m
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView ()

- (void)createScrollers;

- (void)scrolledHorizontally:(id)sender;
- (void)scrolledVertically:(id)sender;

@end

@implementation MyScrollView

@synthesize contentView;
@synthesize x, minX, maxX, knobX;
@synthesize y, minY, maxY, knobY;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self createScrollers];
    }
    return self;
}

- (void)createScrollers
{
    NSRect bounds = self.bounds;
    CGFloat scrollerWidth = [NSScroller scrollerWidth];
    NSRect horizontalRect = NSMakeRect(bounds.origin.x, bounds.origin.y,
                                       bounds.size.width - scrollerWidth, scrollerWidth);
    horizontalScroller = [[NSScroller alloc] initWithFrame:horizontalRect];
    horizontalScroller.autoresizingMask = NSViewWidthSizable | NSViewMaxYMargin;
    horizontalScroller.enabled = YES;
    horizontalScroller.action = @selector(scrolledHorizontally:);
    horizontalScroller.target = self;
    [self addSubview:horizontalScroller];
    NSRect verticalRect = NSMakeRect(bounds.origin.x + bounds.size.width - scrollerWidth, bounds.origin.y + scrollerWidth,
                                     scrollerWidth, bounds.size.height - scrollerWidth);
    verticalScroller = [[NSScroller alloc] initWithFrame:verticalRect];
    verticalScroller.autoresizingMask = NSViewMinXMargin | NSViewHeightSizable;
    verticalScroller.enabled = YES;
    verticalScroller.action = @selector(scrolledVertically:);
    verticalScroller.target = self;
    [self addSubview:verticalScroller];
}

- (void)setContentView:(NSView <MyScrollContent> *)view
{
    contentView = view;

    NSRect bounds = self.bounds;
    CGFloat scrollerWidth = [NSScroller scrollerWidth];
    view.frame = NSMakeRect(bounds.origin.x, bounds.origin.y + scrollerWidth,
                            bounds.size.width - scrollerWidth, bounds.size.height - scrollerWidth);
    view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [self addSubview:view];

    [view updateScrollValues:self];
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize
{
    [super resizeSubviewsWithOldSize:oldSize];
    [contentView updateScrollValues:self];
}

- (void)commitScrollValues
{
    horizontalScroller.doubleValue = (double) (x - minX) / (maxX - minX);
    horizontalScroller.knobProportion = (double) knobX / (maxX - minX);
    verticalScroller.doubleValue = (double) (y - minY) / (maxY - minY);
    verticalScroller.knobProportion = (double) knobY / (maxY - minY);
    [contentView scrollValueChanged:self];
}

- (void)scrolledHorizontally:(id)sender
{
    x = minX + horizontalScroller.doubleValue * (maxX - minX);
    [contentView scrollValueChanged:self];
}

- (void)scrolledVertically:(id)sender
{
    y = minY + verticalScroller.doubleValue * (maxY - minY);
    [contentView scrollValueChanged:self];
}

- (void)scrollWheel:(NSEvent *)event
{
    MyScrollValueType newX = x;
    MyScrollValueType newY = y;
    if ([event respondsToSelector:@selector(scrollingDeltaX)]) {
        newX += event.scrollingDeltaX;
        newY += event.scrollingDeltaY;
    } else {
        newX += event.deltaX;
        newY += event.deltaY;
    }
    newX = (newX < minX) ? minX : (newX > maxX) ? maxX : newX;
    newY = (newY < minY) ? minY : (newY > maxY) ? maxY : newY;
    if (newX != x || newY != y) {
        x = newX;
        y = newY;
        [self commitScrollValues];
    }
}

@end
