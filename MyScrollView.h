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

typedef enum {
    MyScrollViewStateNormal,
    MyScrollViewStateKnobsHighlighted,
    MyScrollViewStateHorizontalKnobSlot,
    MyScrollViewStateVerticalKnobSlot,
} MyScrollViewState;

@protocol MyScrollContent <NSObject>

- (void)updateScrollValues:(MyScrollView *)scrollView;
- (void)scrollValueChanged:(MyScrollView *)scrollView;

@end

@interface MyScrollView : NSView {
    NSView <MyScrollContent> *contentView;
    MyScroller *horizontalScroller;
    MyScroller *verticalScroller;

    MyScrollValueType x, minX, maxX, knobX, lineX, pageX;
    MyScrollValueType y, minY, maxY, knobY, lineY, pageY;

    MyScrollViewState state;
    BOOL overlayTimerStarted;
    NSTimer *fadeTimer;
}

@property (nonatomic, retain) IBOutlet NSView <MyScrollContent> *contentView;

@property (nonatomic, assign) MyScrollValueType x;
@property (nonatomic, assign) MyScrollValueType minX;
@property (nonatomic, assign) MyScrollValueType maxX;
@property (nonatomic, assign) MyScrollValueType knobX;
@property (nonatomic, assign) MyScrollValueType lineX;
@property (nonatomic, assign) MyScrollValueType pageX;

@property (nonatomic, assign) MyScrollValueType y;
@property (nonatomic, assign) MyScrollValueType minY;
@property (nonatomic, assign) MyScrollValueType maxY;
@property (nonatomic, assign) MyScrollValueType knobY;
@property (nonatomic, assign) MyScrollValueType lineY;
@property (nonatomic, assign) MyScrollValueType pageY;

- (void)commitScrollValues;

- (void)mouseEnteredScroller:(MyScroller *)scroller;
- (void)mouseExitedScroller:(MyScroller *)scroller;

@end
