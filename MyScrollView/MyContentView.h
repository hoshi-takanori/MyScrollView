//
//  MyContentView.h
//  MyScrollView
//
//  Created by Hoshi Takanori on 11/12/27.
//  Copyright (c) 2011 -. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "MyScrollView.h"

@interface MyContentView : NSView <MyScrollContent> {
    MyScrollValueType x;
    MyScrollValueType y;
}

@end
