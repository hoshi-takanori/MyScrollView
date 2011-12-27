//
//  MyContentView.m
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import "MyContentView.h"

#define WIDTH 1024
#define HEIGHT 768
#define STEP 16

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
            rect = NSMakeRect(bounds.origin.x - x + i, bounds.origin.y + bounds.size.height - 1 + y - HEIGHT, 1, HEIGHT + 1);
        } else {
            rect = NSMakeRect(bounds.origin.x - x, bounds.origin.y + bounds.size.height - 1 + y - i, WIDTH + 1, 1);
        }
        [NSBezierPath fillRect:rect];
    }
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:self.bounds];

    [[NSColor grayColor] set];
    [self drawLines:YES from:0 to:WIDTH step:STEP];
    [self drawLines:NO from:0 to:HEIGHT step:STEP];

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
    scrollView.minX = - bounds.size.width / 2;
    scrollView.maxX = WIDTH - bounds.size.width / 2;
    scrollView.knobX = bounds.size.width;
    scrollView.minY = - bounds.size.height / 2;
    scrollView.maxY = HEIGHT - bounds.size.height / 2;
    scrollView.knobY = bounds.size.height;
    [scrollView commitScrollValues];
}

@end
