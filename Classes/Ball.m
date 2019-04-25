//
//  Ball.m
//  hunter
//
//  Created by AAA on 11-6-22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


//#import "Shape2D.h"
#import "AnimatingLine.h"
#import "Ball.h"
#import <math.h>
/**
 * A ball has a current location, a trajectory angle, a speed in pixels per
 * second, and a last update time.  It is capable of updating itself based on
 * its trajectory and speed.
 *
 * It also knows its boundaries, and will 'bounce' off them when it reaches them.
 */
@implementation Ball

@synthesize mX;
@synthesize mY;
@synthesize mRadiusPixels;
@synthesize mAngle;
@synthesize mLastUpdate;
@synthesize mPixelsPerSecond;

//private Ball(long now, float pixelsPerSecond, float x, float y,
//			 double angle, float radiusPixels) {
//	mLastUpdate = now;
//	mPixelsPerSecond = pixelsPerSecond;
//	mX = x;
//	mY = y;
//	mAngle = angle;
//	mRadiusPixels = radiusPixels;
//}
-(id)initWithBallParams:(long int)now:(float)pixelsPerSecond:
(float)x:(float)y:(double)angle:(float)radiusPixels
{
    self = [super init];
    if(self)
	{
		mX = x;
		mY = y;
		mAngle = angle;
		mLastUpdate = now;
		mRadiusPixels = radiusPixels;
	    mPixelsPerSecond=pixelsPerSecond;		
	}
	return self;
}

//public float getX() {
//	return mX;
//}
//
//public float getY() {
//	return mY;
//}
//
//public float getRadiusPixels() {
//	return mRadiusPixels;
//}
//
//public double getAngle() {
//	return mAngle;
//}
//public void setNow(long now) {
//	mLastUpdate = now;
//}



//public float getLeft() {
//	return mX - mRadiusPixels;
//}
-(float)getLeft
{
	return mX - mRadiusPixels;
}


//public float getRight() {
//	return mX + mRadiusPixels;
//}
-(float)getRight
{
	return mX + mRadiusPixels;
}

//public float getTop() {
//	return mY - mRadiusPixels;
//}
-(float)getTop
{
	return mY - mRadiusPixels;
}

//public float getBottom() {
//	return mY + mRadiusPixels;
//}
-(float)getBottom
{
	return mY + mRadiusPixels;
}

/**
 * Get the region the ball is contained in.
 */
//public Shape2d getRegion() {
//	return mRegion;
//}
-(BallRegion*)getRegion
{
	return mRegion;
}

/**
 * Set the region that the ball is contained in.
 * @param region The region.
 */
//public void setRegion(Shape2d region) {
//	if (mX < region.getLeft()) {
//		mX = region.getLeft();
//		bounceOffLeft();
//	} else if (mX > region.getRight()) {
//		mX = region.getRight();
//		bounceOffRight();
//	}
//	if (mY < region.getTop()) {
//		mY = region.getTop();
//		bounceOffTop();
//	} else if (mY > region.getBottom()) {
//		mY = region.getBottom();
//		bounceOffBottom();
//	}
//	mRegion = region;
//}
-(void)setRegion:(BallRegion*)region
{
	if (mX < [region getLeft]) {
		mX = [region getLeft];
		[self bounceOffLeft];
	} else if (mX > [region getRight]) {
		mX = [region getRight];
		[self bounceOffRight];
	}
	if (mY < [region getTop]) {
		mY = [region getTop];
		[self bounceOffTop];
	} else if (mY > [region getBottom]) {
		mY = [region getBottom];
		[self bounceOffBottom];
	}
	mRegion = region;
}

