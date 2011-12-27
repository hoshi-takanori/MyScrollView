//
//  MyContentView.m
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import "MyContentView.h"

@implementation MyContentView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        // Initialization code here.
    }
    return self;
}

- (void)drawLines:(BOOL)horizontal from:(CGFloat)from to:(CGFloat)to step:(CGFloat)step
{
    CGRect bounds = self.bounds;
    for (CGFloat i = from; i <= to; i += step) {
        NSRect rect;
        if (horizontal) {
            rect = NSMakeRect(bounds.origin.x - x + i, bounds.origin.y, 1, bounds.size.height);
        } else {
            rect = NSMakeRect(bounds.origin.x, bounds.origin.y + bounds.size.height - 1 + y - i, bounds.size.width, 1);
        }
        [NSBezierPath fillRect:rect];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:self.bounds];

    [[NSColor grayColor] set];
    [self drawLines:YES from:-200 to:400 + self.bounds.size.width step:20];
    [self drawLines:NO from:-100 to:300 + self.bounds.size.height step:20];

    [[NSColor blackColor] set];
    NSString *string = [NSString stringWithFormat:@"x = %ld, y = %ld", x, y];
    NSRect bounds = self.bounds;
    [string drawAtPoint:NSMakePoint(10, bounds.origin.y + bounds.size.height - 20) withAttributes:nil];
}

- (void)scrollValueChanged:(MyScrollView *)scrollView
{
    x = scrollView.x;
    y = scrollView.y;
    [self setNeedsDisplay:YES];
}

- (void)updateScrollValues:(MyScrollView *)scrollView
{
    NSRect bounds = self.bounds;
    scrollView.knobX = bounds.size.width;
    scrollView.knobY = bounds.size.height;
    [scrollView commitScrollValues];
}

@end
