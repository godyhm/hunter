//
//  AnimatingLine.m
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "AnimatingLine.h"

/**
 * Keeps the state for the line that extends in two directions until it hits its boundaries.  This is triggered
 * by the user gesture in a horizontal or vertical direction.
 */
@implementation AnimatingLine

@synthesize mStart;
@synthesize mEnd;
@synthesize mMin;
@synthesize mMax;
@synthesize mLastUpdate;
@synthesize mPerpAxisOffset;
@synthesize mDirection;
/**
 * @param direction The direction of the line
 * @param now What 'now' is
 * @param axisStart Where on the perpendicular axis the line is extending from
 * @param start The point the line is extending from on the parallel axis
 * @param min The lower bound for the line (i.e the left most point)
 * @param max The upper bound for the line (i.e the right most point)
 */
//public AnimatingLine(
//					 Direction direction,
//					 long now,
//					 float axisStart,
//					 float start,
//					 float min, float max) {
//	mDirection = direction;
//	mLastUpdate = now;
//	mPerpAxisOffset = axisStart;
//	mStart = mEnd = start;
//	mMin = min;
//	mMax = max;
//}
-(id)initWithLineParams:(Direction)direction:(long int)now:
(float)axisStart:(float)start:(float)min:(float)max
{
	self = [super init];
	if (self) {
		mDirection = direction;
		mLastUpdate = now;
		mPerpAxisOffset = axisStart;
		mStart = mEnd = start;
		mMin = min;
		mMax = max;
		mPixelsPerSecond = 101.0f;
	}
	return self;
}

//public Direction getDirection() {
//	return mDirection;
//}
-(Direction)getLineDirection
{
	return mDirection;
}

//public void setNow(long now) {
//	mLastUpdate = now;
//}
//public float getPerpAxisOffset() {
//	return mPerpAxisOffset;
//}
//
//public float getStart() {
//	return mStart;
//}
//
//public float getEnd() {
//	return mEnd;
//}
//
//public float getMin() {
//	return mMin;
//}
//
//public float getMax() {
//	return mMax;
//}


//public float getLeft() {
//	return mDirection == Direction.Horizontal ? mStart : mPerpAxisOffset;
//}
-(float)getLeft
{
	return mDirection ==  Horizontal ? mStart : mPerpAxisOffset;
}

//public float getRight() {
//	return mDirection == Direction.Horizontal ? mEnd : mPerpAxisOffset;
//}
-(float)getRight
{
	return mDirection ==  Horizontal ? mEnd : mPerpAxisOffset;
}

//public float getTop() {
//	return mDirection == Direction.Vertical ? mStart : mPerpAxisOffset;
//}
-(float)getTop
{
	return mDirection ==  Vertical ? mStart : mPerpAxisOffset;
}

//public float getBottom() {
//	return mDirection == Direction.Vertical ? mEnd : mPerpAxisOffset;
//}
-(float)getBottom
{
	return mDirection == Vertical ? mEnd : mPerpAxisOffset;
}

//public float getPercentageDone() {
//	return (mEnd - mStart) / (mMax - mMin);
//}
-(float)getPercentageDone
{
	return (mEnd - mStart) / (mMax - mMin);
}

/**
 * Extend the line according to the animation.
 * @return whether the line has reached its end.
 */
//public boolean update(long time) {
//	if (time == mLastUpdate) return false;
//	float delta = (time - mLastUpdate) * mPixelsPerSecond;
//	delta = delta / 1000;
//	mLastUpdate = time;
//	mStart -= delta;
//	mEnd += delta;
//	
//	if (mStart < mMin) mStart = mMin;
//	if (mEnd > mMax) mEnd = mMax;
//	
//	return mStart == mMin && mEnd == mMax;
//}
-(BOOL)update:(long int)time
{
	if (time == mLastUpdate) 
		return false;
	float delta = (time - mLastUpdate) * mPixelsPerSecond;
	delta = delta / 3.0f;
	mLastUpdate = time;
	mStart -= delta;
	mEnd += delta;
	
	if (mStart < mMin) mStart = mMin;
	if (mEnd > mMax) mEnd = mMax;
	
	return mStart == mMin && mEnd == mMax;
}


/**
 * @param other Another 2d shape
 * @return Whether this shape is intersecting with the other.
 */
//public boolean isIntersecting(Shape2d other) {
//	return getLeft() <= other.getRight() && getRight() >= other.getLeft()
//	&& getTop() <= other.getBottom() && getBottom() >= other.getTop();
//}
//-(BOOL)isIntersecting:(Shape2D*)iOther{
//	return ([self getLeft]<=[iOther getRight])&& 
//	([self getRight]>=[iOther getLeft])&&
//	([self getTop]<=[iOther getBottom])&&
//	([self getBottom]>=[iOther getTop]);
//}

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
