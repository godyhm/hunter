//
//  BallRegion.m
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Ball.h"
#import "AnimatingLine.h"
#import "BallRegion.h"
/**
 * A ball region is a rectangular region that contains bouncing
 * balls, and possibly one animating line.  In its {@link #update(long)} method,
 * it will update all of its balls, the moving line.  It detects collisions
 * between the balls and the moving line, and when the line is complete, handles
 * splitting off a new region.
 */

@implementation BallRegion

@synthesize mBallEventDeleGateInBallRegion;
@synthesize mBalls;
@synthesize mAnimatingLine;
@synthesize mDoneShrinking;

/*
 * @param left The minimum x component
 * @param right The maximum x component
 * @param top The minimum y component
 * @param bottom The maximum y component
 * @param balls the balls of the region
 */
//public BallRegion(long now, float left, float right, float top, float bottom,
//				  ArrayList<Ball> balls) {
//	mLastUpdate = now;
//	mLeft = left;
//	mRight = right;
//	mTop = top;
//	mBottom = bottom;
//	
//	mBalls = balls;
//	final int numBalls = mBalls.size();
//	for (int i = 0; i < numBalls; i++) {
//		final Ball ball = mBalls.get(i);
//		ball.setRegion(this);
//	}
//	checkShrinkToFit();
//}
-(id)initWithBallRegionParams:(long int)now:(float)left:(float)right:(float)top:
(float)bottom:(NSMutableArray*)balls
{
	self = [super init];
	if(self){
		mLastUpdate = now;
		mLeft = left;
		mRight = right;
		mTop = top;
		mBottom = bottom;
	    mDoneShrinking = false;
		
		self.mBalls = balls;
		int numBalls = [mBalls count];
		for (int i = 0; i < numBalls; i++) {
			Ball* ball = [mBalls objectAtIndex:(NSUInteger)i];
			[ball setRegion:self];
//			if ([ball isKindOfClass:[Ball class]]) {
//			   [ball setRegion:self];
//			}else
//			{
//				NSLog(@"Something gone wrong");
//			}
			
		}
		[self checkShrinkToFit];
	}
	return self;
}

//public void setCallBack(BallEngine.BallEventCallBack callBack) {
//	this.mCallBack = new WeakReference<BallEngine.BallEventCallBack>(callBack);
//}
//private void checkShrinkToFit() {
//	final float area = getArea();
//	if (area < SHRINK_TO_FIT_AREA_THRESH) {
//		mShrinkingToFit = true;
//	} else if (area < SHRINK_TO_FIT_AREA_THRESH_ONE_BALL && mBalls.size() == 1) {
//		mShrinkingToFit = true;
//	}
//}
-(void)checkShrinkToFit
{
	float area = [self getArea ];
	if (area < SHRINK_TO_FIT_AREA_THRESH) {
		mShrinkingToFit = true;
	} else if (area < SHRINK_TO_FIT_AREA_THRESH_ONE_BALL && [mBalls count] == 1) {
		mShrinkingToFit = true;
	}
}

//public float getLeft() {
//	return mLeft;
//}
-(float)getLeft
{
	return mLeft;
}

//public float getRight() {
//	return mRight;
//}
-(float)getRight
{
	return mRight;
}

//public float getTop() {
//	return mTop;
//}
-(float)getTop
{
	return mTop;
}

//public float getBottom() {
//	return mBottom;
//}
-(float)getBottom
{
	return mBottom;
}

//public AnimatingLine getAnimatingLine() {
//	return mAnimatingLine;
//}
//public List<Ball> getBalls() {
//	return mBalls;
//}
//-(NSMutableArray*)getBalls
//{
//	return mBalls;
//}


//public boolean consumeDoneShrinking() {
//	if (mDoneShrinking) {
//		mDoneShrinking = false;
//		return true;
//	}
//	return false;
//}
-(BOOL)consumeDoneShrinking
{
	if (mDoneShrinking) {
		mDoneShrinking = false;
		return true;
	}
	return false;
}

