//
//  Ball.h
//  hunter
//
//  Created by AAA on 11-6-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "Shape2DDeleGate.h"
@class BallRegion;
@class AnimatingLine;
@interface Ball : NSObject<Shape2DDeleGate> {
	float mX;
	float mY;	
	double mAngle;
	long int mLastUpdate;
	float mRadiusPixels;
	float mPixelsPerSecond;	
	BallRegion* mRegion;
}

@property float mX;
@property float mY;
@property float mRadiusPixels;
@property float mPixelsPerSecond;
@property double mAngle;
@property long int mLastUpdate;

-(id)initWithBallParams:(long int)now:(float)pixelsPerSecond:(float)x:(float)y:(double)angle:(float)radiusPixels;
-(float)getLeft;
-(float)getRight;
-(float)getTop;
-(float)getBottom;
-(BallRegion*)getRegion;
-(void)setRegion:(BallRegion*)region;
-(BOOL)isCircleOverlapping:(Ball*)otherBall;
-(BOOL)movingAwayFromEachother:(Ball*)ballA:(Ball*)ballB;
-(void)update:(long int)now;
-(void)bounceOffBottom;
-(void)bounceOffRight;
-(void)bounceOffTop;
-(void)bounceOffLeft;
-(NSString*)toString;
+(void)adjustForCollision:(Ball*)ballA:(Ball*)ballB;

-(BOOL)isIntersectingWithLine:(AnimatingLine*)iOther;
//+(Ball*)generateNewBall:(long int)now:(float)pixelsPerSecond:
//(float)x:(float)y:(double)angle:(float)radiusPixels;
@end
