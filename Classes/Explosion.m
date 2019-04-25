//
//  Explosion.m
//  hunter
//
//  Created by AAA on 11-7-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Explosion.h"


@implementation Explosion

@synthesize mLastUpdate;

//Explosion(long mLastUpdate, float mX, float mY,
//		  Bitmap explosion1, Bitmap explosion2, Bitmap explosion3) {
//	this.mLastUpdate = mLastUpdate;
//	this.mX = mX;
//	this.mY = mY;
//	this.mExplosion1 = explosion1;
//	this.mExplosion2 = explosion2;
//	this.mExplosion3 = explosion3;
//	mRadius = ((float) mExplosion1.getWidth()) / 2f;
//	
//}
-(id)initExplosion:(long int)lastupdate:(float )x:(float)y:
(UIImage*)explosion1:(UIImage*)explosion2:(UIImage*)explosion3;
{
	self = [super init];
	if (self) {
		mLastUpdate = lastupdate;
		mX = x;
		mY = y;
		mExplosion1 = explosion1;
		mExplosion2 = explosion2;
		mExplosion3 = explosion3;
		mRadius = [mExplosion1 size].width/2.0f;
	}
	return self;
}

//public void setNow(long now) {
//	mLastUpdate = now;
//}

//public void update(long now) {
//	mProgress += (now - mLastUpdate);
//	mLastUpdate = now;
//}
-(void)updateInExplosion:(long int)now
{
	mProgress += now-mLastUpdate;
	mLastUpdate = now;
}

//public void draw(Canvas canvas, Paint paint) {
//	if (mProgress < 80L) {
//		canvas.drawBitmap(mExplosion1, mX - mRadius, mY - mRadius, paint);
//	} else if (mProgress < 160L) {
//		canvas.drawBitmap(mExplosion2, mX - mRadius, mY - mRadius, paint);
//	} else if (mProgress < 400L) {
//		canvas.drawBitmap(mExplosion3, mX - mRadius, mY - mRadius, paint);
//	}
//}
-(void)drawExplosionImage
{
	if (mProgress < 80L) {
		[mExplosion1 drawAtPoint:(CGPointMake( mX - mRadius, mY - mRadius))];
	} else if (mProgress < 160L) {
		[mExplosion2 drawAtPoint:(CGPointMake( mX - mRadius, mY - mRadius))];
	} else if (mProgress < 400L) {
		[mExplosion3 drawAtPoint:(CGPointMake( mX - mRadius, mY - mRadius))];
	}
}

//public boolean done() {
//	return mProgress > 700L;
//}
-(BOOL)done
{
	return mProgress >700l;
}

- (void)dealloc {
//	[mExplosion1 release];
//	[mExplosion2 release];
//	[mExplosion3 release];
	[super dealloc];
}
@end