//public void setNow(long now) {
//	mLastUpdate = now;
//	
//	// update the balls
//	final int numBalls = mBalls.size();
//	for (int i = 0; i < numBalls; i++) {
//		final Ball ball = mBalls.get(i);
//		ball.setNow(now);
//	}
//	
//	if (mAnimatingLine != null) {
//		mAnimatingLine.setNow(now);
//	}
//}
-(void)setNow:(long int)now
{
	mLastUpdate = now;
	
	// update the balls
	int numBalls = [mBalls count];
	for (int i = 0; i < numBalls; i++) {
		Ball* ball = [mBalls objectAtIndex:(NSUInteger)i];
		ball.mLastUpdate=now;
	}
	
	if (mAnimatingLine != nil) {
		mAnimatingLine.mLastUpdate = now;
	}
}

/**
 * Update the balls an (if it exists) the animating line in this region.
 * @param now in millis
 * @return A new region if a split has occured because the animating line
 *     finished.
 */
//public BallRegion update(long now) {
//	
//	// update the animating line
//	final boolean newRegion =
//	(mAnimatingLine != null && mAnimatingLine.update(now));
//	
//	final int numBalls = mBalls.size();
//	
//	// move balls, check for collision with animating line
//	for (int i = 0; i < numBalls; i++) {
//		final Ball ball = mBalls.get(i);
//		ball.update(now);
//		if (mAnimatingLine != null && ball.isIntersecting(mAnimatingLine)) {
//			mAnimatingLine = null;
//			if (mCallBack != null) mCallBack.get().onBallHitsLine(now, ball, mAnimatingLine);
//		}
//	}
//	
//	// update ball to ball collisions
//	for (int i = 0; i < numBalls; i++) {
//		final Ball ball = mBalls.get(i);
//		for (int j = i + 1; j < numBalls; j++) {
//			Ball other = mBalls.get(j);
//			if (ball.isCircleOverlapping(other)) {
//				Ball.adjustForCollision(ball, other);
//				break;
//			}
//		}
//	}        
//	
//	handleShrinkToFit(now);
//	
//	// no collsion, new region means we need to split out the apropriate
//	// balls into a new region
//	if (newRegion && mAnimatingLine != null) {
//		BallRegion otherRegion = splitRegion(
//											 now,
//											 mAnimatingLine.getDirection(),
//											 mAnimatingLine.getPerpAxisOffset());
//		mAnimatingLine = null;
//		return otherRegion;
//	} else {
//		return null;
//	}
//}
-(BallRegion*)updateRegion:(long int)now
{
	
	// update the animating line
	BOOL lineFinished = [mAnimatingLine update:now];
	if (lineFinished) {
		NSLog(@"line has finished");
	}
	BOOL newRegion =(mAnimatingLine != nil && lineFinished);//[mAnimatingLine update:now]);
	
	int numBalls = [mBalls count];
	
	// move balls, check for collision with animating line
	for (int i = 0; i < numBalls; i++) {
		Ball* ball = [mBalls objectAtIndex:(NSUInteger)i];
		[ball update:now];
		if (mAnimatingLine != nil && [ball isIntersectingWithLine:mAnimatingLine]) {
			mAnimatingLine = nil;
			if (mBallEventDeleGateInBallRegion != nil) 
				[mBallEventDeleGateInBallRegion onBallHitsLine:now:ball:mAnimatingLine];
		}
	}
	
	// update ball to ball collisions
	for (int i = 0; i < numBalls; i++) {
		Ball* ball = [mBalls objectAtIndex:(NSUInteger)i];
		for (int j = i + 1; j < numBalls; j++) {
			Ball* other =[mBalls objectAtIndex:(NSUInteger)i];
			if ([ball isCircleOverlapping:other]) {
				[Ball adjustForCollision:ball:other];
				break;
			}
		}
	}        
	
	[self handleShrinkToFit:now];
	
	// no collsion, new region means we need to split out the apropriate
	// balls into a new region
	if (newRegion && mAnimatingLine != nil) {
		BallRegion* otherRegion =[self splitRegion:now:[mAnimatingLine getLineDirection]:mAnimatingLine.mPerpAxisOffset];
		mAnimatingLine = nil;
		return otherRegion;
	} else {
		return nil;
	}
}

