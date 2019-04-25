/*
 *  ActionMode.h
 *  hunter
 *
 *  Created by AAA on 11-7-9.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

/**
 * Keeps track of the mode of this view.
 */
typedef enum{
	
	/**
	 * The balls are bouncing around.
	 */
	Bouncing,
	
	/**
	 * The animation has stopped and the balls won't move around.  The user
	 * may not unpause it; this is used to temporarily stop games between
	 * levels, or when the game is over and the activity places a dialog up.
	 */
	Paused,
	
	/**
	 * Same as {@link #Paused}, but paints the word 'touch to unpause' on
	 * the screen, so the user knows he/she can unpause the game.
	 */
	PausedByUser
} ActionMode;