//public boolean isCircleOverlapping(Ball otherBall) {
//	final float dy = otherBall.mY - mY;
//	final float dx = otherBall.mX - mX;
//	
//	final float distance = dy * dy + dx * dx;
//	
//	return (distance < ((2 * mRadiusPixels) * (2 *mRadiusPixels)))
//	// avoid jittery collisions
//	&& !movingAwayFromEachother(this, otherBall);
//}
-(BOOL)isCircleOverlapping:(Ball*)otherBall
{
	const float dy = otherBall.mY - mY;
	const float dx = otherBall.mX - mX;
	
	const float distance = dy * dy + dx * dx;
	
	return (distance < ((2 * mRadiusPixels) * (2 *mRadiusPixels)))
	// avoid jittery collisions
	&& ![self movingAwayFromEachother:self:otherBall];
}

//private boolean movingAwayFromEachother(Ball ballA, Ball ballB) {
//	double collA = Math.atan2(ballB.mY - ballA.mY, ballB.mX - ballA.mX);
//	double collB = Math.atan2(ballA.mY - ballB.mY, ballA.mX - ballB.mX);
//	
//	double ax = Math.cos(ballA.mAngle - collA);
//	double bx = Math.cos(ballB.mAngle - collB);
//	
//	return ax + bx < 0;        
//}
-(BOOL)movingAwayFromEachother:(Ball*)ballA:(Ball*)ballB
{
	double collA = atan2((double)(ballB.mY - ballA.mY),(double)(ballB.mX - ballA.mX));
	double collB = atan2((double)(ballA.mY - ballB.mY),(double)(ballA.mX - ballB.mX));
	
	double ax = acosh((double)(ballA.mAngle - collA));
	double bx = acosh((double)(ballB.mAngle - collB));
	
	return (ax + bx) < 0; 
}

//public void update(long now) {
//	if (now <= mLastUpdate) return;
//	
//	// bounce when at walls
//	if (mX <= mRegion.getLeft() + mRadiusPixels) {
//		// we're at left wall
//		mX = mRegion.getLeft() + mRadiusPixels;
//		bounceOffLeft();
//	} else if (mY <= mRegion.getTop() + mRadiusPixels) {
//		// at top wall
//		mY = mRegion.getTop() + mRadiusPixels;
//		bounceOffTop();
//	} else if (mX >= mRegion.getRight() - mRadiusPixels) {
//		// at right wall
//		mX = mRegion.getRight() - mRadiusPixels;
//		bounceOffRight();
//	} else if (mY >= mRegion.getBottom() - mRadiusPixels) {
//		// at bottom wall
//		mY = mRegion.getBottom() - mRadiusPixels;
//		bounceOffBottom();
//	}
//	
//	float delta = (now - mLastUpdate) * mPixelsPerSecond;
//	delta = delta / 1000f;
//	
//	mX += (delta * Math.cos(mAngle));
//	mY += (delta * Math.sin(mAngle));
//	
//	mLastUpdate = now;
//}
-(void)update:(long int)now
{
	if (now <= mLastUpdate) return;
	
	// bounce when at walls
	if (mX <= [mRegion getLeft] + mRadiusPixels) {
		// we're at left wall
		mX = [mRegion getLeft] + mRadiusPixels;
		[self bounceOffLeft];
	} else if (mY <= [mRegion getTop] + mRadiusPixels) {
		// at top wall
		mY = [mRegion getTop] + mRadiusPixels;
		[self bounceOffTop];
	} else if (mX >= [mRegion getRight] - mRadiusPixels) {
		// at right wall
		mX = [mRegion getRight] - mRadiusPixels;
		[self bounceOffRight];
	} else if (mY >= [mRegion getBottom] - mRadiusPixels) {
		// at bottom wall
		mY = [mRegion getBottom] - mRadiusPixels;
		[self bounceOffBottom];
	}
	
	float delta = (now - mLastUpdate) * mPixelsPerSecond;
	//delta = delta / 1000.0f;
	delta = delta / 3.0f;
	mX += (delta * (cosf((float)mAngle)));
	mY += (delta * (sinf((float)mAngle)));
	
	mLastUpdate = now;
}

