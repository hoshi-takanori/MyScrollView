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
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor whiteColor] set];
    [NSBezierPath fillRect:self.bounds];

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
