	//
//  BallEngineCallBack.h
//  hunter
//
//  Created by AAA on 11-6-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

@class BallEngine;

/**
 * Callback notifying of events related to the ball engine.
 */
@protocol BallEngineDeleGate

/**
 * The engine has its dimensions and is ready to go.
 * @param ballEngine The ball engine.
 */
-(void)onEngineReady:(BallEngine*)ballEngine;

/**
 * A ball has hit a moving line.
 * @param ballEngine The engine.
 * @param x The x coordinate of the ball.
 * @param y The y coordinate of the ball.
 */
-(void)onBallHitsMovingLine:(BallEngine*)ballEngine:(float)x:(float)y;

/**
 * A line made it to the edges of its region, splitting off a new region.
 * @param ballEngine The engine.
 */
-(void)onAreaChange:(BallEngine*)ballEngine;


@end
