//
//  hunterAppDelegate.h
//  hunter
//
//  Created by AAA on 11-6-20.				
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HunterViewController;

@interface hunterAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	HunterViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) HunterViewController *viewController;
@end

