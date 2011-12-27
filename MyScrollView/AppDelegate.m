//
//  AppDelegate.m
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import "AppDelegate.h"
#import "MyScrollView.h"
#import "MyContentView.h"

@implementation AppDelegate

@synthesize window;
@synthesize scrollView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    scrollView.minX = -200;
    scrollView.maxX = 400;
    scrollView.minY = -100;
    scrollView.maxY = 300;
    scrollView.contentView = [[[MyContentView alloc] init] autorelease];
}

- (void)dealloc
{
    [window release];
    [scrollView release];
    [super dealloc];
}

@end
