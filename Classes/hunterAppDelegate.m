//
//  hunterAppDelegate.m
//  hunter
//
//  Created by AAA on 11-6-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "hunterAppDelegate.h"
#import "HunterViewController.h"
@implementation hunterAppDelegate

@synthesize window;

// The status bar is hidden using the UIStatusBarHidden entry in Info.plist
// The window is set up in the MainWindow nib file
@synthesize viewController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:
(NSDictionary *)launchOptions{
	
	/*
     Set up a view controller to manage the MoveMeView.
     Since the view controller has no custom behavior in this application, just use an instance of UIViewController.
     */
	HunterViewController *aViewController = [[HunterViewController alloc] initWithNibName:@"HunterViewController" bundle:[NSBundle mainBundle]];
	self.viewController = aViewController;
	[aViewController release];
	
	// Add the view controller's view as a subview of the window	
	self.window.rootViewController = self.viewController;
	/*
	 * these two lines will work as the same of above one line
	 *
	 * UIView *controllersView = [viewController view];
	 * [self.window addSubview:controllersView];
	 */
	[self.window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[viewController release];
    [window release];
    [super dealloc];
}


@end