//private void bounceOffBottom() {
//	if (mAngle < 0.5*Math.PI) {
//		// going right
//		mAngle = -mAngle;
//	} else {
//		// going left
//		mAngle += (Math.PI - mAngle) * 2;
//	}
//}
-(void)bounceOffBottom
{
	if (mAngle < 0.5*M_PI) {
		// going right
		mAngle = -mAngle;
	} else {
		// going left
		mAngle += (M_PI - mAngle) * 2;
	}
}

//private void bounceOffRight() {
//	if (mAngle > 1.5*Math.PI) {
//		// going up
//		mAngle -= (mAngle - 1.5*Math.PI) * 2;
//	} else {
//		// going down
//		mAngle += (.5*Math.PI - mAngle) * 2;
//	}
//}
-(void)bounceOffRight
{
	if (mAngle > 1.5*M_PI) {
		// going up
		mAngle -= (mAngle - 1.5*M_PI) * 2;
	} else {
		// going down
		mAngle += (0.5*M_PI - mAngle) * 2;
	}
}

//private void bounceOffTop() {
//	if (mAngle < 1.5 * Math.PI) {
//		// going left
//		mAngle -= (mAngle - Math.PI) * 2;
//	} else {
//		// going right
//		mAngle += (2*Math.PI - mAngle) * 2;
//		mAngle -= 2*Math.PI;
//	}
//}
-(void)bounceOffTop
{
	if (mAngle < 1.5 * M_PI) {
		// going left
		mAngle -= (mAngle - M_PI) * 2;
	} else {
		// going right
		mAngle += (2*M_PI - mAngle) * 2;
		mAngle -= 2*M_PI;
	}
}

//private void bounceOffLeft() {
//	if (mAngle < Math.PI) {
//		// going down
//		mAngle -= ((mAngle - (Math.PI / 2)) * 2);
//	} else {
//		// going up
//		mAngle += (((1.5 * Math.PI) - mAngle) * 2);
//	}
//}
-(void)bounceOffLeft
{
	if (mAngle < M_PI) {
		// going down
		mAngle -= ((mAngle - (M_PI / 2)) * 2);
	} else {
		// going up
		mAngle += (((1.5 * M_PI) - mAngle) * 2);
	}	
}

//public String toString() {
//	return String.format(
//						 "Ball(x=%f, y=%f, angle=%f)",
//						 mX, mY, Math.toDegrees(mAngle));
//}
-(NSString*)toString
{
	NSString* str = [[NSString alloc] initWithString:[NSString 
		stringWithFormat:@"Ball(x=%f, y=%f, angle=%f)",mX, mY, mAngle]];
	[str autorelease];
	return str;
}


/**
 * Given that ball a and b have collided, adjust their angles to reflect their state
 * after the collision.
 *
 * This method works based on the conservation of energy and momentum in an elastic
 * collision.  Because the balls have equal mass and speed, it ends up being that they
 * simply swap velocities along the axis of the collision, keeping the velocities tangent
 * to the collision constant.
 *
 * @param ballA The first ball in a collision
 * @param ballB The second ball in a collision
 */
//public static void adjustForCollision(Ball ballA, Ball ballB) {
//	
//	final double collA = Math.atan2(ballB.mY - ballA.mY, ballB.mX - ballA.mX);
//	final double collB = Math.atan2(ballA.mY - ballB.mY, ballA.mX - ballB.mX);
//	
//	final double ax = Math.cos(ballA.mAngle - collA);
//	final double ay = Math.sin(ballA.mAngle - collA);
//	
//	final double bx = Math.cos(ballB.mAngle - collB);
//	final double by = Math.cos(ballB.mAngle - collB);
//	
//	final double diffA = Math.atan2(ay, -bx);
//	final double diffB = Math.atan2(by, -ax);
//	
//	ballA.mAngle = collA + diffA;
//	ballB.mAngle = collB + diffB;
//}
+(void)adjustForCollision:(Ball*)ballA:(Ball*)ballB
{
	const double collA = atan2((double)(ballB.mY - ballA.mY),(double)(ballB.mX - ballA.mX));
	const double collB = atan2((double)(ballA.mY - ballB.mY),(double)(ballA.mX - ballB.mX));
	
	const double ax = cosh((double)(ballA.mAngle - collA));
	const double ay = sinh((double)(ballA.mAngle - collA));
	
	const double bx = cosh((double)(ballB.mAngle - collB));
	const double by = cosh((double)(ballB.mAngle - collB));
	
	const double diffA = atan2(ay,-bx);
	const double diffB = atan2(by,-ax);
	
	
	ballA.mAngle = collA + diffA;
	ballB.mAngle = collB + diffB;
}

