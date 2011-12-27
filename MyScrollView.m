//
//  MyScrollView.m
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import "MyScrollView.h"
#import "MyScroller.h"

@interface MyScrollView ()

- (void)createScrollers;
- (void)resizeContents:(NSNotification *)notification;

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

        if ([NSScroller respondsToSelector:@selector(preferredScrollerStyle)]) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(resizeContents:)
                                                         name:NSPreferredScrollerStyleDidChangeNotification
                                                       object:nil];
        }
    }
    return self;
}

- (void)createScrollers
{
    NSRect bounds = self.bounds;
    CGFloat scrollerWidth = [NSScroller scrollerWidth];

    horizontalScroller = [[MyScroller alloc] initWithFrame:NSMakeRect(0, 0, bounds.size.width, scrollerWidth)];
    horizontalScroller.autoresizingMask = NSViewWidthSizable | NSViewMaxYMargin;
    horizontalScroller.enabled = YES;
    horizontalScroller.action = @selector(scrolledHorizontally:);
    horizontalScroller.target = self;
    horizontalScroller.scrollView = self;
    [self addSubview:horizontalScroller];

    verticalScroller = [[MyScroller alloc] initWithFrame:NSMakeRect(0, 0, scrollerWidth, bounds.size.height)];
    verticalScroller.autoresizingMask = NSViewMinXMargin | NSViewHeightSizable;
    verticalScroller.enabled = YES;
    verticalScroller.action = @selector(scrolledVertically:);
    verticalScroller.target = self;
    verticalScroller.scrollView = self;
    [self addSubview:verticalScroller];
}

- (void)setContentView:(NSView <MyScrollContent> *)view
{
    if (view != contentView) {
        [contentView removeFromSuperview];
        [contentView release];

        contentView = [view retain];
        contentView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
        [self addSubview:contentView positioned:NSWindowBelow relativeTo:nil];

        [self resizeContents:nil];
    }
}

- (void)resizeContents:(NSNotification *)notification
{
    NSScrollerStyle scrollerStyle = NSScrollerStyleLegacy;
    CGFloat scrollerWidth;
    if ([NSScroller respondsToSelector:@selector(preferredScrollerStyle)]) {
        scrollerStyle = [NSScroller preferredScrollerStyle];
        horizontalScroller.scrollerStyle = scrollerStyle;
        verticalScroller.scrollerStyle = scrollerStyle;

        scrollerWidth = [MyScroller scrollerWidthForScrollerStyle:scrollerStyle];
        horizontalScroller.knobAlphaValue = 1;
        verticalScroller.knobAlphaValue = 1;
    } else {
        scrollerWidth = [NSScroller scrollerWidth];
    }

    NSRect bounds = self.bounds;
    horizontalScroller.frame = NSMakeRect(bounds.origin.x, bounds.origin.y,
                                          bounds.size.width - scrollerWidth, scrollerWidth);
    verticalScroller.frame = NSMakeRect(bounds.origin.x + bounds.size.width - scrollerWidth, bounds.origin.y + scrollerWidth,
                                        scrollerWidth, bounds.size.height - scrollerWidth);
    if (scrollerStyle == NSScrollerStyleLegacy) {
        contentView.frame = NSMakeRect(bounds.origin.x, bounds.origin.y + scrollerWidth,
                                       bounds.size.width - scrollerWidth, bounds.size.height - scrollerWidth);
    } else {
        contentView.frame = bounds;
    }

    [contentView updateScrollValues:self];
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize
{
    [super resizeSubviewsWithOldSize:oldSize];
    [contentView updateScrollValues:self];
}

- (void)commitScrollValues
{
    if (maxX < minX) { maxX = minX; }
    if (x < minX) { x = minX; }
    if (x > maxX) { x = maxX; }
    if (maxY < minY) { maxY = minY; }
    if (y < minY) { y = minY; }
    if (y > maxY) { y = maxY; }
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
        newX -= event.scrollingDeltaX;
        newY -= event.scrollingDeltaY;
    } else {
        newX -= event.deltaX;
        newY -= event.deltaY;
    }
    newX = (newX < minX) ? minX : (newX > maxX) ? maxX : newX;
    newY = (newY < minY) ? minY : (newY > maxY) ? maxY : newY;
    if (newX != x || newY != y) {
        x = newX;
        y = newY;
        [self commitScrollValues];
    }
}

- (void)viewWillStartLiveResize
{
    NSLog(@"viewWillStartLiveResize");
}

- (void)viewDidEndLiveResize
{
    NSLog(@"viewDidEndLiveResize");
}

- (void)mouseEnteredScroller:(MyScroller *)scroller
{
    NSLog(@"mouseEnteredScroller (%@)", scroller == horizontalScroller ? @"horizontal" : @"vertical");
}

- (void)mouseExitedScroller:(MyScroller *)scroller
{
    NSLog(@"mouseExitedScroller (%@)", scroller == horizontalScroller ? @"horizontal" : @"vertical");
}

- (void)dealloc
{
    if ([NSScroller respondsToSelector:@selector(preferredScrollerStyle)]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [contentView release];
    [horizontalScroller release];
    [verticalScroller release];
    [super dealloc];
}

@end
