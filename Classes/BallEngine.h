//
//  BallEngine.h
//  hunter
//
//  Created by AAA on 11-6-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "BallEventDeleGate.h"
@class BallRegion;

@interface BallEngine : NSObject {
	float mMinX;
	float mMaxX;
	float mMinY;
	float mMaxY;
	float mBallSpeed;
	float mBallRadius;
	id<BallEventDeleGate> mBallEventDeleGateInBallEngine;
	NSMutableArray *mNewRegions;
    NSMutableArray *mRegions;
}

@property (nonatomic,retain)NSMutableArray* mRegions;
@property (nonatomic,retain)NSMutableArray* mNewRegions;
@property (nonatomic,assign)id<BallEventDeleGate> mBallEventDeleGateInBallEngine;

-(id)initWithBallEngineParams:(float)minX:(float)maxX:(float)minY:(float)maxY:(float)ballSpeed:(float)ballRadius;
-(void)setNow:(long int)now;
-(void)reset:(long int)now:(int)numBalls;
-(float)getPercentageFilled;
-(float)getArea;
-(BOOL)canStartLineAt:(float)x:(float)y;
-(void)startHorizontalLine:(long int)now:(float)x:(float)y;
-(void)startVerticalLine:(long int)now:(float)x:(float)y;
-(BOOL)update:(long int)now;
@end