/**
 * A more readable way to create balls than using a 5 param
 * constructor of all numbers.
 */
//public static class Builder {
//	private long mNow = -1;
//	private float mX = -1;
//	private float mY = -1;
//	private double mAngle = -1;
//	private float mRadiusPixels = -1;
//	
//	private float mPixelsPerSecond = 45f;
//	
//	public Ball create() {
//		if (mNow < 0) {
//			throw new IllegalStateException("must set 'now'");
//		}
//		if (mX < 0) {
//			throw new IllegalStateException("X must be set");
//		}
//		if (mY < 0) {
//			throw new IllegalStateException("Y must be stet");
//		}
//		if (mAngle < 0) {
//			throw new IllegalStateException("angle must be set");
//		}
//		if (mAngle > 2 * Math.PI) {
//			throw new IllegalStateException("angle must be less that 2Pi");
//		}
//		if (mRadiusPixels <= 0) {
//			throw new IllegalStateException("radius must be set");
//		}
//		return new Ball(mNow, mPixelsPerSecond, mX, mY, mAngle, mRadiusPixels);
//	}
//	
//	public Builder setNow(long now) {
//		mNow = now;
//		return this;
//	}
//	
//	public Builder setPixelsPerSecond(float pixelsPerSecond) {
//		mPixelsPerSecond = pixelsPerSecond;
//		return this;
//	}
//	
//	public Builder setX(float x) {
//		mX = x;
//		return this;
//	}
//	
//	public Builder setY(float y) {
//		mY = y;
//		return this;
//	}
//	
//	public Builder setAngle(double angle) {
//		mAngle = angle;
//		return this;
//	}
//	
//	public Builder setRadiusPixels(float pixels) {
//		mRadiusPixels = pixels;
//		return this;
//	}
//}


/**
 * @param other Another 2d shape
 * @return Whether this shape is intersecting with the other.
 */
//public boolean isIntersecting(Shape2d other) {
//	return getLeft() <= other.getRight() && getRight() >= other.getLeft()
//	&& getTop() <= other.getBottom() && getBottom() >= other.getTop();
//}
-(BOOL)isIntersectingWithLine:(AnimatingLine*)iOther{
	return ([self getLeft]<=[iOther getRight])&& 
	([self getRight]>=[iOther getLeft])&&
	([self getTop]<=[iOther getBottom])&&
	([self getBottom]>=[iOther getTop]);
}

/**
 * @param x An x coordinate
 * @param y A y coordinate
 * @return Whether the point is within this shape
 */
//public boolean isPointWithin(float x, float y) {
//	return (x > getLeft() && x < getRight()
//			&& y > getTop() && y < getBottom());	
//}
-(BOOL)isPointWithin:(int)iX:(int)iY{
	return (iX > [self getLeft] && iX < [self getRight]	
			&& iY >[self getTop] && iY < [self getBottom]);
}

//public float getArea() {
//	return getHeight() * getWidth();
//}
-(float)getArea{
	return [self getWidth]*[self getHeight];
}

//public float getWidth () {
//	return getRight() - getLeft();
//}
-(float)getWidth{
	return [self getRight] - [self getLeft];
}

//public float getHeight() {
//	return getBottom() - getTop();
//}
-(float)getHeight{
	return [self getBottom] - [self getTop];
}
@end
