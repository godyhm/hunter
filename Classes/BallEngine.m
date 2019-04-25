//
//  BallEngine.m
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "Ball.h"
#import "BallRegion.h"
#import "BallEngine.h"

/**
 * Keeps track of the current state of balls bouncing around within a a set of
 * regions.
 *
 * Note: 'now' is the elapsed time in milliseconds since some consistent point in time.
 * As long as the reference point stays consistent, the engine will be happy, though
 * typically this is {@link android.os.SystemClock#elapsedRealtime()} 
 */
@implementation BallEngine

@synthesize mBallEventDeleGateInBallEngine;
@synthesize mRegions;
@synthesize mNewRegions;

//public BallEngine(float minX, float maxX,
//				  float minY,
//				  float maxY,
//				  float ballSpeed,
//				  float ballRadius) {
//	mMinX = minX;
//	mMaxX = maxX;
//	mMinY = minY;
//	mMaxY = maxY;
//	mBallSpeed = ballSpeed;
//	mBallRadius = ballRadius;
//}
-(id)initWithBallEngineParams:(float)minX:(float)maxX:(float)minY:(float)maxY:
(float)ballSpeed:(float)ballRadius
{
	self = [super init];
	if(self){
		mBallEventDeleGateInBallEngine = nil;
		mMinX = minX;
		mMaxX = maxX;
		mMinY = minY;
		mMaxY = maxY;
		mBallSpeed = ballSpeed;
		mBallRadius = ballRadius;
		mNewRegions = [[NSMutableArray alloc] init];
		mRegions = [[NSMutableArray alloc] init];
	}
	return self;
}

//public void setCallBack(BallEventCallBack mCallBack) {
//	this.mCallBack = mCallBack;
//}
/**
 * Update the notion of 'now' in milliseconds.  This can be usefull
 * when unpausing for instance.
 * @param now Milliseconds since some consistent point in time.
 */
//public void setNow(long now) {
//	for (int i = 0; i < mRegions.size(); i++) {
//		final BallRegion region = mRegions.get(i);
//		region.setNow(now);
//	}
//}
-(void)setNow:(long int)now
{
	for (int i = 0; i < [mRegions count]; i++) {
		BallRegion* region = [mRegions objectAtIndex:i];
		[region setNow:now];
	}	
}

/**
 * Rest the engine back to a single region with a certain number of balls
 * that will be placed randomly and sent in random directions.
 * @param now milliseconds since some consistent point in time.
 * @param numBalls
 */
//public void reset(long now, int numBalls) {
//	mRegions.clear();
//	
//	ArrayList<Ball> balls = new ArrayList<Ball>(numBalls);
//	for (int i = 0; i < numBalls; i++) {
//		Ball ball = new Ball.Builder()
//		.setNow(now)
//		.setPixelsPerSecond(mBallSpeed)
//		.setAngle(Math.random() * 2 * Math.PI)
//		.setX((float) Math.random() * (mMaxX - mMinX) + mMinX)
//		.setY((float) Math.random() * (mMaxY - mMinY) + mMinY)
//		.setRadiusPixels(mBallRadius)
//		.create();
//		balls.add(ball);
//	}
//	BallRegion region = new BallRegion(now, mMinX, mMaxX, mMinY, mMaxY, balls);
//	region.setCallBack(mCallBack);
//	
//	mRegions.add(region);
//}
-(void)reset:(long int)now:(int)numBalls
{
	[mRegions removeAllObjects];
	
	NSMutableArray* balls = [[NSMutableArray alloc] init];
	for (int i = 0; i < numBalls; i++) {
		Ball *ball = [[Ball alloc] initWithBallParams
					  :now 
					  :mBallSpeed 
					  :((float)(arc4random()%100)/100) * (mMaxX - mMinX) + mMinX 
					  :((float)(arc4random()%100)/100) * (mMaxY - mMinY) + mMinY 
					  :((float)(arc4random()%100)/100) * 2 * M_PI 
					  :mBallRadius];
		[balls addObject:(id)ball];
		[ball release];
	}
	BallRegion* region = [[BallRegion alloc] initWithBallRegionParams
						  :now
						  :mMinX
						  :mMaxX
						  :mMinY
						  :mMaxY
						  :balls];

	region.mBallEventDeleGateInBallRegion=mBallEventDeleGateInBallEngine;	
	[mRegions addObject:(id)region];
	[region release];	
	[balls release];
}

//public List<BallRegion> getRegions() {
//	return mRegions;
//}

//public float getPercentageFilled() {
//	float total = 0f;
//	for (int i = 0; i < mRegions.size(); i++) {
//		BallRegion region = mRegions.get(i);
//		total += region.getArea();
//		Log.d("Balls", "total now " + total);
//	}
//	return 1f - (total / getArea());
//}
-(float)getPercentageFilled
{
	float total = 0.0f;
	for (int i = 0; i < [mRegions count]; i++) {
		BallRegion* region = [mRegions objectAtIndex:(NSUInteger)i];
		total += [region getArea];
		//Log.d("Balls", "total now " + total);
	}
	return 1.0f - (total / [self getArea]);
}

