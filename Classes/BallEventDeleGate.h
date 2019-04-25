//
//  BallEventCallBack.h
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
@class Ball;
@class AnimatingLine;

@protocol BallEventDeleGate
-(void)onBallHitsBall:(Ball*)ballA:(Ball*)ballB;
-(void)onBallHitsLine:(long int)when:(Ball*)ball:(AnimatingLine*)animatingLine;
@end
