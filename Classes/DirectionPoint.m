//
//  DirectionPoint.m
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DirectionPoint.h"

/**
 * To specify a dividing line, a user hits the screen and drags in a
 * certain direction.  Once the line has been drawn long enough and mostly
 * in a particular direction (vertical, or horizontal), we can decide we
 * know what they mean.  Otherwise, it is unknown.
 *
 * This is also nice because if the user decides they don't want to send
 * a dividing line, they can just drag their finger back to where they first
 * touched and let go, cancelling.
 */
@implementation DirectionPoint

@synthesize mX;
@synthesize mY;

//public DirectionPoint(float x, float y) {
//	mX = x;
//	mY = y;
//	endLineX = x;
//	endLineY = y;
//}
-(id)initWithDirectionPointParams:(float)x:(float)y
{
	self = [super init];
	if (self) {
		mX = x;
		mY = y;
		endLineX = x;
		endLineY = y;
	}
	return self;
}

//public void updateEndPoint(float x, float y) {
//	endLineX = x;
//	endLineY = y;
//}
-(void)updateEndPoint:(float)x:(float)y
{
	endLineX = x;
	endLineY = y;
}

//public float getX() {
//	return mX;
//}
//
//public float getY() {
//	return mY;
//}
/**
 * We know the direction when the line is at leat 20 pixels long,
 * and the angle is no more than PI / 6 away from a definitive direction.
 */
//public AmbiguousDirection getDirection() {
//	float dx = endLineX - mX;
//	double distance = Math.hypot(dx, endLineY - mY);
//	if (distance < 10) {
//		return AmbiguousDirection.Unknown;
//	}
//	double angle = Math.acos(dx / distance);
//	double thresh = Math.PI / 6;
//	if ((angle < thresh || (angle > (Math.PI - thresh)))) {
//		return AmbiguousDirection.Horizonal;
//	}
//	if ((angle > 2 * thresh) && angle < 4*thresh) {
//		return AmbiguousDirection.Vertical;
//	}
//	return AmbiguousDirection.Unknown;
//}
-(AmbiguousDirection)getPointDirection
{
	float dx = abs(endLineX - mX);
	double distance = hypot((double)dx,(double)(endLineY - mY));
	if (distance < 10) {
		return PointUnknown;
	}
	
	double rate = dx/distance;
	if(rate <=cos(M_PI/6.0f)){
		return PointVertical;
	}else {
		return PointHorizonal;
	}
//	double angle = acosh(dx / distance);
//	double thresh = M_PI / 6;
//	if (angle < thresh || (angle > (M_PI - thresh))) {
//		return PointHorizonal;
//	}
//	if ((angle > 2 * thresh) && angle < 4*thresh) {
//		return PointVertical;
//	}
	return PointUnknown;
}
@end
