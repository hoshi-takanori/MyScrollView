//
//  MyScrollView.h
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NSInteger MyScrollValueType;

@class MyScrollView;
@class MyScroller;

@protocol MyScrollContent <NSObject>

- (void)updateScrollValues:(MyScrollView *)scrollView;
- (void)scrollValueChanged:(MyScrollView *)scrollView;

@end

@interface MyScrollView : NSView {
    NSView <MyScrollContent> *contentView;
    MyScroller *horizontalScroller;
    MyScroller *verticalScroller;

    MyScrollValueType x, minX, maxX, knobX;
    MyScrollValueType y, minY, maxY, knobY;
}

@property (nonatomic, retain) IBOutlet NSView <MyScrollContent> *contentView;

@property (nonatomic, assign) MyScrollValueType x;
@property (nonatomic, assign) MyScrollValueType minX;
@property (nonatomic, assign) MyScrollValueType maxX;
@property (nonatomic, assign) MyScrollValueType knobX;

@property (nonatomic, assign) MyScrollValueType y;
@property (nonatomic, assign) MyScrollValueType minY;
@property (nonatomic, assign) MyScrollValueType maxY;
@property (nonatomic, assign) MyScrollValueType knobY;

- (void)commitScrollValues;

- (void)mouseEnteredScroller:(MyScroller *)scroller;
- (void)mouseExitedScroller:(MyScroller *)scroller;

@end
