//
//  IIAppDelegate.m
//  Majirogi
//
//  Copyright (c) 2012年 Y.Okamura. All rights reserved.
//

#import "IIAppDelegate.h"
#import "IICursorView.h"

@implementation IIAppDelegate

@synthesize statusMenu;

- (id)init
{
    if(self = [super init]){
        dictArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)awakeFromNib
{
    
}

- (void)redisplay:(id)obj
{
    for (NSDictionary *dict in dictArray) {
        IICursorView *view = dict[CURSOR_VIEW];
        NSWindow *fwindow = dict[FULL_WINDOW];
        [view setCursorPoint:[fwindow mouseLocationOutsideOfEventStream]];
    }
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@""];
    [statusItem setImage:[[NSImage alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForImageResource:@"statusicon"]]];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:statusMenu];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    for (NSScreen *screen in [NSScreen screens]) {
        IICursorView *cview = [[IICursorView alloc] initWithFrame:[screen frame]];
        NSWindow *fwindow = [[NSWindow alloc] initWithContentRect:[screen frame]
                                                        styleMask:NSBorderlessWindowMask
                                                          backing:NSBackingStoreBuffered
                                                            defer:NO];
        
        [fwindow setLevel:NSScreenSaverWindowLevel];
        [fwindow setBackgroundColor:[NSColor colorWithDeviceWhite:1 alpha:0]];
        [fwindow setIgnoresMouseEvents:YES];
        [fwindow setAcceptsMouseMovedEvents:YES];
        [fwindow setOpaque:NO];
        [fwindow setContentView:cview];
        [fwindow setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces |
         NSWindowCollectionBehaviorStationary |
         NSWindowCollectionBehaviorIgnoresCycle];
        
        [fwindow orderFront:self];
        
        NSDictionary *dict = @{SCREEN: screen,
                              CURSOR_VIEW: cview, FULL_WINDOW: fwindow};
        [dictArray addObject:dict];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1./60 target:self selector:@selector(redisplay:) userInfo:self repeats:YES];
}

@end
