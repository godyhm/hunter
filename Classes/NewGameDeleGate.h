//
//  NewGameCallback.h
//  hunter
//
//  Created by AAA on 11-6-24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

/**
 * Used by dialogs to tell the activity the user wants a new game.
 */

@protocol NewGameDeleGate
    /**
     * The user wants to start a new game.
     */
-(void)onNewGame;

@end
