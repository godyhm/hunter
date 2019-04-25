//
//  Explosion.h
//  hunter
//
//  Created by AAA on 11-7-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

@interface Explosion : NSObject {
	long int mLastUpdate;
	long int mProgress;
	float mX;
	float mY;
	UIImage* mExplosion1;
	UIImage* mExplosion2;
	UIImage* mExplosion3;
	float mRadius;
}

@property long int mLastUpdate;

-(id)initExplosion:(long int)lastupdate:(float )x:(float)y:
(UIImage*)explosion1:(UIImage*)explosion2:(UIImage*)explosion3;
-(void)drawExplosionImage;
-(void)updateInExplosion:(long int)now;
-(BOOL)done;

@end
