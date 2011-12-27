//
//  MyScroller.h
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface MyScroller : NSScroller {
    CGFloat knobAlphaValue;
    CGFloat slotAlphaValue;
}

@property (nonatomic, assign) CGFloat knobAlphaValue;
@property (nonatomic, assign) CGFloat slotAlphaValue;

@end