//private void handleShrinkToFit(long now) {
//	// update shrinking to fit
//	if (mShrinkingToFit && mAnimatingLine == null) {
//		if (now == mLastUpdate) return;
//		float delta = (now - mLastUpdate) * PIXELS_PER_SECOND;
//		delta = delta / 1000;
//		
//		if (getHeight()  > MIN_EDGE) {
//			mTop += delta;
//			mBottom -= delta;
//		}
//		if (getWidth() > MIN_EDGE) {
//			mLeft += delta;
//			mRight -= delta;                
//		}
//		
//		final int numBalls = mBalls.size();
//		for (int i = 0; i < numBalls; i++) {
//			final Ball ball = mBalls.get(i);
//			ball.setRegion(this);
//		}
//		if (getArea() <= SHRINK_TO_FIT_AREA) {
//			mShrinkingToFit = false;
//			mDoneShrinking = true;
//		}
//	}
//	mLastUpdate = now;
//}
-(void)handleShrinkToFit:(long int)now
{
	// update shrinking to fit
	if (mShrinkingToFit && mAnimatingLine == nil) {
		if (now == mLastUpdate) return;
		float delta = (now - mLastUpdate) * PIXELS_PER_SECOND;
		delta = delta / 3.0f;
		
		if ([self getHeight ]  > MIN_EDGE) {
			mTop += delta;
			mBottom -= delta;
		}
		if ([self getWidth ] > MIN_EDGE) {
			mLeft += delta;
			mRight -= delta;                
		}
		
		int numBalls = [mBalls count];
		for (int i = 0; i < numBalls; i++) {
			Ball* ball = [mBalls objectAtIndex:(NSUInteger)i];
			[ball setRegion:self];
		}
		if ([self getArea ] <= SHRINK_TO_FIT_AREA) {
			mShrinkingToFit = false;
			mDoneShrinking = true;
		}
	}
	mLastUpdate = now;
}

/**
 * Return whether this region can start a line at a certain point.
 */
//public boolean canStartLineAt(float x, float y) {
//	return !mShrinkingToFit && mAnimatingLine == null && isPointWithin(x, y);
//}
-(BOOL)canStartLineAt:(float)x:(float)y
{
	return !mShrinkingToFit && mAnimatingLine == nil && [self isPointWithin:x:y];
}

/**
 * Start a horizontal line at a point.
 * @param now What 'now' is.
 * @param x The x coordinate.
 * @param y The y coordinate.
 */
//public void startHorizontalLine(long now, float x, float y) {
//	if (!canStartLineAt(x, y)) {
//		throw new IllegalArgumentException(
//										   "can't start line with point (" + x + "," + y + ")");
//	}
//	mAnimatingLine =
//	new AnimatingLine(Direction.Horizontal, now, y, x, mLeft, mRight);
//}
-(void)startHorizontalLine:(long int)now:(float)x:(float)y
{
	if (![self canStartLineAt:x:y]) {
		//throw new IllegalArgumentException(
		//								   "can't start line with point (" + x + "," + y + ")");
	}
	mAnimatingLine = [[AnimatingLine alloc] 
					  initWithLineParams:Horizontal
					  :now
					  :y
					  :x
					  :mLeft
					  :mRight];
}

/**
 * Start a vertical line at a point.
 * @param now What 'now' is.
 * @param x The x coordinate.
 * @param y The y coordinate.
 */
//public void startVerticalLine(long now, float x, float y) {
//	if (!canStartLineAt(x, y)) {
//		throw new IllegalArgumentException(
//										   "can't start line with point (" + x + "," + y + ")");
//	}
//	mAnimatingLine =
//	new AnimatingLine(Direction.Vertical, now, x, y, mTop, mBottom);
//}
-(void)startVerticalLine:(long int)now:(float)x:(float)y
{
	if (![self canStartLineAt:x:y]) {
//		throw new IllegalArgumentException(
//										   "can't start line with point (" + x + "," + y + ")");
	}
	mAnimatingLine = [[AnimatingLine alloc] 
					  initWithLineParams:Vertical
					  :now
					  :x
					  :y
					  :mTop
					  :mBottom];
}

/**
 * Splits this region at a certain offset, shrinking this one down and returning
 * the other region that makes up the rest.
 * @param direction The direction of the line.
 * @param perpAxisOffset The offset of the perpendicular axis of the line.
 * @return A new region containing a portion of the balls.
 */
