//
//  IICursorView.m
//  Majirogi
//
//  Copyright (c) 2012年 Y.Okamura. All rights reserved.
//

#import "IICursorView.h"

@implementation IICursorView

#define CIRCLE_MIN_SIZE 20
#define CIRCLE_INCREASE (1./20)
#define START_ALPHA_DIFF 10
#define ALPHA_INCREASE (1./40)
#define ALPHA_DECREASE (1./14)

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        cursorPoint = NSMakePoint(-1, -1);
        drawLast = NO;
        diff = 0;
        alpha = 0;
        firstDraw = YES;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    double circleSize = CIRCLE_MIN_SIZE+diff*CIRCLE_INCREASE;
    double newalpha = (diff-START_ALPHA_DIFF)*ALPHA_INCREASE;
    if (newalpha > 1)
        newalpha = 1;
    else if (newalpha < 0)
        newalpha = 0;
    if (newalpha > alpha) {
        alpha = newalpha;
    }
    [path appendBezierPathWithOvalInRect:NSMakeRect(cursorPoint.x-circleSize,
                                                    cursorPoint.y-circleSize,
                                                    circleSize*2, circleSize*2)];
    [[NSColor colorWithCalibratedRed:1 green:1 blue:0 alpha:alpha] set];
    [path setLineWidth:10];
    [path stroke];
    [[NSColor colorWithCalibratedRed:1 green:0 blue:0 alpha:alpha] set];
    [path setLineWidth:5];
    [path stroke];
}

- (void)setCursorPoint:(NSPoint) p
{
    if (cursorPoint.x != p.x || cursorPoint.y != p.y || drawLast) {
        diff = sqrt(pow(cursorPoint.x - p.x, 2)+pow(cursorPoint.y - p.y, 2));
        alpha -= ALPHA_DECREASE;
        if (alpha < 0) {
            alpha = 0;
        }
        drawLast = alpha > 0;
        //NSLog(@"%f",diff);
        cursorPoint = p;
        if (firstDraw) {
            firstDraw = NO;
        } else {
            [self display];
        }
        
    }
}

@end
