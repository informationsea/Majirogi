//
//  IIAppDelegate.h
//  Majirogi
//
//  Copyright (c) 2012年 Y.Okamura. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class IICursorView;

#define FULL_WINDOW @"FULL_WINDOW"
#define CURSOR_VIEW @"CURSOR_VIEW"
#define SCREEN      @"SCREEN"

@interface IIAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *fullwindow;
    NSMenu *__weak statusMenu;
    
    IICursorView *cursorView;
    
    NSMutableArray *dictArray;
    NSStatusItem *statusItem;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSMenu * statusMenu;

@end