//private BallRegion splitRegion(long now, Direction direction, float perpAxisOffset) {
//	
//	ArrayList<Ball> splitBalls = new ArrayList<Ball>();
//	
//	if (direction == Direction.Horizontal) {
//		Iterator<Ball> it = mBalls.iterator();
//		while (it.hasNext()) {
//			Ball ball = it.next();
//			if (ball.getY() > perpAxisOffset) {
//				it.remove();
//				splitBalls.add(ball);
//			}
//		}
//		float oldBottom = mBottom;
//		mBottom = perpAxisOffset;
//		checkShrinkToFit();
//		final BallRegion region = new BallRegion(now, mLeft, mRight, perpAxisOffset,
//												 oldBottom, splitBalls);
//		region.setCallBack(mCallBack.get());
//		return region;
//	} else  {
//		assert(direction == Direction.Vertical);
//		Iterator<Ball> it = mBalls.iterator();
//		while (it.hasNext()) {
//			Ball ball = it.next();
//			if (ball.getX() > perpAxisOffset) {
//				it.remove();
//				splitBalls.add(ball);
//			}
//		}
//		float oldRight = mRight;
//		mRight = perpAxisOffset;
//		checkShrinkToFit();
//		final BallRegion region = new BallRegion(now, perpAxisOffset, oldRight, mTop,
//												 mBottom, splitBalls);
//		region.setCallBack(mCallBack.get());
//		return region;
//	}
//}
-(BallRegion*)splitRegion:(long int)now:(Direction)direction:(float)perpAxisOffset
{
	//NSMutableArray* splitBalls = [NSMutableArray arrayWithCapacity:(NSUInteger)0];
	//NSMutableArray* splitBalls = [[NSMutableArray alloc] init];
	NSMutableArray* splitBalls = [[NSMutableArray array] retain];
	if (direction == Horizontal) {
		int numBalls = [mBalls count];
		for (int i=0;i<numBalls; i++) {
			Ball* ball = [mBalls objectAtIndex:(NSUInteger)i];
			if(ball.mY>perpAxisOffset){
				[splitBalls addObject:(id)ball];
				//[mBalls removeObjectAtIndex:(NSUInteger)i];				
			}
		}
		[mBalls removeObjectsInArray:splitBalls];
		
		float oldBottom = mBottom;
		mBottom = perpAxisOffset;
		[self checkShrinkToFit];
		BallRegion* region = [[[BallRegion alloc] initWithBallRegionParams
							 :now
							 :mLeft
							 :mRight
							 :perpAxisOffset
							 :oldBottom
							 :splitBalls] autorelease];
		region.mBallEventDeleGateInBallRegion = self.mBallEventDeleGateInBallRegion;
		[splitBalls release];
		return region ;
	} else  {
		assert(direction == Vertical);
		int numBalls = [mBalls count];
		for (int i=0;i<numBalls; i++) {
			Ball* ball = [mBalls objectAtIndex:(NSUInteger)i];
			if([ball mY]>perpAxisOffset){
				[splitBalls addObject:(id)ball];
				//[mBalls removeObjectAtIndex:(NSUInteger)i];				
			}
		}
		[mBalls removeObjectsInArray:splitBalls];
		float oldRight = mRight;
		mRight = perpAxisOffset;
		[self checkShrinkToFit];
		BallRegion* region = [[[BallRegion alloc] initWithBallRegionParams
							 :now
							 :perpAxisOffset
							 :oldRight
							 :mTop
							 :mBottom
							 :splitBalls] autorelease];
		region.mBallEventDeleGateInBallRegion = self.mBallEventDeleGateInBallRegion;
		[splitBalls release];
		return region;
	}
}

- (void)dealloc {
	[mBalls release];
	[mAnimatingLine release];
	[super dealloc];
}




/**
 * @param other Another 2d shape
 * @return Whether this shape is intersecting with the other.
 */
//public boolean isIntersecting(Shape2d other) {
//	return getLeft() <= other.getRight() && getRight() >= other.getLeft()
//	&& getTop() <= other.getBottom() && getBottom() >= other.getTop();
//}
//-(BOOL)isIntersecting:(BallRegion*)iOther{
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
