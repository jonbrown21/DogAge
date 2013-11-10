//
//  AppDelegate.m
//  Dog Age
//
//  Created by Jon Brown on 1/9/12.
//  Copyright (c) 2012 Food & Water Watch. All rights reserved.
//

#import "AppDelegate.h"
#import "WindowController.h"
#import "INWindowButton.h"
#import "PFMoveApplication.h"

@implementation AppDelegate
@synthesize popover, popcalc;



- (IBAction)showPopup:(id)sender {
    
    [[self popover] showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
}

- (IBAction)showCalc:(id)sender {
    
    [[self popcalc] showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.window.showsTitle = YES;
    self.window.titleTextColor = [NSColor whiteColor];
    self.window.showsBaselineSeparator = NO;
    self.window.titleBarHeight = 25.0;
    self.window.trafficLightButtonsLeftMargin = 7.0;
    self.window.trafficLightButtonsTopMargin = 0;
    self.window.titleTextShadow = NO;
    
    self.window.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow, CGRect drawingRect, CGPathRef clippingPath) {
        CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextAddPath(ctx, clippingPath);
        CGContextClip(ctx);
        
        NSGradient *gradient = nil;
        if (drawsAsMainWindow) {
            gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0 green:0 blue:0 alpha:1]
                                                     endingColor:[NSColor colorWithCalibratedRed:.3 green:.3 blue:.3 alpha:.7]];
            [[NSColor darkGrayColor] setFill];
        } else {
            // set the default non-main window gradient colors
            gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.851f alpha:1]
                                                     endingColor:[NSColor colorWithCalibratedWhite:0.929f alpha:1]];
            [[NSColor colorWithCalibratedWhite:0.6f alpha:1] setFill];
        }
        [gradient drawInRect:drawingRect angle:90];
        NSRectFill(NSMakeRect(NSMinX(drawingRect), NSMinY(drawingRect), NSWidth(drawingRect), 1));
    };
    
    [self setupCloseButton];
    [self setupMinimizeButton];
    [self setupZoomButton];
    
    PFMoveToApplicationsFolderIfNecessary();
}

- (void)setupCloseButton {
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    self.window.closeButton = closeButton;
}

- (void)setupMinimizeButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
    self.window.minimizeButton = button;
}

- (void)setupZoomButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    self.window.zoomButton = button;
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
return YES;
}

- (void)awakeFromNib {

    
NSString *path1 = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
NSString *html = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
[[[graphView mainFrame] frameView] setAllowsScrolling:NO];
[[graphView mainFrame] loadHTMLString:html baseURL:[[NSBundle mainBundle] resourceURL]];
[graphView setDrawsBackground:NO]; 
   
[MainWindow setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"winback.png"]]];
[graphView setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"winback.png"]]];
    
NSImage *arrows = [NSImage imageNamed:@"arrows.png"];

[arrowImage setImage: arrows];
    
NSImage *dogIcon = [NSImage imageNamed:@"dog-icon.png"];
[aButton setImage: dogIcon] ;
[aButton setAlternateImage: dogIcon] ;
    
[[TxtShddow cell] setBackgroundStyle:NSBackgroundStyleRaised];
[[TxtShddow2 cell] setBackgroundStyle:NSBackgroundStyleRaised];
[[TxtShddow3 cell] setBackgroundStyle:NSBackgroundStyleRaised];
[CalcText setStringValue:@"Dog Age"];

}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    
}

@end