/**
 * @return the area in the region in pixel*pixel
 */
//public float getArea() {
//	return (mMaxX - mMinX) * (mMaxY - mMinY);
//}
-(float)getArea
{
	return (mMaxX - mMinX) * (mMaxY - mMinY);
}

/**
 * Can any of the regions within start a line at this point?
 * @param x The x coordinate.
 * @param y The y coordinate
 * @return Whether a region can start a line.
 */
//public boolean canStartLineAt(float x, float y) {
//	for (BallRegion region : mRegions) {
//		if (region.canStartLineAt(x, y)) {
//			return true;
//		}
//	}
//	return false;
//}
-(BOOL)canStartLineAt:(float)x:(float)y
{
	int num = [mRegions count];
	for (int i=0;i<num;i++) {
		BallRegion* region = [mRegions objectAtIndex:(NSUInteger)i];
		if ([region canStartLineAt:x:y]) {
			return true;
		}
	}
	return false;
}

/**
 * Start a horizontal line at a certain point.
 * @throws IllegalArgumentException if there is no region that can start a
 *     line at the point.
 */
//public void startHorizontalLine(long now, float x, float y) {
//	for (BallRegion region : mRegions) {
//		if (region.canStartLineAt(x, y)) {
//			region.startHorizontalLine(now, x, y);
//			return;
//		}
//	}
//	throw new IllegalArgumentException("no region can start a new line at "
//									   + x + ", " + y + ".");
//}
-(void)startHorizontalLine:(long int)now:(float)x:(float)y
{
	int num = [mRegions count];
	for (int i=0;i<num;i++) {
		BallRegion* region = [mRegions objectAtIndex:(NSUInteger)i];
		if ([region canStartLineAt:x:y]) {
			[region startHorizontalLine:now :x :y];
			return ;
		}
	}
	//throw new IllegalArgumentException("no region can start a new line at "+ x + ", " + y + ".");
}

/**
 * Start a vertical line at a certain point.
 * @throws IllegalArgumentException if there is no region that can start a
 *     line at the point.
 */
//public void startVerticalLine(long now, float x, float y) {
//	for (BallRegion region : mRegions) {
//		if (region.canStartLineAt(x, y)) {
//			region.startVerticalLine(now, x, y);
//			return;
//		}
//	}
//	throw new IllegalArgumentException("no region can start a new line at "
//									   + x + ", " + y + ".");
//}
-(void)startVerticalLine:(long int)now:(float)x:(float)y
{
	int num = [mRegions count];
	for (int i=0;i<num;i++) {
		BallRegion* region = [mRegions objectAtIndex:(NSUInteger)i];
		if ([region canStartLineAt:x:y]) {
			[region startVerticalLine:now :x :y];
			return ;
		}
	}
//  throw new IllegalArgumentException("no region can start a new line at "+ x + ", " + y + ".");
}

/**
 * @param now The latest notion of 'now'
 * @return whether any new regions were added by the update.
 */
//public boolean update(long now) {
//	boolean regionChange = false;
//	Iterator<BallRegion> it = mRegions.iterator();
//	while (it.hasNext()) {
//		final BallRegion region = it.next();
//		final BallRegion newRegion = region.update(now);
//		
//		if (newRegion != null) {
//			regionChange = true;
//			if (!newRegion.getBalls().isEmpty()) {
//				mNewRegions.add(newRegion);
//			}
//			
//			// current region may not have any balls left
//			if (region.getBalls().isEmpty()) {
//				it.remove();
//			}
//		} else if (region.consumeDoneShrinking()) {
//			regionChange = true;
//		}
//	}
//	mRegions.addAll(mNewRegions);
//	mNewRegions.clear();
//	
//	return regionChange;
//}
-(BOOL)update:(long int)now
{
	BOOL regionChange = false;
	int cnt = [mRegions count];
	for(int i=0;i<cnt;i++){
		BallRegion* region = [mRegions objectAtIndex:(NSUInteger)i];
		BallRegion* newRegion = [region updateRegion:now];
		if(newRegion!=nil){
			regionChange = true;
			if ([newRegion.mBalls count]>0) {
				[mNewRegions addObject:(id)newRegion];				
			}
			// current region may not have any balls left
			if ([region.mBalls count]==0) {
				[mRegions removeObjectAtIndex:(NSUInteger)i];
			}
		}else if ([region consumeDoneShrinking]) {
			regionChange = true;
		}
	}
	[mRegions addObjectsFromArray:(NSArray *)mNewRegions];
	//needed or not?
	[mNewRegions removeAllObjects];
	return regionChange;	
}

- (void)dealloc {
	[mNewRegions release];
	[mRegions release];
	[super dealloc];
}
@end
