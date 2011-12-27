//
//  AppDelegate.h
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MyScrollView;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    MyScrollView *scrollView;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet MyScrollView *scrollView;

@end
