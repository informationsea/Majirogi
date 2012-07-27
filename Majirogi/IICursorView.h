//
//  IICursorView.h
//  Majirogi
//
//  Copyright (c) 2012年 Y.Okamura. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IICursorView : NSView {
    NSPoint cursorPoint;
    double diff;
    BOOL drawLast;
    double alpha;
    BOOL firstDraw;
}

- (void)setCursorPoint:(NSPoint) p;

@end
